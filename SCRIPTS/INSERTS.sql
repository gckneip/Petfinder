-- DOMAIN 

-- RAÇAS
INSERT INTO domain.eraca (nome) VALUES
('Poodle'), ('Labrador'), ('Vira-lata'), ('Persa'), ('Siamês');

-- ESPÉCIES
INSERT INTO domain.eespecie (nome) VALUES
('Cachorro'), ('Gato'), ('Coelho'), ('Hamster');

-- GRAVIDADES
INSERT INTO domain.egravidade (nome) VALUES
('Leve'), ('Moderada'), ('Grave');

-- Bairros

-- BAIRROS
INSERT INTO enderecos.bairros (nome) VALUES
('Centro'), ('Jardim das Flores'), ('Vila Nova'), ('Parque Industrial'), ('Bairro Alto');

-- USUÁRIOS
INSERT INTO usuarios.usuarios (nome, cpf, email, saldo) VALUES
('Ana Silva', '11111111111', 'ana@email.com', 500.00),
('Bruno Costa', '22222222222', 'bruno@email.com', 300.00),
('Carlos Souza', '33333333333', 'carlos@email.com', 150.00),
('Daniela Rocha', '44444444444', 'daniela@email.com', 700.00),
('Eduardo Lima', '55555555555', 'eduardo@email.com', 50.00);

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
('00000000000100', 'Pet Love', '55555555555'),
('00000000000200', 'VetCare', '55555555555');

-- PETSHOPS
INSERT INTO estabelecimentos.petshops (cnpj) VALUES
('00000000000100');

-- VETERINÁRIAS
INSERT INTO estabelecimentos.veterinarias (cnpj) VALUES
('00000000000200');

-- PROFISSIONAIS VETERINÁRIAS
INSERT INTO estabelecimentos.profissionaisveterinarias (cnpj, cpf) VALUES
('00000000000200', '33333333333'),
('00000000000200', '44444444444');


INSERT INTO especialidades.especialidades (nome) VALUES
('Clínico Geral'), ('Cirurgião Veterinário'), ('Dermatologista');

INSERT INTO especialidades.profissionaisespecialidades (idespecialidade, cpfprofissional) VALUES
(1, '33333333333'),
(2, '44444444444');


INSERT INTO bichos.bichos (nome, raca, especie, sexo, peso, castrado, usuariocadastro, datacadastro)
VALUES
('Rex', 2, 1, 'M', 25.0, TRUE, '11111111111', CURRENT_DATE),
('Luna', 1, 1, 'F', 10.0, TRUE, '22222222222', CURRENT_DATE),
('Mingau', 4, 2, 'M', 4.5, FALSE, '33333333333', CURRENT_DATE),
('Nina', 5, 2, 'F', 3.8, TRUE, '44444444444', CURRENT_DATE);


INSERT INTO bichos.afeccoes (nome, gravidade, contagiosa) VALUES
('Gripe Canina', 1, TRUE),
('Dermatite', 2, FALSE),
('Cinomose', 3, TRUE);

INSERT INTO bichos.afeccoesbichos (idafeccao, idbicho, datainicio, datafim) VALUES
(1, 1, '2025-01-01', '2025-01-10'),
(2, 3, '2025-02-01', '2025-02-15');

INSERT INTO bichos.doacoes (idbicho, cpfusuario, data, valor) VALUES
(1, '22222222222', '2025-02-01', 50.00),
(2, '33333333333', '2025-02-05', 30.00),
(3, '22222222222', '2025-02-10', 100.00);


-- ITENS
INSERT INTO itens.itens (nome, codbarra) VALUES
('Ração Premium', '1234567890123'),
('Coleira', '9876543210987'),
('Shampoo Pet', NULL);

INSERT INTO itens.petshopitens (iditem, petshop) VALUES
(1, '00000000000100'),
(2, '00000000000100'),
(3, '00000000000100');

-- VACINAS
INSERT INTO itens.vacinas (nome) VALUES
('Antirrábica'), ('V8'), ('V10');

INSERT INTO itens.bichosvacinas (idvacina, idbicho) VALUES
(1, 1), (2, 1), (1, 2), (3, 3);

-- MEDICAMENTOS
INSERT INTO itens.medicamentos (registromapa, nome, posologia) VALUES
('BR12345', 'Vermífugo', '1 comprimido a cada 3 meses'),
(NULL, 'Antibiótico X', '2 vezes ao dia por 7 dias');

INSERT INTO itens.bichosmedicamentos (idmedicamento, idbicho) VALUES
(1, 1), (2, 3);


-- Endereços usuários
INSERT INTO enderecos.enderecos (bairro, logradouro, numero, cep, cpfusuario)
VALUES
(1, 'Rua das Acácias', '101', '12345000', '11111111111'),
(2, 'Avenida Brasil', '202', '12345001', '22222222222'),
(3, 'Travessa das Palmeiras', '303', '12345002', '33333333333'),
(4, 'Rua do Comércio', '404', '12345003', '44444444444'),
(5, 'Alameda dos Ipês', '505', '12345004', '55555555555');


-- Endereços Bichos

INSERT INTO enderecos.enderecos (bairro, logradouro, numero, cep, idbicho)
VALUES
(1, 'Rua dos Animais', '10', '22345000', 1),
(2, 'Avenida Pet Lovers', '20', '22345001', 2),
(3, 'Praça dos Gatos', '30', '22345002', 3),
(4, 'Travessa dos Cães', '40', '22345003', 4);

-- Endereços estabelecimentos

INSERT INTO enderecos.enderecos (bairro, logradouro, numero, cep, cnpjestabelecimento)
VALUES
(1, 'Rua do Petshop', '500', '32345000', '00000000000100'),
(2, 'Avenida da Veterinária', '600', '32345001', '00000000000200');



