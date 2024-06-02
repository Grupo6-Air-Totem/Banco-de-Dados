
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
    nomeTotem VARCHAR(45),
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
('Usuário 1', 'usuario1@email.com', 'senha123', '123.456.789-00', 'Administrador', 2, 1),
('Usuário 2', 'usuario2@email.com', 'senha123', '987.654.321-00', 'Gerente', 2, 1),
('Usuário 3', 'usuario3@email.com', 'senha123', '987.654.321-00', 'Suporte', 2, 1);

INSERT INTO terminal (id_empresa, id_aeroporto) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2);

INSERT INTO totem (nomeTotem, fk_empresa, fk_aeroporto, fk_Terminal, inicializado, tempo_atv, modeloProcessador, fabricanteProcessador, frequenciaProcessador, so, memoriaTotal, hostRede, servidorDns, nomeDominioRede, velocidadeRede)
VALUES 
('Totem 1 Empresa 1', 1, 1, 1, '2023-01-01', '24h', 'Intel i5', 'Intel', '2.5 GHz', 'Windows 10', 8.0, '192.168.1.1', '8.8.8.8', 'empresa1.local', 100.0),
('Totem 2 Empresa 1', 1, 1, 1, '2023-01-01', '24h', 'Intel i5', 'Intel', '2.5 GHz', 'Windows 10', 8.0, '192.168.1.1', '8.8.8.8', 'empresa1.local', 100.0),
('Totem 3 Empresa 1', 1, 1, 1, '2023-01-01', '24h', 'Intel i5', 'Intel', '2.5 GHz', 'Windows 10', 8.0, '192.168.1.2', '8.8.8.8', 'empresa2.local', 120.0),
('Totem 4 Empresa 1', 1, 1, 1, '2023-01-01', '24h', 'Intel i5', 'Intel', '2.5 GHz', 'Windows 10', 8.0, '192.168.1.2', '8.8.8.8', 'empresa3.local', 110.0),
('Totem 5 Empresa 1', 1, 1, 2, '2023-01-01', '24h', 'Intel i5', 'Intel', '2.5 GHz', 'Windows 10', 8.0, '192.168.1.2', '8.8.8.8', 'empresa3.local', 110.0),
('Totem 6 Empresa 1', 1, 1, 2, '2023-01-01', '24h', 'Intel i5', 'Intel', '2.5 GHz', 'Windows 10', 8.0, '192.168.1.2', '8.8.8.8', 'empresa3.local', 110.0),
('Totem 7 Empresa 1', 1, 1, 2, '2023-01-01', '24h', 'Intel i5', 'Intel', '2.5 GHz', 'Windows 10', 8.0, '192.168.1.2', '8.8.8.8', 'empresa3.local', 110.0),
('Totem 1 Empresa 2', 2, 2, 2, '2023-01-01', '24h', 'AMD Ryzen 5', 'AMD', '3.0 GHz', 'Linux', 16.0, '192.168.2.1', '8.8.4.4', 'empresa2.local', 200.0),
('Totem 2 Empresa 2', 2, 2, 2, '2023-01-01', '24h', 'AMD Ryzen 5', 'AMD', '3.0 GHz', 'Linux', 16.0, '192.168.2.2', '8.8.4.4', 'empresa2.local', 200.0);

INSERT INTO disco (nomeDisco, total, tipo, dataInstalacao, fk_totem, fk_terminal)
VALUES 
('Disco 1 Totem 1 Empresa 1', '500GB', 'SSD', '2023-01-01 00:00:00', 1, 1),
('Disco 2 Totem 1 Empresa 1', '500GB', 'SSD', '2023-01-01 00:00:00', 1, 1),
('Disco 1 Totem 2 Empresa 1', '1TB', 'HDD', '2023-01-01 00:00:00', 2, 2),
('Disco 2 Totem 2 Empresa 1', '1TB', 'HDD', '2023-01-01 00:00:00', 2, 2),
('Disco 1 Totem 1 Empresa 2', '1TB', 'SSD', '2023-01-01 00:00:00', 3, 1),
('Disco 2 Totem 1 Empresa 2', '1TB', 'SSD', '2023-01-01 00:00:00', 3, 1);

