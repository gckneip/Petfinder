-- SCHEMA: Domain
CREATE SCHEMA domain;

CREATE TABLE domain.eraca (
	idraca SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE domain.eespecie (
	idespecie SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE domain.egravidade (
	idgravidade SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

-- SCHEMA: usuarios
CREATE SCHEMA usuarios;

CREATE TABLE usuarios.usuarios (
	nome VARCHAR(70) NOT NULL,
	cpf VARCHAR(11) PRIMARY KEY,
	email VARCHAR(320) NOT NULL,
	saldo NUMERIC(12,2) NOT NULL
);

CREATE TABLE usuarios.voluntarios (
	cpf VARCHAR(11) PRIMARY KEY REFERENCES usuarios.usuarios(cpf)
);

CREATE TABLE usuarios.doadores (
	cpf VARCHAR(11) PRIMARY KEY REFERENCES usuarios.usuarios(cpf)
);

CREATE TABLE usuarios.empresarios (
	cpf VARCHAR(11) PRIMARY KEY REFERENCES usuarios.usuarios(cpf)
);

CREATE TABLE usuarios.profissionais (
	cpf VARCHAR(11) PRIMARY KEY REFERENCES usuarios.usuarios(cpf)
);

-- SCHEMA: enderecos
CREATE SCHEMA enderecos;

CREATE TABLE enderecos.bairros (
	idbairro SERIAL PRIMARY KEY,
	nome VARCHAR(70) NOT NULL
);

-- Referências dependem de tabelas ainda não criadas, então criamos depois

-- SCHEMA: estabelecimentos
CREATE SCHEMA estabelecimentos;

CREATE TABLE estabelecimentos.estabelecimentos (
	cnpj VARCHAR(14) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	cpfadministra VARCHAR(11) NOT NULL REFERENCES usuarios.empresarios(cpf)
);

CREATE TABLE estabelecimentos.veterinarias (
	cnpj VARCHAR(14) PRIMARY KEY REFERENCES estabelecimentos.estabelecimentos(cnpj)
);

CREATE TABLE estabelecimentos.petshops (
	cnpj VARCHAR(14) PRIMARY KEY REFERENCES estabelecimentos.estabelecimentos(cnpj)
);

CREATE TABLE estabelecimentos.profissionais_veterinarias (
	cnpj VARCHAR(14) NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	PRIMARY KEY (cnpj, cpf),
	FOREIGN KEY (cnpj) REFERENCES estabelecimentos.veterinarias(cnpj),
	FOREIGN KEY (cpf) REFERENCES usuarios.profissionais(cpf)
);

-- SCHEMA: especialidades
CREATE SCHEMA especialidades;

CREATE TABLE especialidades.especialidades (
	idespecialidade SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL
);

CREATE TABLE especialidades.profissionais_especialidades (
	idespecialidade INT NOT NULL,
	cpfprofissional VARCHAR(11) NOT NULL,
	PRIMARY KEY (idespecialidade, cpfprofissional),
	FOREIGN KEY (idespecialidade) REFERENCES especialidades.especialidades(idespecialidade),
	FOREIGN KEY (cpfprofissional) REFERENCES usuarios.profissionais(cpf)
);

-- SCHEMA: bichos
CREATE SCHEMA bichos;

CREATE TABLE bichos.bichos (
	idbicho SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	raca SMALLINT NOT NULL REFERENCES domain.eraca(idraca),
	especie SMALLINT NOT NULL REFERENCES domain.eespecie(idespecie),
	sexo CHAR(1) NOT NULL,
	peso NUMERIC(10,2) NOT NULL,
	castrado BOOLEAN NOT NULL,
	usuariocadastro VARCHAR(11) NOT NULL REFERENCES usuarios.usuarios(cpf),
	datacadastro DATE NOT NULL,
	usuarioadministrador VARCHAR(11) REFERENCES usuarios.voluntarios(cpf),
	profissionalresponsavel VARCHAR(11) REFERENCES usuarios.profissionais(cpf)
);

CREATE TABLE bichos.bairros_bichos (
	idbairro INT NOT NULL,
	idbicho INT NOT NULL,
	PRIMARY KEY (idbairro, idbicho),
	FOREIGN KEY (idbairro) REFERENCES enderecos.bairros(idbairro),
	FOREIGN KEY (idbicho) REFERENCES bichos.bichos(idbicho)
);

CREATE TABLE bichos.afeccoes (
	idafeccao SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	gravidade SMALLINT NOT NULL REFERENCES domain.egravidade(idgravidade),
	contagiosa BOOLEAN NOT NULL
);

CREATE TABLE bichos.afeccoes_bichos (
	idafeccao INT NOT NULL,
	idbicho INT NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim DATE NOT NULL,
	PRIMARY KEY (idafeccao, idbicho, data_inicio, data_fim),
	FOREIGN KEY (idafeccao) REFERENCES bichos.afeccoes(idafeccao),
	FOREIGN KEY (idbicho) REFERENCES bichos.bichos(idbicho)
);

CREATE TABLE bichos.doacoes (
	idbicho INT NOT NULL,
	cpfusuario VARCHAR(11) NOT NULL,
	data TIMESTAMP NOT NULL,
	valor NUMERIC(8,2) NOT NULL,
	PRIMARY KEY(idbicho, cpfusuario, data),
	FOREIGN KEY (idbicho) REFERENCES bichos.bichos(idbicho),
	FOREIGN KEY (cpfusuario) REFERENCES usuarios.usuarios(cpf)
);

-- Referência agora pode ser feita pois todas as tabelas base existem
CREATE TABLE enderecos.enderecos (
	idendereco SERIAL PRIMARY KEY,
	rua VARCHAR(100) NOT NULL,
	numero VARCHAR(10) NOT NULL,
	complemento VARCHAR(50),
	idbairro INT NOT NULL,
	cpfusuario VARCHAR(11),
	idbicho INT,
	cnpjestabelecimento VARCHAR(14),
	FOREIGN KEY (idbairro) REFERENCES enderecos.bairros(idbairro),
	FOREIGN KEY (cpfusuario) REFERENCES usuarios.usuarios(cpf),
	FOREIGN KEY (idbicho) REFERENCES bichos.bichos(idbicho),
	FOREIGN KEY (cnpjestabelecimento) REFERENCES estabelecimentos.estabelecimentos(cnpj),
	CHECK (
		cpfusuario IS NOT NULL OR
		idbicho IS NOT NULL OR
		cnpjestabelecimento IS NOT NULL
	)
);

-- SCHEMA: itens
CREATE SCHEMA itens;

CREATE TABLE itens.itens (
	iditem SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	codbarra VARCHAR(20)
);

CREATE TABLE itens.petshop_itens (
	iditem INT NOT NULL,
	petshop VARCHAR(14) NOT NULL,
	preco NUMERIC(12,2) not NULL,
	PRIMARY KEY(iditem, petshop),
	FOREIGN KEY (iditem) REFERENCES itens.itens(iditem),
	FOREIGN KEY (petshop) REFERENCES estabelecimentos.petshops(cnpj)
);

CREATE TABLE itens.bichos_itens (
	iditem INT NOT NULL,
	idbicho INT NOT NULL,
	PRIMARY KEY(iditem, idbicho),
	FOREIGN KEY (iditem) REFERENCES itens.itens(iditem),
	FOREIGN KEY (idbicho) REFERENCES bichos.bichos(idbicho)
);

CREATE TABLE itens.vacinas (
	idvacina SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE itens.bichos_vacinas (
	idvacina INT NOT NULL,
	idbicho INT NOT NULL,
	PRIMARY KEY(idvacina, idbicho),
	FOREIGN KEY (idvacina) REFERENCES itens.vacinas(idvacina),
	FOREIGN KEY (idbicho) REFERENCES bichos.bichos(idbicho)
);

CREATE TABLE itens.medicamentos (
	idmedicamento SERIAL PRIMARY KEY,
	registromapa VARCHAR(20),
	nome VARCHAR(100) NOT NULL,
	posologia VARCHAR(500) NOT NULL
);

CREATE TABLE itens.bichos_medicamentos (
	idmedicamento INT NOT NULL,
	idbicho INT NOT NULL,
	PRIMARY KEY(idmedicamento, idbicho),
	FOREIGN KEY (idmedicamento) REFERENCES itens.medicamentos(idmedicamento),
	FOREIGN KEY (idbicho) REFERENCES bichos.bichos(idbicho)
);
