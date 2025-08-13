-- DOMAIN

-- RAÇAS
INSERT INTO domain.eraca (nome) values
('Poodle'), ('Labrador'), ('SRD'), ('Angorá'), ('Siamês');

-- ESPÉCIES
INSERT INTO domain.eespecie (nome) VALUES
('Cachorro'), ('Gato'), ('Cavalo'), ('Pombo');

-- GRAVIDADES
INSERT INTO domain.egravidade (nome) VALUES
('Leve'), ('Moderada'), ('Grave');


-- BAIRROS
INSERT INTO enderecos.bairros (nome) VALUES
('Centro'), ('Fragata'), ('Três Vendas'), ('Areal'), ('Laranjal');

-- USUÁRIOS
INSERT INTO usuarios.usuarios (nome, cpf, email, saldo) VALUES
('Antônio Brum', '11111111111', 'antonio@email.com', 500.00),
('Gustavo Cunha', '22222222222', 'gustavo@email.com', 300.00),
('Matheus Freitas', '33333333333', 'matheus@email.com', 150.00),
('Ana Pernas', '44444444444', 'ana@email.com', 700.00),
('Vitor Surf', '55555555555', 'vitor@email.com', 50.00);

-- VOLUNTÁRIOS
INSERT INTO usuarios.voluntarios (cpf) VALUES
('11111111111'), ('44444444444');

-- DOADORES
INSERT INTO usuarios.doadores (cpf) VALUES
('22222222222'), ('33333333333');

-- EMPRESÁRIOS
INSERT INTO usuarios.empresarios (cpf) VALUES
('55555555555');

-- PROFISSIONAIS
INSERT INTO usuarios.profissionais (cpf) VALUES
('33333333333'), ('44444444444');


-- ESTABELECIMENTOS
INSERT INTO estabelecimentos.estabelecimentos (cnpj, nome, cpfadministra) VALUES
('00000000000100', 'ProPet', '55555555555'),
('00000000000200', 'Amigos Para Sempre', '55555555555');

-- PETSHOPS
INSERT INTO estabelecimentos.petshops (cnpj) VALUES
('00000000000100');

-- VETERINÁRIAS
INSERT INTO estabelecimentos.veterinarias (cnpj) VALUES
('00000000000200');

-- PROFISSIONAIS VETERINÁRIAS
INSERT INTO estabelecimentos.profissionais_veterinarias (cnpj, cpf) VALUES
('00000000000200', '33333333333'),
('00000000000200', '44444444444');


-- ESPECIALIDADES
INSERT INTO especialidades.especialidades (nome) VALUES
('Clínico Geral'), ('Cirurgião Veterinário'), ('Dermatologista');

-- ESPECIALIDADES DOS PROFISSIONAIS
INSERT INTO especialidades.profissionais_especialidades (idespecialidade, cpfprofissional) VALUES
(1, '33333333333'),
(2, '44444444444');

-- BICHOS
INSERT INTO bichos.bichos (nome, raca, especie, sexo, peso, castrado, usuariocadastro, datacadastro)
VALUES
('Lupi Garou', 2, 1, 'M', 25.0, TRUE, '11111111111', CURRENT_DATE),
('Antonietta', 1, 1, 'F', 17.0, TRUE, '22222222222', CURRENT_DATE),
('Bigodôncio', 4, 2, 'M', 2.6, FALSE, '33333333333', CURRENT_DATE),
('Bete Barraco', 5, 2, 'F', 3.2, TRUE, '44444444444', CURRENT_DATE);


-- AFECÇÕES 
INSERT INTO bichos.afeccoes (nome, gravidade, contagiosa) VALUES
('Gripe Canina', 1, TRUE),
('Dermatite', 2, FALSE),
('Cinomose', 3, TRUE);

-- AFECÇÕES DOS BICHOS
INSERT INTO bichos.afeccoes_bichos (idafeccao, idbicho, data_inicio, data_fim) VALUES
(1, 1, '2025-01-01', '2025-01-10'),
(2, 3, '2025-02-01', '2025-02-15');

-- DOAÇÕES 
INSERT INTO bichos.doacoes (idbicho, cpfusuario, data, valor) VALUES
(1, '22222222222', '2025-02-01', 50.00),
(2, '33333333333', '2025-02-05', 30.00),
(3, '22222222222', '2025-02-10', 100.00);


-- ITENS
INSERT INTO itens.itens (nome, codbarra) VALUES
('Ração Premium', '1234567890123'),
('Coleira', '9876543210987'),
('Shampoo Pet', NULL);

-- ITENS DO PETSHOP
INSERT INTO itens.petshop_itens (iditem, petshop, preco) VALUES
(1, '00000000000100', 12.10),
(2, '00000000000100', 99.99),
(3, '00000000000100', 45.00);

-- VACINAS
INSERT INTO itens.vacinas (nome) VALUES
('Antirrábica'), ('V8'), ('V10');

-- VACINAS DOS BICHOS
INSERT INTO itens.bichos_vacinas (idvacina, idbicho) VALUES
(1, 1), (2, 1), (1, 2), (3, 3);

-- MEDICAMENTOS
INSERT INTO itens.medicamentos (registromapa, nome, posologia) VALUES
('BR12345', 'Vermífugo', '1 comprimido a cada 3 meses'),
(NULL, 'Antibiótico X', '2 vezes ao dia por 7 dias');

-- MEDICAMENTOS BICHOS
INSERT INTO itens.bichos_medicamentos (idmedicamento, idbicho) VALUES
(1, 1), (2, 3);


-- ENDEREÇOS USUÁRIOS
INSERT INTO enderecos.enderecos (idbairro, rua, numero, cpfusuario)
VALUES
(1, 'Largo do Bola', '101', '11111111111'),
(2, 'Travessa do bolinha', '202', '22222222222'),
(3, 'Avenida do bolão', '303', '33333333333'),
(4, 'Alameda da Pelota', '404', '44444444444'),
(5, 'Praça do Bolita', '505', '55555555555');


-- ENDEREÇOS BICHOS

INSERT INTO enderecos.enderecos (idbairro, rua, numero, idbicho) 
VALUES
(1, 'Rua dos Animais', '22345000', 1),
(2, 'Avenida Pet Lovers', '22345001', 2),
(3, 'Praça dos Gatos', '22345002', 3),
(4, 'Travessa dos Cães', '22345003', 4);

-- ENDEREÇOS ESTABELECIMENTOS

INSERT INTO enderecos.enderecos (idbairro, rua, numero, cnpjestabelecimento)
VALUES
(1, 'Rua do Petshop', '500', '00000000000100'),
(2, 'Avenida da Veterinária', '600', '00000000000200');



