CREATE DATABASE faculdadedb;
USE faculdadedb;

-------------CRIANDO AS TABELAS
CREATE TABLE aluno(
	ra INT IDENTITY(12345, 1),
	nome VARCHAR(50),
	sobrenome VARCHAR(50),
	rua VARCHAR(100),
	num VARCHAR(5),
	bairro VARCHAR(100),
	cep VARCHAR(11),
	telefone VARCHAR(11)
	
	PRIMARY KEY(ra)
)

DROP TABLE aluno;

CREATE TABLE curso(
	codigo INT IDENTITY,
	nome VARCHAR(100),
	carga_horaria  INT,
	turno VARCHAR(50)
	
	PRIMARY KEY(codigo)
)

CREATE TABLE disciplina(
	codigo INT IDENTITY,
	nome VARCHAR(100),
	carga_horaria INT,
	turno VARCHAR(50),
	semestre INT,
	
	PRIMARY KEY(codigo)
)

------------------INSERINDO NO BANCO DE DADOS
--TABELA ALUNO
INSERT INTO aluno(nome, sobrenome, rua, num, bairro, cep,telefone) VALUES
('José', 'Silva', 'Almirante Noronha', '236', 'Jardim São Paulo', '1589000', '69875287'),
('Ana', 'Maria Bastos', 'Anhaia', '1568', 'Barra Funda', '3569000', '25698526'),
('Mario', 'Santos', 'XV de Novembro', '1841', 'Centro', '1020030', null),
('Marcia', 'Neves', 'Voluntários da Patria', '225', 'Santana', '2785090', '78964152')

--TABELA CURSOS
INSERT INTO curso (nome, carga_horaria, turno) VALUES
('Informática', 2800, 'Tarde'),
('Informática', 2800, 'Noite'),
('Logística', 2650, 'Tarde'),
('Logística', 2650, 'Noite'),
('Plásticos', 2500, 'Tarde'),
('Plásticos', 2500, 'Noite')

--TABELA DISCIPLINA
INSERT INTO disciplina(nome, carga_horaria, turno, semestre) VALUES
('Informática', 4, 'Tarde', 1),
('Informática', 4, 'Noite', 1),
('Quimica', 4, 'Tarde', 1),
('Quimica', 4, 'Noite', 1),
('Banco de Dados I', 2, 'Tarde', 3),
('Banco de Dados I', 2, 'Noite', 3),
('Estrutura de Dados', 4, 'Tarde', 4),
('Estrutura de Dados', 4, 'Noite', 4)

SELECT * FROM aluno;
SELECT * FROM curso;
SELECT * FROM disciplina;


------------------REALIZANDO SIMPLES QUERYS
-- NOME COMPLETO
SELECT (nome +' '+ sobrenome) AS nome_completo
FROM aluno

-- ALUNO QUE NÃO TEM TELEFONE
SELECT rua, num, bairro, cep 
FROM aluno
WHERE telefone IS NULL

-- TELEFONE DO ALUNO COM RA 12348
SELECT nome, telefone
FROM aluno
WHERE ra = 12348

-- SEMESTRE DO CURSO DE BANCO DE DADOS
SELECT nome, semestre, turno
FROM disciplina
WHERE nome = 'Banco de Dados I'
AND  turno = 'Noite'

exec sp_columns aluno;
exec sp_columns curso;
exec sp_columns disciplina;
