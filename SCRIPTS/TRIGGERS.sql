
-- Atualiza o saldo do usuário doador
CREATE OR REPLACE FUNCTION trigger_atualiza_saldo_doador()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE usuarios.usuarios
    SET saldo = saldo - NEW.valor
    WHERE cpf = NEW.cpfusuario;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
CREATE or replace TRIGGER trg_atualiza_saldo_doador
AFTER INSERT ON bichos.doacoes
FOR EACH ROW
EXECUTE FUNCTION trigger_atualiza_saldo_doador();

-- TESTES
INSERT INTO bichos.doacoes (idbicho, cpfusuario, valor, data)
VALUES (1, '11111111111', 100.00, CURRENT_TIMESTAMP);

SELECT cpf, saldo
FROM usuarios.usuarios
WHERE cpf = '11111111111';



-- Verifica se a data de fim é anterior à data de início
CREATE OR REPLACE FUNCTION trigger_valida_datas_afeccao()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_fim < NEW.data_inicio THEN
        RAISE EXCEPTION 'A data de fim da afecção (%) não pode ser anterior à data de início (%).', NEW.data_fim, NEW.data_inicio;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
CREATE OR REPLACE TRIGGER trg_valida_datas_afeccao
BEFORE INSERT OR UPDATE ON bichos.afeccoes_bichos
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_datas_afeccao();

--TESTE
INSERT INTO bichos.afeccoes_bichos (idafeccao, idbicho, data_inicio, data_fim)
VALUES (1, 2, '2025-08-12', '2025-08-10');



-- Verifica se o preço é menor ou igual a zero
CREATE OR REPLACE FUNCTION trigger_valida_preco_item()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.preco <= 0 THEN
        RAISE EXCEPTION 'O preço do item deve ser maior que zero.';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
CREATE OR REPLACE TRIGGER trg_valida_preco_item
BEFORE INSERT OR UPDATE ON itens.petshop_itens
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_preco_item();

-- TESTES
insert into itens.itens(nome, codbarra) values ('Coleira para cachorro', '5555555555');

INSERT INTO itens.petshop_itens (iditem, petshop, preco)
VALUES (4,'00000000000100', 0.00);


--Busca o saldo atual do usuário e verifica se o valor da doação é maior que o saldo disponível
CREATE OR REPLACE FUNCTION trigger_valida_saldo_doacao()
RETURNS TRIGGER AS $$
DECLARE
    saldo_atual NUMERIC(12,2);
BEGIN
    SELECT saldo INTO saldo_atual FROM usuarios.usuarios WHERE cpf = NEW.cpfusuario;
    
    IF NEW.valor > saldo_atual THEN
        RAISE EXCEPTION 'O valor da doação (%) excede o saldo disponível (%).', NEW.valor, saldo_atual;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
CREATE OR REPLACE TRIGGER trg_valida_saldo_doacao
BEFORE INSERT ON bichos.doacoes
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_saldo_doacao();

-- TESTES
INSERT INTO bichos.doacoes (idbicho, cpfusuario, data, valor)
VALUES (1, '33333333333', CURRENT_TIMESTAMP, 200.00);

select nome, saldo 
from usuarios.usuarios u
where u.cpf = '33333333333'
