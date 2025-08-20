import streamlit as st
import pandas as pd
from sqlalchemy import create_engine, text
import pydeck as pdk

# ---------------------------
# Configuração da conexão
# ---------------------------
@st.cache_resource
def init_connection():
    user = "postgres"
    password = ""
    host = "localhost"
    port = "5432"
    db = "postgres"
    return create_engine(f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{db}")

engine = init_connection()

# Funções auxiliares
def run_query(query: str):
    return pd.read_sql(query, engine)

def insert(query: str, params: dict):
    with engine.begin() as conn:
        conn.execute(text(query), params)


# ---------------------------
# Header
# ---------------------------

st.image("assets/logo.png")

# ---------------------------
# Criação das tabs
# ---------------------------
tab1, tab2, tab3, tab4, tab5, tab6= st.tabs(["Bichos","Usuários", "Endereços", "Itens", "Doações","Queries SQL"])


# ---------------------------
# TAB 1: Usuários
# ---------------------------
with tab2:
    st.subheader("Cadastro de Usuários")

    try:
        df = run_query("SELECT * FROM usuarios.usuarios")
        df["saldo"] = df["saldo"].apply(lambda x: f"R$ {x:,.2f}".replace(",", "X").replace(".", ",").replace("X", "."))
        st.dataframe(df, use_container_width=True)
    except Exception as e:
        st.error(f"Erro ao carregar usuários: {e}")

    with st.form("form_usuario"):
        nome = st.text_input("Nome")
        cpf = st.text_input("CPF")
        email = st.text_input("Email")
        saldo = st.number_input("Saldo inicial", min_value=0.0, step=0.01)
        tipo_usuario = st.selectbox(
            "Tipo de usuário",
            ["Voluntário", "Doador", "Empresário", "Profissional"]
        )
        submitted = st.form_submit_button("Cadastrar")

        if submitted:
            try:
                # Inserir na tabela principal
                insert(
                    "INSERT INTO usuarios.usuarios (nome, cpf, email, saldo) VALUES (:nome, :cpf, :email, :saldo)",
                    {"nome": nome, "cpf": cpf, "email": email, "saldo": saldo}
                )
                # Inserir na tabela específica
                tabela = {
                    "Voluntário": "usuarios.voluntarios",
                    "Doador": "usuarios.doadores",
                    "Empresário": "usuarios.empresarios",
                    "Profissional": "usuarios.profissionais"
                }[tipo_usuario]

                insert(f"INSERT INTO {tabela} (cpf) VALUES (:cpf)", {"cpf": cpf})
                st.success(f"Usuário cadastrado com sucesso como {tipo_usuario}!")
                st.rerun()   # <--- força o Streamlit a recarregar tudo
            except Exception as e:
                st.error(f"Erro ao inserir usuário: {e}")

# ---------------------------
# TAB 2: Endereços
# ---------------------------
with tab3:
    st.subheader("Cadastro de Endereços de Usuários")
    try:
        df = run_query("SELECT e.idendereco, e.rua, e.numero, e.complemento, b.nome Bairro,u.nome NomeUsuario FROM enderecos.enderecos e JOIN enderecos.bairros b ON b.idbairro = e.idbairro JOIN usuarios.usuarios u ON u.cpf = e.cpfusuario WHERE e.cpfusuario IS NOT NULL")
        st.dataframe(df, use_container_width=True)
    except Exception as e:
        st.error(f"Erro ao carregar endereços: {e}")

    with st.form("form_enderecos"):
        # Puxar usuários para dropdown
        usuarios = run_query("SELECT cpf, nome FROM usuarios.usuarios")
        bairros = run_query("SELECT idbairro, nome FROM enderecos.bairros")
        usuario_selecionado = st.selectbox(
            "Usuário",
            [f"{row.cpf} - {row.nome}" for idx, row in usuarios.iterrows()]
        )

        bairro_selecionado = st.selectbox(
            "Bairros",
            [f"{row.idbairro} - {row.nome}" for idx, row in bairros.iterrows()]
        )

        rua = st.text_input("Rua")
        numero = st.text_input("Número")
        complemento = st.text_input("Complemento (opcional)")
        submitted = st.form_submit_button("Cadastrar")

        if submitted:
            cpf = usuario_selecionado.split(" - ")[0]
            idbairro = bairro_selecionado.split(" - ")[0]
            try:
                insert(
                    """INSERT INTO enderecos.enderecos 
                    (rua, numero, complemento, cpfusuario, idbairro) 
                    VALUES (:rua, :numero, :complemento, :cpfusuario, :idbairro)""",
                    {"rua": rua, "numero": numero, "complemento": complemento, "cpfusuario": cpf, "idbairro" : idbairro}
                )
                st.success("Endereço cadastrado com sucesso!")
                st.rerun()   # <--- força o Streamlit a recarregar tudo
            except Exception as e:
                st.error(f"Erro ao inserir endereço: {e}")

# ---------------------------
# TAB 3: Itens
# ---------------------------
with tab4:
    st.subheader("Cadastro de Itens")
    try:
        df = run_query("SELECT * FROM itens.itens")
        st.dataframe(df, use_container_width=True)
    except Exception as e:
        st.error(f"Erro ao carregar itens: {e}")

    with st.form("form_itens"):
        nome_item = st.text_input("Nome do Item")
        cod_barra = st.text_input("Código de Barras (opcional)")
        submitted = st.form_submit_button("Cadastrar")

        if submitted:
            try:
                insert(
                    "INSERT INTO itens.itens (nome, codbarra) VALUES (:nome, :codbarra)",
                    {"nome": nome_item, "codbarra": cod_barra}
                )
                st.success("Item cadastrado com sucesso!")
                st.rerun()   # <--- força o Streamlit a recarregar tudo
            except Exception as e:
                st.error(f"Erro ao inserir item: {e}")

# ---------------------------
# TAB 4: Doações
# ---------------------------
# ---------------------------
# TAB 4: Doações
# ---------------------------
with tab5:
    st.subheader("Registrar Doação")
    try:
        df = run_query("SELECT b.Nome Bicho, u.Nome Usuario, d.data, d.valor FROM bichos.doacoes d JOIN bichos.bichos b ON d.idbicho = b.idbicho JOIN usuarios.usuarios u ON d.cpfusuario = u.cpf")
        df["valor"] = df["valor"].apply(lambda x: f"R$ {x:,.2f}".replace(",", "X").replace(".", ",").replace("X", "."))
        st.dataframe(df, use_container_width=True)
    except Exception as e:
        st.error(f"Erro ao carregar doações: {e}")

    with st.form("form_doacoes"):
        # Puxar usuários e bichos para dropdown
        usuarios = run_query("SELECT cpf, nome FROM usuarios.usuarios")
        usuario_selecionado = st.selectbox(
            "Usuário",
            [f"{row.cpf} - {row.nome}" for idx, row in usuarios.iterrows()]
        )

        bichos = run_query("SELECT idbicho, nome FROM bichos.bichos")
        bicho_selecionado = st.selectbox(
            "Bicho",
            [f"{row.idbicho} - {row.nome}" for idx, row in bichos.iterrows()]
        )

        valor = st.number_input("Valor da Doação", min_value=0.0, step=0.01)
        submitted = st.form_submit_button("Registrar")

        if submitted:
            cpf = usuario_selecionado.split(" - ")[0]
            idbicho = int(bicho_selecionado.split(" - ")[0])
            try:
                insert(
                    """INSERT INTO bichos.doacoes (idbicho, cpfusuario, data, valor) 
                    VALUES (:idbicho, :cpfusuario, now(), :valor)""",
                    {"idbicho": idbicho, "cpfusuario": cpf, "valor": valor}
                )
                st.success("Doação registrada com sucesso!")    
                st.rerun()   # <--- força o Streamlit a recarregar tudo
            except Exception as e:
                st.error(f"Erro ao registrar doação: {e}")
# ---------------------------
# TAB 5: Bichos
# ---------------------------
with tab1:
    st.subheader("Cadastro de Bichos")

    # --- Mostrar tabela de bichos ---
    try:
        df = run_query("SELECT b.idbicho,b.nome Nome,e.nome Especie,r.nome Raca,b.sexo,b.cor,b.peso,b.castrado,s.nome UsuarioCadastro FROM bichos.bichos b JOIN domain.eespecie e ON b.especie = e.idespecie JOIN domain.eraca r ON b.raca = r.idraca JOIN usuarios.usuarios s ON b.usuariocadastro = s.cpf")
        st.dataframe(df, use_container_width=True)
    except Exception as e:
        st.error(f"Erro ao carregar bichos: {e}")

    # --- Buscar opções do DB ---
    usuarios = run_query("SELECT cpf, nome FROM usuarios.usuarios")
    enderecos = run_query("SELECT idendereco, rua, numero, complemento FROM enderecos.enderecos")
    especies = run_query("SELECT idespecie, nome FROM domain.eespecie")

    # --- Session state para espécie e raças ---
    if "selected_especie" not in st.session_state:
        st.session_state.selected_especie = especies["nome"].iloc[0]
    if "racas" not in st.session_state:
        st.session_state.racas = pd.DataFrame()

    # Função para atualizar raças ao mudar espécie
    def update_racas():
        id_especie = int(especies.loc[especies["nome"] == st.session_state.selected_especie, "idespecie"].values[0])
        st.session_state.racas = run_query(f"SELECT idraca, nome FROM domain.eraca WHERE idespecie = {id_especie}")

    # --- Endereço ---
    st.write("### Endereço do Bicho")
    latitude = -31.781290618693717
    longitude = -52.32341213609578

    view_state = pdk.ViewState(
        latitude=latitude,
        longitude=longitude,
        zoom=12,
        pitch=0,
    )
    layer = pdk.Layer(
        "ScatterplotLayer",
        data=[{"lat": latitude, "lon": longitude}],
        get_position='[lon, lat]',
        get_color='[200, 30, 0, 160]',
        get_radius=200,
    )
    st.pydeck_chart(pdk.Deck(layers=[layer], initial_view_state=view_state))

    endereco_opcao = st.radio("Escolha um endereço:", ["Existente", "Novo"])
    idendereco = None

    if endereco_opcao == "Existente":
        if len(enderecos) > 0:
            endereco_selecionado = st.selectbox(
                "Endereço existente",
                [f"{row.idendereco} - {row.rua}, {row.numero}, {row.complemento or ''}" for idx, row in enderecos.iterrows()]
            )
            idendereco = int(endereco_selecionado.split(" - ")[0])
        else:
            st.info("Não há endereços cadastrados. Insira um novo abaixo.")
            endereco_opcao = "Novo"

    if endereco_opcao == "Novo":
        bairros = run_query("SELECT idbairro, nome FROM enderecos.bairros")
        rua = st.text_input("Rua")
        numero = st.text_input("Número")
        complemento = st.text_input("Complemento (opcional)")
        bairro_selecionado = st.selectbox(
            "Bairros",
            [f"{row.idbairro} - {row.nome}" for idx, row in bairros.iterrows()]
        )

# --- Espécie selectbox ---
    st.selectbox(
      "Espécie",
      especies["nome"],
      index=0 if "selected_especie" not in st.session_state else especies["nome"].tolist().index(st.session_state.selected_especie),
      key="selected_especie"
    )
    update_racas()  # Atualiza racas sempre que espécie muda

    # --- Raça selectbox ---
    raca = st.selectbox(
        "Raça",
        st.session_state.racas["nome"].tolist() if not st.session_state.racas.empty else ["Nenhuma disponível"]
    )

    # --- Form de cadastro ---
    with st.form("form_bicho"):
        nome_bicho = st.text_input("Nome do Bicho")
        sexo = st.selectbox("Sexo", ["M", "F"])
        cor = st.text_input("Cor")
        peso = st.number_input("Peso (kg)", min_value=0.0, step=0.1)
        castrado = st.checkbox("Castrado?")
        usuario_cadastro = st.selectbox(
            "Usuário de Cadastro", [f"{row.cpf} - {row.nome}" for idx, row in usuarios.iterrows()]
        )
        data_cadastro = st.date_input("Data de Cadastro")
        submitted = st.form_submit_button("Cadastrar Bicho")

        if submitted:
            try:
                # Novo endereço
                if endereco_opcao == "Novo":
                    if not rua or not numero:
                        st.error("Rua e Número são obrigatórios para novo endereço!")
                        st.stop()
                    insert(
                        """INSERT INTO enderecos.enderecos (rua, numero, complemento, cpfusuario, idbairro)
                        VALUES (:rua, :numero, :complemento, :cpfusuario, :idbairro)""",
                        {
                            "rua": rua,
                            "numero": numero,
                            "complemento": complemento,
                            "cpfusuario": usuario_cadastro.split(" - ")[0],
                            "idbairro": bairro_selecionado.split(" - ")[0]
                        }
                    )
                    enderecos = run_query("SELECT idendereco FROM enderecos.enderecos WHERE idbicho IS NULL ORDER BY idendereco DESC LIMIT 1")
                    idendereco = enderecos.iloc[0]["idendereco"]

                if not idendereco:
                    st.error("Selecione ou cadastre um endereço!")
                    st.stop()

                # Inserir bicho
                idraca = int(st.session_state.racas.loc[st.session_state.racas["nome"] == raca, "idraca"].values[0])
                idespecie = int(especies.loc[especies["nome"] == st.session_state.selected_especie, "idespecie"].values[0])
                cpf_usuario = usuario_cadastro.split(" - ")[0]

                insert(
                    """INSERT INTO bichos.bichos 
                    (nome, raca, especie, sexo, cor, peso, castrado, usuariocadastro, datacadastro)
                    VALUES (:nome, :raca, :especie, :sexo, :cor, :peso, :castrado, :usuariocadastro, :datacadastro)""",
                    {
                        "nome": nome_bicho,
                        "raca": idraca,
                        "especie": idespecie,
                        "sexo": sexo,
                        "cor": cor,
                        "peso": peso,
                        "castrado": castrado,
                        "usuariocadastro": cpf_usuario,
                        "datacadastro": data_cadastro
                    }
                )

                # Atualiza endereço com id do bicho
                bicho_id = run_query("SELECT idbicho FROM bichos.bichos ORDER BY idbicho DESC LIMIT 1").iloc[0]["idbicho"]
                insert(
                    "UPDATE enderecos.enderecos SET idbicho = :idbicho WHERE idendereco = :idendereco",
                    {"idbicho": int(bicho_id), "idendereco": int(idendereco)}
                )

                st.success("Bicho cadastrado com sucesso e associado a um endereço!")
                st.rerun()  # força recarregar
            except Exception as e:
                st.error(f"Erro ao cadastrar bicho: {e}")


with tab6:
  query = st.text_area("Digite sua query SQL:", "SELECT [columns] FROM [schema].[table]")

  if st.button("Executar consulta"):
      try:
          df = run_query(query)
          st.success("Consulta executada com sucesso!")
          st.dataframe(df, use_container_width=True)
      except Exception as e:
          st.error(f"Erro: {e}")






