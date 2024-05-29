
-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql - banco local - ambiente de desenvolvimento
*/
CREATE DATABASE air_totem;

USE air_totem;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cnpj VARCHAR(45),
    telefone VARCHAR(45)
);

CREATE TABLE aeroporto(
	idAero INT PRIMARY KEY auto_increment,
    nome VARCHAR(45),
    cep VARCHAR(45)
);


CREATE TABLE terminal (
    idTerminal INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT,
    id_aeroporto INT,
    FOREIGN KEY (id_empresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (id_aeroporto) REFERENCES aeroporto(idAero)
);


CREATE TABLE usuario (
	idUser INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
    sobrenome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50),
    cpf VARCHAR(45),
    telefone VARCHAR(45),
    celular VARCHAR(45),
    cep VARCHAR(45),
    endereço VARCHAR(45),
    numero VARCHAR(45),
    complemento VARCHAR(45),
    nivelAcesso ENUM('Administrador', 'Gerente' ,'Suporte'),
	fk_empresa INT,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(idEmpresa),
    fk_aeroporto INT,
	FOREIGN KEY (fk_aeroporto) REFERENCES aeroporto(idAero)
);



CREATE TABLE totem (
	idTotem INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(idEmpresa),
    fk_aeroporto INT,
	FOREIGN KEY (fk_aeroporto) REFERENCES aeroporto(idAero),
    fk_terminal INT,
	FOREIGN KEY (fk_terminal) REFERENCES terminal(idTerminal),
    inicializado DATE,
    tempo_atv VARCHAR(255),
    modeloProcessador VARCHAR(255),
    fabricanteProcessador VARCHAR(255),
    frequenciaProcessador VARCHAR(255),
    so VARCHAR(255),
    memoriaTotal DOUBLE,
    hostRede VARCHAR(255),
    servidorDns VARCHAR(255),
    nomeDominioRede VARCHAR(255),
    velocidadeRede DOUBLE
);


CREATE TABLE disco (
    idDisco INT AUTO_INCREMENT,
    nomeDisco VARCHAR(45),
    total VARCHAR(45),
    tipo VARCHAR(45),
    dataInstalacao DATETIME,
    fk_totem INT,
    fk_terminal INT,
    PRIMARY KEY (idDisco),
    FOREIGN KEY (fk_totem) REFERENCES totem(idTotem),
    FOREIGN KEY (fk_terminal) REFERENCES terminal(idTerminal)
);

CREATE TABLE historico (
    idHistorico INT PRIMARY KEY AUTO_INCREMENT,
    idTotem INT,
    diaHorario DATETIME,
    usoMemoria VARCHAR(255),
    usoProcessador DOUBLE,
    velocidadeRede DOUBLE,
    fk_totem INT,
    FOREIGN KEY (fk_totem) REFERENCES totem(idTotem),
    fk_terminal INT,
	FOREIGN KEY (fk_terminal) REFERENCES terminal(idTerminal)
);

CREATE TABLE metrica (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    metricaProcessadorRangeAlerta DECIMAL(5, 2),
    metricaProcessadorRangeLento DECIMAL(5, 2),
    metricaMemoriaRangeAlerta DECIMAL(5, 2),
    metricaMemoriaRangeLento DECIMAL(5, 2),
    velocidadeMbpsRedeRangeAlerta DECIMAL(5, 2),
    velocidadeMbpsRedeRangeLento DECIMAL(5, 2),
    metricaUsoDiscoRangeAlerta DECIMAL(5, 2),
    metricaUsoDiscoRangeLento DECIMAL(5, 2),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(idEmpresa)
);


CREATE TABLE historicoStatus (
    idhistoricoStatus INT PRIMARY KEY AUTO_INCREMENT,
    diaHorario DATETIME,
    status VARCHAR(45),
    colocadoManutencao DATETIME,
    retiradoManutencao DATETIME,
    fk_totem INT,
    FOREIGN KEY (fk_totem) REFERENCES totem(idTotem),
    fk_terminal INT,
	FOREIGN KEY (fk_terminal) REFERENCES terminal(idTerminal),
    statusTotem ENUM ('Manutenção', 'Ativo', 'Inativo')
);

CREATE TABLE historicoDisco (
    idHistoricoDisco INT PRIMARY KEY AUTO_INCREMENT,
    diaHorario DATETIME,
    porcentDisponivel DOUBLE,
    tempoUso TIME,
    fk_disco INT,
    FOREIGN KEY (fk_disco) REFERENCES disco(idDisco),
    fk_totem INT,
    FOREIGN KEY (fk_totem) REFERENCES totem(idTotem),
    fk_terminal INT,
	FOREIGN KEY (fk_terminal) REFERENCES terminal(idTerminal)
);


CREATE TABLE faleConosco (
    idContato INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(45),
    emailEmpresa VARCHAR(45),
    mensagem VARCHAR(255)
);

INSERT INTO empresa (nome, cnpj, telefone) VALUES
('Empresa', '12345678901234', '(11) 1234-5678'),
('Empresa', '98765432109876', '(21) 9876-5432');

INSERT INTO aeroporto (nome, cep) VALUES
('Aeroporto Internacional A', '12345-678'),
('Aeroporto Nacional B', '54321-876');


INSERT INTO usuario (nome, email, senha, cpf, nivelAcesso, fk_empresa, fk_aeroporto) VALUES
('Usuário 1', 'usuario1@email.com', 'senha123', '123.456.789-00', 'Administrador', 1, 1),
('Usuário 2', 'usuario3@email.com', 'senha456', '987.654.321-00', 'Suporte', 2, 1);


INSERT INTO usuario (nome, email, senha, cpf, nivelAcesso, fk_empresa, fk_aeroporto) VALUES
('Lucas', 'usuario5@email.com', 'senha456', '123.456.789-00', 'Gerente', 1, 1);


INSERT INTO usuario (nome, email, senha, cpf, nivelAcesso, fk_empresa, fk_aeroporto) VALUES
('Usuário 1', 'usuario1@email.com', 'senha456', '123.456.789-00', 'Administrador', 2, 1);


INSERT INTO terminal (id_empresa, id_aeroporto) VALUES
(1, 1),
(2, 1),
(2, 2);

-- SELECTS ---

SELECT * FROM usuario;
SELECT * FROM disco;
SELECT * FROM totem;
SELECT * FROM aeroporto;
SELECT * FROM empresa;
SELECT * FROM terminal;
SELECT * FROM historico;
SELECT * FROM historicoDisco;


SELECT t.idTerminal AS idTerminal FROM usuario u
                JOIN empresa e ON u.fk_empresa = e.idEmpresa
                JOIN aeroporto a ON u.fk_aeroporto = a.idAero
                JOIN terminal t ON e.idEmpresa = t.id_empresa AND a.idAero = t.id_aeroporto
                WHERE u.email = 'usuario1@email.com' AND u.senha = 'senha456';
                
SELECT idTotem FROM totem WHERE idTotem = 1;