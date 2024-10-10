use bibliotecadb;

-- ********  Exercicio 1. Crie uma stored procedure que insira um novo autor na tabela Autores.
DELIMITER $$

CREATE PROCEDURE AdicionarAutor (
	IN p_id INT,
    IN p_nome VARCHAR(255),
    IN p_data_nascimento DATE
)
BEGIN
    INSERT INTO Autores (id_autor, nome, data_nascimento)
    VALUES (p_id, p_nome, p_data_nascimento);
END $$

DELIMITER ;

CALL AdicionarAutor('4','J.K. Rowling', '1965-07-31');

SELECT * FROM Autores;

-- ********  Exercicio 2. Crie uma stored procedure para atualizar a data de devolução de um empréstimo já registrado.
DELIMITER $$

CREATE PROCEDURE AtualizarDataDevolucao (
    IN p_id_emprestimo INT,
    IN p_nova_data DATE
)
BEGIN
    UPDATE Emprestimos
    SET data_devolucao = p_nova_data
    WHERE id_emprestimo = p_id_emprestimo;
END $$

DELIMITER ;

CALL AtualizarDataDevolucao(1, '2024-10-25');

SELECT * FROM Emprestimos;


-- ********  Exercicio 3.  Crie uma stored procedure que consulte todos os livros emprestados por um determinado membro, retornando os títulos dos livros e as datas de empréstimo.
DELIMITER $$

CREATE PROCEDURE LivrosEmprestadosPorMembro (
    IN p_id_membro INT
)
BEGIN
    SELECT Livros.titulo, Emprestimos.data_emprestimo, Emprestimos.data_devolucao
    FROM Emprestimos
    JOIN Livros ON Emprestimos.id_livro = Livros.id_livro
    WHERE Emprestimos.id_membro = p_id_membro;
END $$

DELIMITER ;

CALL LivrosEmprestadosPorMembro(1);

-- ********  Exercicio 4. Crie uma stored procedure que registre um novo empréstimo, verificando se o membro e o livro existem.

DELIMITER $$

CREATE PROCEDURE RegistrarEmprestimo (IN p_id_emprestimo INT, IN p_id_membro INT, IN p_id_livro INT, IN p_data_emprestimo DATE, IN p_data_devolucao DATE)
BEGIN
    DECLARE v_count_membro INT;
    DECLARE v_count_livro INT;

    -- Verifica se o membro existe
    SELECT COUNT(*) INTO v_count_membro
    FROM Membros
    WHERE id_membro = p_id_membro;

    -- Verifica se o livro existe
    SELECT COUNT(*) INTO v_count_livro
    FROM Livros
    WHERE id_livro = p_id_livro;

    -- Se ambos existem, insere o empréstimo
    IF v_count_membro > 0 AND v_count_livro > 0 THEN
        INSERT INTO Emprestimos (id_emprestimo, id_membro, id_livro, data_emprestimo, data_devolucao)
        VALUES (p_id_emprestimo, p_id_membro, p_id_livro, p_data_emprestimo, p_data_devolucao);
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Membro ou Livro não encontrados';
    END IF;
END $$

DELIMITER ;


CALL RegistrarEmprestimo(4, 1, 2, '2024-10-10', '2024-10-20');

SELECT * FROM Emprestimos;

