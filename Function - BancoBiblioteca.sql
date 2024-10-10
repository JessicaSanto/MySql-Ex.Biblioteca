use bibliotecadb;


SELECT * FROM tb_autores;
-- Exercicio 1. Crie uma função que recebe o id_autor e retorna a idade do autor com base na data de nascimento.
-- Recebe o id_autor
-- Retorna a idade 
DELIMITER $$
CREATE FUNCTION calculoIdadeAutor(id_autorp INT(10))
RETURNS INT
READS SQL DATA
BEGIN

DECLARE idade_autor INT(10);
SELECT TIMESTAMPDIFF(YEAR,data_nascimeto, CURDATE()) INTO idade_autor FROM tb_autores WHERE id = id_autorp;

RETURN idade_autor;

END $$
DELIMITER ; 

SELECT calculoIdadeAutor('Colleen Hoover');


-- Exercicio 2. Crie uma função que recebe o id_autor e retorna a quantidade de livros escritos por esse autor.
-- Recebe o id_autor
-- Retorna a quantidade de livros
DELIMITER $$
CREATE FUNCTION contarLivrosAutor(id_autorp INT(10))
RETURNS INT
READS SQL DATA
BEGIN

DECLARE quantidade_livros INT(10);
SELECT COUNT(id) INTO quantidade_livros FROM tb_livros WHERE id_autor = id_autorp;
RETURN quantidade_livros;

END $$
DELIMITER ;

SELECT contarLivrosAutor(1);


-- Exercicio 3. Crie uma função que recebe duas datas e retorna o total de empréstimos realizados nesse período.
-- Receber duas datas
-- Retornar o total de emprestimo
DELIMITER $$
CREATE FUNCTION totalEmprestimo(data_inicial DATE, data_final DATE)
RETURNS INT
READS SQL DATA
BEGIN

DECLARE total_emprestimo INT(10);
SELECT COUNT(id) INTO total_emprestimo FROM tb_emprestimo WHERE data_emprestimo BETWEEN data_inicial AND data_final;
RETURN total_emprestimo;

END $$
DELIMITER ; 

SELECT totalEmprestimo('2023-06-20', '2024-10-09');


-- Exercicio 4. Crie uma função que retorna a média de dias em que os livros foram emprestados.
DELIMITER $$
CREATE FUNCTION mediaEmprestimo()
RETURNS DECIMAL(5,1)
READS SQL DATA
BEGIN

DECLARE media DECIMAL(5,1);

SELECT AVG(DATEDIFF(data_devolucao, data_emprestimo)) INTO media FROM tb_emprestimo WHERE data_devolucao IS NOT NULL;
RETURN media;

END $$
DELIMITER ;

SELECT mediaEmprestimo();






