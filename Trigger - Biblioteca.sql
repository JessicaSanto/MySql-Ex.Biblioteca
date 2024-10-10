USE bibliotecadb;


-- Crie um trigger que, sempre que um novo pet for inserido na tabela, calcule automaticamente a idade do pet com base em sua data de nascimento e armazene esse valor na coluna idade.
DELIMITER //
CREATE TRIGGER CalcularIdadePet
BEFORE INSERT ON Pets
FOR EACH ROW
BEGIN
    SET NEW.idade = TIMESTAMPDIFF(YEAR, NEW.data_nascimento, CURDATE());
END //
DELIMITER ;


-- Criar uma trigger que impeça a inserção de autores com menos de 18 anos.
 DELIMITER //
CREATE TRIGGER VerificarIdadeAutor
BEFORE INSERT ON Autores
FOR EACH ROW
BEGIN
    IF (YEAR(CURDATE()) - YEAR(NEW.data_nascimento)) < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O autor deve ter pelo menos 18 anos.';
    END IF;
END //
DELIMITER ;
    
-- Criar uma trigger que atualize automaticamente a data de devolução para 15 dias após a data de empréstimo.
DELIMITER //
CREATE TRIGGER DefinirDataDevolucao
BEFORE INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    SET NEW.data_devolucao = DATE_ADD(NEW.data_emprestimo, INTERVAL 15 DAY);
END //
DELIMITER ;

-- Criar uma trigger que impeça que um membro faça mais de 3 empréstimos ao mesmo tempo.
DELIMITER //
CREATE TRIGGER LimitarEmprestimos
BEFORE INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    DECLARE total_empresas INT;

    SELECT COUNT(*)
    INTO total_empresas
    FROM Emprestimos
    WHERE id_membro = NEW.id_membro AND data_devolucao IS NULL;

    IF total_empresas >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O membro não pode ter mais de 3 empréstimos ativos.';
    END IF;
END //
DELIMITER ;

-- Criar uma trigger que atualize a data de adesão de um membro sempre que ele for inserido ou atualizado.
DELIMITER //
CREATE TRIGGER AtualizarDataAdesao
BEFORE INSERT ON Membros
FOR EACH ROW
BEGIN
    SET NEW.data_adesao = NOW();
END //
DELIMITER ;

-- Criar uma trigger que impeça a inserção de autores com nomes duplicados.
DELIMITER //
CREATE TRIGGER ValidarAutorDuplicado
BEFORE INSERT ON Autores
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Autores WHERE nome = NEW.nome) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O autor já está cadastrado.';
    END IF;
END //
DELIMITER ;


-- **************** 1. Trigger para a tabela Autores
-- Este trigger vai:
-- Verificar se o autor tem pelo menos 18 anos.
-- Impedir a inserção de autores com nomes duplicados.

DELIMITER //
CREATE TRIGGER VerificarInsercaoAutor
BEFORE INSERT ON Autores
FOR EACH ROW
BEGIN
    -- Verificar se o autor tem pelo menos 18 anos
    IF (YEAR(CURDATE()) - YEAR(NEW.data_nascimento)) < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O autor deve ter pelo menos 18 anos.';
    END IF;

    -- Impedir a inserção de autores com nomes duplicados
    IF EXISTS (SELECT 1 FROM Autores WHERE nome = NEW.nome) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O autor já está cadastrado.';
    END IF;
END //
DELIMITER ;


-- ******************* 2. Trigger para a tabela Emprestimos
-- Este trigger vai:
-- Definir a data de devolução automaticamente para 15 dias após a data de empréstimo.
-- Impedir que um membro faça mais de 3 empréstimos simultâneos.

DELIMITER //
CREATE TRIGGER VerificarInsercaoEmprestimo
BEFORE INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    DECLARE total_emprestimos INT;

    -- Definir a data de devolução para 15 dias após o empréstimo
    SET NEW.data_devolucao = DATE_ADD(NEW.data_emprestimo, INTERVAL 15 DAY);

    -- Verificar se o membro já tem 3 empréstimos ativos
    SELECT COUNT(*) INTO total_emprestimos
    FROM Emprestimos
    WHERE id_membro = NEW.id_membro AND data_devolucao IS NULL;

    IF total_emprestimos >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O membro não pode ter mais de 3 empréstimos ativos.';
    END IF;
END //
DELIMITER ;