select hs.fk_totem, t.nomeTotem, hs.fk_Terminal , h.usoProcessador,h.usoMemoria, h.velocidadeRede, hs.statusTotem from totem as t join terminal as ter on t.fk_terminal = ter.idTerminal join historicoStatus as hs on hs.fk_Totem = t.idTotem join historico as h on h.fk_Totem = t.idTotem join historicoDisco as hd on hd.fk_Totem = t.idTotem where hs.statusTotem = 'Ativo' and hs.fk_Terminal = 2  and h.fk_Terminal = 1;

INSERT INTO historico (diaHorario, usoMemoria, usoProcessador, velocidadeRede, fk_totem, fk_terminal)
VALUES 
('2023-05-01 10:00:00', '4GB', 50.0, 90.0, 1, 1),
('2023-05-01 10:00:00', '4GB', 60.0, 80.0, 2, 1),
('2023-05-01 10:00:00', '8GB', 40.0, 100.0, 3, 1),

('2023-05-01 10:00:00', '8GB', 40.0, 100.0, 1, 2),
('2023-05-02 10:00:00', '8GB', 65.0, 75.0, 2, 2),
('2023-05-02 10:00:00', '4GB', 45.0, 95.0, 3, 2);

INSERT INTO historicoStatus (diaHorario,  colocadoManutencao, retiradoManutencao, fk_totem, fk_terminal, statusTotem)
VALUES 
('2023-05-01 10:00:00', NULL, NULL, 1, 1, 'Ativo'),
('2023-05-01 10:00:00','2023-05-01 12:00:00' , '2023-05-02 12:00:00', 2, 1, 'Inativo'),
('2023-05-01 10:00:00', NULL, NULL, 3, 1, 'Ativo'),
('2023-05-01 10:00:00', '2023-05-02 12:00:00', '2023-05-02 12:00:00', 4, 1, 'Manutenção'),
('2023-05-01 12:00:00', null,NULL, 1, 2, 'Ativo'),
('2023-05-01 12:00:00', '2023-05-02 12:00:00','2023-05-02 12:00:00', 2, 2, 'Inativo'),
('2023-05-01 12:00:00','2023-05-01 12:00:00', '2023-05-02 12:00:00', 3, 2, 'Inativo');

INSERT INTO historicoDisco (diaHorario, porcentDisponivel, tempoUso, fk_disco, fk_totem, fk_terminal)
VALUES 
('2023-05-01 10:00:00', 40.0, '02:00:00', 1, 2, 1),
('2023-05-01 10:00:00', 80.0, '02:00:00', 1, 1, 1),
('2023-05-01 10:00:00', 80.0, '02:00:00', 1, 3, 1),
('2023-05-01 10:00:00', 60.0, '02:00:00', 3, 2, 2),
('2023-05-01 12:00:00', 55.0, '04:00:00', 4, 2, 2);

INSERT INTO metrica (metricaProcessadorRangeAlerta, metricaProcessadorRangeLento, metricaMemoriaRangeAlerta, metricaMemoriaRangeLento, velocidadeMbpsRedeRangeAlerta, velocidadeMbpsRedeRangeLento, metricaUsoDiscoRangeAlerta, metricaUsoDiscoRangeLento, fk_empresa)
VALUES 
(80.00, 60.00, 70.00, 50.00, 50.00, 30.00, 80.00, 60.00, 1),
(80.00, 60.00, 70.00, 50.00, 50.00, 30.00, 80.00, 60.00, 2);


-- SELECTS ---

SELECT * FROM usuario;
SELECT * FROM disco;
SELECT * FROM totem;
SELECT * FROM aeroporto;
SELECT * FROM empresa;
SELECT * FROM terminal;
SELECT * FROM historico;
SELECT * FROM historicoDisco;
SELECT * FROM HistoricoStatus;

select * from totem join empresa on totem.fk_empresa = empresa.idEmpresa where totem.fk_empresa = 1;

SELECT
	 hs.idhistoricoStatus, 
	 DATE_FORMAT(hs.colocadoManutencao, '%d-%m-%Y') AS DiaHr,
	 hs.* 
 FROM
	HistoricoStatus 
 as 
	hs
