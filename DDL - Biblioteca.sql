CREATE DATABASE bibliotecadb;

USE bibliotecadb;




CREATE TABLE Autores (
    id_autor INT PRIMARY KEY,
    nome VARCHAR(255),
    data_nascimento DATE
);

CREATE TABLE Livros (
    id_livro INT PRIMARY KEY,
    titulo VARCHAR(255),
    ano_publicacao INT,
    id_autor INT,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

CREATE TABLE Membros (
    id_membro INT PRIMARY KEY,
    nome VARCHAR(255),
    data_adesao DATE
);

CREATE TABLE Emprestimos (
    id_emprestimo INT PRIMARY KEY,
    id_membro INT,
    id_livro INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_membro) REFERENCES Membros(id_membro),
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);

