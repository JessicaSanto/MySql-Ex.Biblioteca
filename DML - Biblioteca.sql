INSERT INTO Autores (id_autor, nome, data_nascimento)
VALUES
(1, 'Machado de Assis', '1839-06-21'),
(2, 'J. K. Rowling', '1965-07-31'),
(3, 'George Orwell', '1903-06-25');

INSERT INTO Livros (id_livro, titulo, ano_publicacao, id_autor)
VALUES
(1, 'Dom Casmurro', 1899, 1),
(2, 'Harry Potter e a Pedra Filosofal', 1997, 2),
(3, '1984', 1949, 3);

INSERT INTO Membros (id_membro, nome, data_adesao)
VALUES
(1, 'Maria Silva', '2024-01-15'),
(2, 'João Pereira', '2023-10-22'),
(3, 'Carlos Lima', '2023-07-30');

INSERT INTO Emprestimos (id_emprestimo, id_membro, id_livro, data_emprestimo, data_devolucao)
VALUES
(1, 1, 1, '2024-09-01', '2024-09-10'),
(2, 2, 2, '2024-09-02', '2024-09-11'),
(3, 3, 3, '2024-09-05', '2024-09-14');

