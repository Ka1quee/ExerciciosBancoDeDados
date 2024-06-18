CREATE DATABASE DB_CDS;
USE DB_CDS;

CREATE TABLE Artista(
    Cod_Art INT AUTO_INCREMENT NOT NULL,
    Nome_Art VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_Cod_Art PRIMARY KEY (Cod_Art)
);

CREATE TABLE Gravadora(
    Cod_Grav INT AUTO_INCREMENT NOT NULL,
    Nome_Grav VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT pk_Cod_Grav PRIMARY KEY (Cod_Grav)
);

CREATE TABLE Categoria(
    Cod_Cat INT AUTO_INCREMENT NOT NULL,
    Nome_Cat VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT pk_Cod_Cat PRIMARY KEY (Cod_Cat)
);

CREATE TABLE Estado(
    Sigla_Est CHAR(2) NOT NULL,
    Nome_Est CHAR(50) NOT NULL UNIQUE,
    CONSTRAINT pk_Sigla_Est PRIMARY KEY (Sigla_Est)
);

CREATE TABLE Cidade(
    Cod_Cid INT AUTO_INCREMENT NOT NULL,
    Nome_Cid VARCHAR(100) NOT NULL,
    fk_Sigla_Est CHAR(2) NOT NULL,
    CONSTRAINT fk_Sigla_Est FOREIGN KEY (fk_Sigla_Est) REFERENCES Estado(Sigla_Est),
    CONSTRAINT pk_Cod_Cid PRIMARY KEY (Cod_Cid)
);

CREATE TABLE Cliente(
    Cod_Cli INT AUTO_INCREMENT NOT NULL,
    Nome_Cli VARCHAR(100) NOT NULL,
    Renda_Cli DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_Renda_Cli CHECK (Renda_Cli >= 0),
    Sexo_Cli ENUM('m', 'h', 't') NOT NULL,
    fk_Cod_Cid INT NOT NULL,
    CONSTRAINT fk_Cod_Cid FOREIGN KEY (fk_Cod_Cid) REFERENCES Cidade(Cod_Cid),
    CONSTRAINT pk_Cod_Cli PRIMARY KEY (Cod_Cli)
);

CREATE TABLE Conjuge(
    Cod_Conjuge INT AUTO_INCREMENT NOT NULL,
    Nome_Conjuge VARCHAR(100) NOT NULL,
    Renda_Conjuge DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_Renda_Conjuge CHECK (Renda_Conjuge >= 0),
    Sexo_Conjuge ENUM('m', 'h', 't') NOT NULL,
    fk_Cod_Cli INT NOT NULL,
    CONSTRAINT fk_Cod_Cli FOREIGN KEY (fk_Cod_Cli) REFERENCES Cliente(Cod_Cli),
    CONSTRAINT pk_Cod_Conjuge PRIMARY KEY (Cod_Conjuge)
);

CREATE TABLE Funcionario (
    Cod_Func INT AUTO_INCREMENT NOT NULL,
    Nome_Func VARCHAR(100) NOT NULL,
    End_Func VARCHAR(200) NOT NULL,
    Sal_Func DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Sexo_Func ENUM('M', 'F') NOT NULL DEFAULT 'M',
    CONSTRAINT chk_Sal_Func CHECK (Sal_Func >= 0),
    CONSTRAINT pk_Cod_Func PRIMARY KEY (Cod_Func)
);

CREATE TABLE Dependente(
    Cod_Dep INT AUTO_INCREMENT NOT NULL,
    Nome_Dependente VARCHAR(100) NOT NULL,
    Sexo_Dep ENUM('m', 'h', 't') NOT NULL,
    fk_Cod_Func INT NOT NULL,
    CONSTRAINT fk_Cod_Func FOREIGN KEY (fk_Cod_Func) REFERENCES Funcionario(Cod_Func),
    CONSTRAINT pk_Cod_Dep PRIMARY KEY (Cod_Dep)
);

CREATE TABLE Titulo (
    Cod_Tit INT AUTO_INCREMENT NOT NULL,
    Cod_Cat INT NOT NULL,
    Cod_Grav INT NOT NULL,
    Nome_CD VARCHAR(100) NOT NULL UNIQUE,
    Val_CD DECIMAL(10,2) NOT NULL,
    Qtd_Estq INT NOT NULL,
    CONSTRAINT fk_Cod_Cat FOREIGN KEY (Cod_Cat) REFERENCES Categoria(Cod_Cat),
    CONSTRAINT fk_Cod_Grav FOREIGN KEY (Cod_Grav) REFERENCES Gravadora(Cod_Grav),
    CONSTRAINT pk_Cod_Tit PRIMARY KEY (Cod_Tit),
    CONSTRAINT chk_Val_CD CHECK (Val_CD > 0),
    CONSTRAINT chk_Qtd_Estq CHECK (Qtd_Estq >= 0)
);

CREATE TABLE Pedido (
    Num_Ped INT AUTO_INCREMENT NOT NULL,
    Cod_Cli INT NOT NULL,
    Cod_Func INT NOT NULL,
    Data_Ped DATETIME NOT NULL,
    Val_Ped DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_Cod_Cli FOREIGN KEY (Cod_Cli) REFERENCES Cliente(Cod_Cli),
    CONSTRAINT fk_Cod_Func FOREIGN KEY (Cod_Func) REFERENCES Funcionario(Cod_Func),
    CONSTRAINT pk_Num_Ped PRIMARY KEY (Num_Ped),
    CONSTRAINT chk_Val_Ped CHECK (Val_Ped >= 0)
);

CREATE TABLE Titulo_Pedido (
    Num_Ped INT NOT NULL,
    Cod_Tit INT NOT NULL,
    Qtd_Estq INT NOT NULL,
    Val_CD DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_Num_Ped FOREIGN KEY (Num_Ped) REFERENCES Pedido(Num_Ped),
    CONSTRAINT fk_Cod_Tit FOREIGN KEY (Cod_Tit) REFERENCES Titulo(Cod_Tit),
    CONSTRAINT pk_Titulo_Pedido PRIMARY KEY (Num_Ped, Cod_Tit),
    CONSTRAINT chk_Qtd_Estq CHECK (Qtd_Estq >= 1),
    CONSTRAINT chk_Val_CD CHECK (Val_CD > 0)
);

CREATE TABLE Titulo_Artista (
    Cod_Tit INT NOT NULL,
    Cod_Art INT NOT NULL,
    CONSTRAINT fk_Cod_Tit FOREIGN KEY (Cod_Tit) REFERENCES Titulo(Cod_Tit),
    CONSTRAINT fk_Cod_Art FOREIGN KEY (Cod_Art) REFERENCES Artista(Cod_Art),
    CONSTRAINT pk_Titulo_Artista PRIMARY KEY (Cod_Tit, Cod_Art)
);