WHERE 
	fk_Terminal = 2
    AND (statusTotem = 'Manutenção'
    OR statusTotem = 'Inativo');

SELECT
	 hs.idhistoricoStatus, 
	 DATE_FORMAT(hs.colocadoManutencao, '%d-%m-%Y') AS DiaHr,
	 hs.* 
 FROM
	HistoricoStatus 
 as 
	hs
WHERE 
	fk_Terminal = 2 
    AND (statusTotem = 'Ativo');

 select 
	ter.idTerminal,
    COUNT(t.idTotem) as TotalTotens,
	COUNT(CASE WHEN h.statusTotem = 'Inativo' then 1 end) as TotensInativos,
    COUNT(CASE WHEN h.statusTotem = 'Manutenção' THEN 1 END) AS TotensEmManutencao,
	COUNT(CASE WHEN h.statusTotem = 'Ativo' THEN 1 END) AS TotensAtivos
from
	totem as t
join 
	HistoricoStatus as h
on
	h.fk_Totem = t.idTotem
join 
	Terminal as ter
on 
	h.fk_Terminal = ter.idTerminal
join
	empresa
on
	t.fk_empresa = empresa.idEmpresa
where 
	t.fk_empresa = 1 
group by
	ter.idTerminal; 
    
    
SELECT 
    COUNT(*) AS TotalTotens
FROM 
    totem;
    
SELECT 
    hs.fk_Terminal AS idTerminal,
    t.nomeTotem AS nomeTotem,
    t.idTotem AS idTotem,
    h.usoProcessador AS PercentualCPU,
    hd.porcentDisponivel AS PercentualDisco,
    h.UsoMemoria AS PercentualMemoria,
    h.velocidadeRede AS VelocidadeRede,
    hs.statusTotem AS StatusTotem
FROM 
    totem AS t
JOIN 
    historico AS h ON h.fk_totem = t.idTotem
JOIN 
    historicoDisco AS hd ON hd.fk_totem = t.idTotem
JOIN 
    terminal AS ter ON t.fk_Terminal = ter.idTerminal
JOIN 
    historicoStatus AS hs ON hs.fk_totem = t.idTotem 
WHERE 
hs.statusTotem = 'Ativo' and hs.fk_Terminal = 1  and h.fk_Terminal = 1 and hd.fk_Terminal = 1;

	SELECT 
    h.fk_Terminal,
    SUM(CASE 
            WHEN h.UsoProcessador >= a.metricaProcessadorRangeAlerta 
            THEN 1 ELSE 0 END) AS totens_em_alerta,
    SUM(CASE 
            WHEN (h.UsoProcessador BETWEEN a.metricaProcessadorRangeLento AND a.metricaProcessadorRangeAlerta) 
            THEN 1 ELSE 0 END) AS totens_lentos,
    SUM(CASE 
            WHEN h.UsoProcessador < a.metricaProcessadorRangeLento 
            THEN 1 ELSE 0 END) AS totens_ok
	FROM 
    Historico h
	JOIN 
    totem t ON h.fk_Totem = t.idTotem
	JOIN 
    terminal tr ON h.fk_Terminal = tr.idTerminal
	JOIN 
    metrica a ON tr.id_empresa = a.fk_empresa
	WHERE
	tr.idTerminal =1;
    
    	SELECT 
    h.fk_Terminal,
    SUM(CASE 
            WHEN h.UsoProcessador >= a.metricaProcessadorRangeAlerta 
            THEN 1 ELSE 0 END) AS totens_em_alerta,
    SUM(CASE 
            WHEN (h.UsoProcessador BETWEEN a.metricaProcessadorRangeLento AND a.metricaProcessadorRangeAlerta) 
            THEN 1 ELSE 0 END) AS totens_lentos,
    SUM(CASE 
            WHEN h.UsoProcessador < a.metricaProcessadorRangeLento 
            THEN 1 ELSE 0 END) AS totens_ok
	FROM 
    Historico h
	JOIN 
    totem t ON h.fk_Totem = t.idTotem
	JOIN 
    terminal tr ON h.fk_Terminal = tr.idTerminal
	JOIN 
    metrica a ON tr.id_empresa = a.fk_empresa
	WHERE
	tr.idTerminal = 1;