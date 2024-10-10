-- a. Comece uma transação para inserir um novo membro e realizar um empréstimo. Caso ocorra algum erro, a transação deve ser revertida.
BEGIN;

-- Inserir novo membro
INSERT INTO Membros (id_membro, nome, data_adesao) 
VALUES (4, 'Ana Souza', '2024-09-25');

-- Inserir novo empréstimo
INSERT INTO Emprestimos (id_emprestimo, id_membro, id_livro, data_emprestimo, data_devolucao) 
VALUES (4, 4, 2, '2024-09-25', '2024-10-05');

-- Confirma a transação
COMMIT;

-- b. Realize uma transação para remover um livro e os respectivos empréstimos associados. Caso algum erro ocorra, a transação deve ser desfeita.
BEGIN;

-- Remover empréstimos associados ao livro
DELETE FROM Emprestimos WHERE id_livro = 3;

-- Remover livro
DELETE FROM Livros WHERE id_livro = 3;

-- Reverter se houver erro
ROLLBACK;

-- Confirmar se tudo estiver certo
COMMIT;

