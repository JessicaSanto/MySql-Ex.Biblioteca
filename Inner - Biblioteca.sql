USE bibliotecadb;

-- INNER JOIN
-- Exercício 1: Liste os nomes dos membros que pegaram livros 
-- emprestados e o título dos livros que eles emprestaram.
SELECT nome, data_emprestimo, titulo FROM tb_membros AS M
INNER JOIN tb_emprestimo AS E ON M.id = E.id_membro
INNER JOIN tb_livros AS L ON E.id_livro = L.id;

SELECT * FROM tb_membros;
-- Exercício 2: Liste os autores e os livros que foram emprestados.
SELECT nome, titulo, ano_publicacao, data_emprestimo 
FROM tb_autores AS A
INNER JOIN tb_livros AS L ON A.id = L.id_autor
INNER JOIN tb_emprestimo AS E ON L.id = E.id_livro;

-- RIGHT / LEFT JOIN
-- Exercício 1:  Liste todos os membros que não 
-- realizaram nenhum empréstimo.
-- RIGHT JOIN
SELECT * FROM tb_emprestimo AS E
RIGHT JOIN tb_membros AS M
ON M.id = E.id_membro
WHERE E.id IS NULL;

-- LEFT JOIN
SELECT * FROM tb_membros AS M
LEFT JOIN tb_emprestimo AS E
ON M.id = E.id_membro
WHERE E.id IS NULL;

-- Exercício 2:  Liste todos os autores e seus livros que não foram emprestados.
SELECT titulo, nome, data_emprestimo 
FROM tb_livros AS L
LEFT JOIN tb_emprestimo AS E 
ON L.id = E.id_livro
INNER JOIN tb_autores AS A 
ON L.id_autor = A.id
WHERE E.id IS NULL;


-- UNION
-- Exercício 1: Liste todos os livros e seus autores, incluindo livros que não têm 
-- autores associados e autores que não têm livros cadastrados.
-- Livros com ou sem autores associados
SELECT L.titulo, A.nome FROM tb_livros AS L
LEFT JOIN tb_autores AS A 
ON L.id_autor = A.id
UNION
-- Autores com ou sem livros associados
SELECT L.titulo, A.nome FROM tb_autores AS A
LEFT JOIN tb_livros AS L
ON L.id_autor = A.id
WHERE titulo is null;

-- Exercício 2: Liste todos os membros e livros emprestados, 
-- incluindo membros que não pegaram livros e livros que não 
-- foram emprestados.
SELECT * FROM tb_membros AS M 
LEFT JOIN tb_emprestimo AS E ON M.id = E.id_membro
LEFT JOIN tb_livros AS L ON L.id = E.id_livro;





