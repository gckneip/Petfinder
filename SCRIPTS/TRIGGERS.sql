
-- Testar os triggers após executá-los

CREATE OR REPLACE FUNCTION trigger_atualiza_saldo_doador()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza o saldo do usuário doador
    UPDATE usuarios.usuarios
    SET saldo = saldo + NEW.valor
    WHERE cpf = NEW.cpfusuario;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação do trigger
CREATE OR REPLACE TRIGGER trg_atualiza_saldo_doador
AFTER INSERT ON bichos.doacoes
FOR EACH ROW
EXECUTE FUNCTION trigger_atualiza_saldo_doador();


CREATE OR REPLACE FUNCTION trigger_valida_datas_afeccao()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a data de fim é anterior à data de início
    IF NEW.data_fim < NEW.data_inicio THEN
        RAISE EXCEPTION 'A data de fim da afecção (%) não pode ser anterior à data de início (%).', NEW.data_fim, NEW.data_inicio;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação do trigger
CREATE OR REPLACE TRIGGER trg_valida_datas_afeccao
BEFORE INSERT OR UPDATE ON bichos.afeccoes_bichos
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_datas_afeccao();


CREATE OR REPLACE FUNCTION trigger_preenche_datacadastro_bicho()
RETURNS TRIGGER AS $$
BEGIN
    -- Define a data de cadastro como a data atual
    NEW.datacadastro := CURRENT_DATE;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação do trigger
CREATE OR REPLACE TRIGGER trg_preenche_datacadastro_bicho
BEFORE INSERT ON bichos.bichos
FOR EACH ROW
EXECUTE FUNCTION trigger_preenche_datacadastro_bicho();



CREATE OR REPLACE FUNCTION trigger_valida_preco_item()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o preço é menor ou igual a zero
    IF NEW.preco <= 0 THEN
        RAISE EXCEPTION 'O preço do item deve ser maior que zero.';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação do trigger
CREATE OR REPLACE TRIGGER trg_valida_preco_item
BEFORE INSERT OR UPDATE ON itens.petshop_itens
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_preco_item();


CREATE OR REPLACE FUNCTION trigger_valida_saldo_doacao()
RETURNS TRIGGER AS $$
DECLARE
    saldo_atual NUMERIC(12,2);
BEGIN
    -- Busca o saldo atual do usuário
    SELECT saldo INTO saldo_atual FROM usuarios.usuarios WHERE cpf = NEW.cpfusuario;
    
    -- Verifica se o valor da doação é maior que o saldo disponível
    IF NEW.valor > saldo_atual THEN
        RAISE EXCEPTION 'O valor da doação (%) excede o saldo disponível (%).', NEW.valor, saldo_atual;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação do trigger
CREATE OR REPLACE TRIGGER trg_valida_saldo_doacao
BEFORE INSERT ON bichos.doacoes
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_saldo_doacao();