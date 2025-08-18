# Sistema de Adoção de Animais

Este projeto é uma aplicação em **Python** com **Streamlit** para gerenciar cadastros relacionados ao cuidado de animais comunitários.  
Ele permite cadastrar usuários, endereços, doações, itens e animais (bichos), com formulários interativos e abas de navegação.

---

## 🚀 Como rodar o projeto

### 1. Clonar o repositório
Se ainda não tiver clonado, execute:
```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
````

### 2. Criar ambiente virtual (opcional, mas recomendado)

```bash
python -m venv venv
```

No Linux/macOS:

```bash
source venv/bin/activate
```

No Windows (PowerShell):

```bash
.\venv\Scripts\activate
```

### 3. Instalar dependências

As dependências estão listadas no arquivo `requirements.txt`.
Instale com:

```bash
pip install -r requirements.txt
```

### 4. Configurar banco

Por default, as configurações de login e senha do banco estão como os padrões para databases criados no PostgreSQL.  

Para que a aplicação consiga acessar os dados do seu banco, preencha as informações abaixo no `app.py`:

```python
user = "postgres"
password = ""
host = "localhost"
port = "5432"
db = "postgres"
```

### 5. Rodar a aplicação

Execute:

```bash
streamlit run app.py
```

O Streamlit abrirá automaticamente no navegador em [http://localhost:8501](http://localhost:8501).

---

## 📂 Estrutura do projeto

```
.
├── app.py                # Arquivo principal da aplicação
├── requirements.txt      # Dependências do projeto
├── README.md             # Este arquivo
├── SCRIPTS/              # Scripts Usados na criação do banco
└── assets/               # Imagens e arquivos estáticos
```

---

## 🛠️ Tecnologias utilizadas

* [Python](https://www.python.org/)
* [Streamlit](https://streamlit.io/)
* [Postgres](https://www.sqlite.org/) (ou outro banco de dados, caso adicionado)
---

## 💡 Funcionalidades

* Cadastro de **usuários**
* Cadastro e seleção de **endereços**
* Cadastro de **itens** e **doações**
* Cadastro de **animais (bichos)** com endereço obrigatório

---

## 👤 Autores

* Gustavo Cunha Kneip - [gckneip@inf.ufpel.edu.br](mailto:gckneip@inf.ufpel.edu.br.com)
* Antônio Araújo de Brum - [aadbrum@inf.ufpel.edu.br](mailto:aadbrump@inf.ufpel.edu.br.com)
* Matheus Renan Freitas de Freitas - [mrffreitas@inf.ufpel.edu.br](mailto:mrffreitas@inf.ufpel.edu.br.com)

