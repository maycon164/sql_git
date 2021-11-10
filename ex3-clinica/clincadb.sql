CREATE DATABASE  clinicadb;
USE clinicadb;

---------------------------CRIANDO AS TABELAS
CREATE TABLE paciente(
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(100),
	rua VARCHAR(100),
	num VARCHAR(5),
	bairro VARCHAR(100),
	telefone VARCHAR(11),
	nascimento DATE
	
	PRIMARY KEY(cpf)
)
DROP TABLE pacientes

CREATE TABLE medico(
	codigo INT IDENTITY,
	nome VARCHAR(100),
	especialidade VARCHAR(100)
	
	PRIMARY KEY(codigo)
)

CREATE TABLE prontuario(
	data DATE NOT NULL,
	cpf_paciente VARCHAR(11) NOT NULL,
	codigo_medico INT NOT NULL,
	diagnostico VARCHAR(100),
	medicamento VARCHAR(100)
	
	PRIMARY KEY(data, cpf_paciente, codigo_medico),
	FOREIGN KEY (cpf_paciente) REFERENCES paciente(cpf),
	FOREIGN KEY (codigo_medico) REFERENCES medico(codigo)
)

--------------------------INSERINDO DADOS NAS TABELAS
INSERT INTO paciente(cpf, nome, rua, num, bairro, telefone, nascimento) VALUES
('35454562890', 'José Rubens', 'Campos Salles', '2750', 'Centro', '21450998', '1954-10-18'),
('29865439810', 'Ana Claudia', 'Sete de Setembro', '178', 'Centro', '97382764', '1960-05-29'),
('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', '236', 'Vila Galvão', '68172651', '1980-09-24'),
('12386758770', 'Maria Rita', 'Castello Branco', '7765', 'Vila Rosália', null, '1975-03-30'),
('92173458910', 'Joana de Souza', 'XV de Novembro', '298', 'Centro', '21276578', '1944-04-24')

INSERT INTO medico(nome, especialidade) VALUES
('Wilson Cesar', 'Pediatra'),
('Marcia Matos', 'Geriatra'),
('Carolina Oliveira', 'Ortopedista'),
('Vinicius Araujo', 'Clínico Geral')

INSERT INTO prontuario (data, cpf_paciente, codigo_medico, diagnostico, medicamento) VALUES
('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra'),
('2020-09-10', '92173458910', 2, 'Renite Alérgica', 'Allegra'),
('2020-09-12', '29865439810', 1, 'Inflamação de garganta', 'Nimesulida'),
('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu'),
('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin'),
('2020-09-15', '12386758770', 3, 'Braço Quebrado', 'Dorflex + Gesso')



------------------CONSULTAS
--nome e endereco dos pacientes com mais de 50 anos
SELECT nome, (bairro + ' - ' + rua + ' - ' + num) AS endereco, 
CONVERT(CHAR(11), nascimento, 103) AS data_nascimento 
FROM paciente
WHERE (CAST(YEAR(GETDATE()) AS INT) - CAST(YEAR(nascimento) AS INT)) > 50

--especialidade de carolina
SELECT nome, especialidade FROM medico
WHERE nome = 'Carolina Oliveira'

--medicamento para reumatismo
SELECT diagnostico, medicamento FROM prontuario 
WHERE diagnostico = 'Reumatismo'

-------------------------CONSULTAS COM SUBQUERIES
---consultas do JOSE RUBENS
SELECT cpf_paciente, diagnostico, medicamento FROM prontuario 
WHERE cpf_paciente IN (
	SELECT cpf FROM paciente 
	WHERE nome = 'José Rubens'
)

---medicos que atendem JOSE RUBENS, se especialidae +3 letras 
SELECT nome, 
CASE WHEN LEN(especialidade) > 3
	THEN
		SUBSTRING(especialidade, 1, 3) + '.'
	ELSE
		especialidade
END AS especialidade
FROM medico
WHERE codigo IN (
	SELECT codigo_medico FROM prontuario
	WHERE cpf_paciente IN(
		SELECT cpf FROM paciente
		WHERE nome = 'José Rubens'
	)
)

-- cpf formatado, nome, endereco completo, telefone se nulo mostrar traco dos pacientes do medico Vinicius
SELECT (SUBSTRING(cpf, 1, 3) +'.'+SUBSTRING(cpf, 4, 3)+'.' + SUBSTRING(cpf, 7,3)+'-'+SUBSTRING(cpf, 10, 2) ) AS cpf_format,
nome, (rua + ', ' + num+'º -'+ bairro) AS endereco,
CASE WHEN telefone IS NULL
THEN
	'-----'
ELSE
	SUBSTRING(telefone, 1, 4) + '-' + SUBSTRING(telefone, 5, 4)  
END AS telefone
FROM paciente 
WHERE cpf IN (
	SELECT cpf_paciente FROM prontuario
	WHERE codigo_medico IN (
		SELECT codigo FROM medico
		WHERE nome LIKE '%Vinicius%'
	)

)

--QUANTOS DIAS FAZEM DA CONSULTA DE MARIA RITA ATE HOJE

SELECT DATEDIFF(DAY, data, GETDATE()) as dias
FROM prontuario 
WHERE cpf_paciente IN (
	SELECT cpf FROM paciente
	WHERE nome = 'Maria Rita'
)


---------------------------------ALTERACOES NAS TABELAS
--setar numero para Maria Rita
UPDATE paciente
SET telefone = '98345621'
WHERE nome = 'Maria Rita'

-- alterar o endereco de Joana de Souza para Voluntários da Pátria, 1980, Jd. Aeroporto
UPDATE paciente
SET bairro = 'Jd. Aeroporto',
num =  '1980',
rua = 'Voluntários da Pátria'
WHERE nome = 'Joana de Souza'


SELECT * FROM paciente


exec sp_columns paciente;
exec sp_columns medico;
exec sp_columns prontuario;


