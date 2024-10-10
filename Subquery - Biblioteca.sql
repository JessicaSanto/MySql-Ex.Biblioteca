-- a. Liste os autores que possuem livros com ano de publicação maior que a média de anos de publicação de todos os livros cadastrados.
SELECT nome 
FROM Autores 
WHERE id_autor IN (SELECT id_autor 
                   FROM Livros 
                   WHERE ano_publicacao > (SELECT AVG(ano_publicacao) FROM Livros));


-- b. Encontre os membros que realizaram mais de um empréstimo.
SELECT nome 
FROM Membros 
WHERE id_membro IN (SELECT id_membro 
                    FROM Emprestimos 
                    GROUP BY id_membro 
                    HAVING COUNT(id_emprestimo) > 1);

-- c. Liste os livros que foram emprestados ao menos uma vez.
SELECT titulo 
FROM Livros 
WHERE id_livro IN (SELECT id_livro FROM Emprestimos);

-- d. Consulte os livros que ainda não foram emprestados.
SELECT titulo 
FROM Livros 
WHERE id_livro NOT IN (SELECT id_livro FROM Emprestimos);

