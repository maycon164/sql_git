CREATE DATABASE mecanicobd;
USE mecanicobd;

------------------------CRIANDO TABELAS

CREATE TABLE cliente(
	id INT IDENTITY,
	nome VARCHAR(100),
	logradouro VARCHAR(100),
	num INT,
	bairro VARCHAR(100),
	telefone VARCHAR(8)
	
	PRIMARY KEY (id)
)

CREATE TABLE carro(
	placa VARCHAR(10) NOT NULL,
	marca VARCHAR(50),
	modelo VARCHAR(50),
	cor VARCHAR(50),
	ano INT,
	id_cliente INT NOT NULL
	
	PRIMARY KEY(placa),
	FOREIGN KEY(id_cliente) REFERENCES cliente(id)
)

CREATE TABLE peca(
	id INT IDENTITY,
	nome VARCHAR(50),
	valor INT
	
	PRIMARY KEY(id)
)

CREATE TABLE servico(
	id INT IDENTITY,
	placa_carro VARCHAR(10),
	id_peca INT,
	quantidade INT,
	valor DECIMAL(10,2),
	data DATE
	
	PRIMARY KEY(id),
	FOREIGN KEY (placa_carro) REFERENCES carro(placa),
	FOREIGN KEY (id_peca) REFERENCES peca(id)
)


--------------INSERINDO DADOS NA TABELA
---cliente
INSERT INTO cliente (nome, logradouro, num, bairro, telefone) VALUES
('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '21549658'),
('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '96588541'),
('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '24589658'),
('José Simões', 'R. XV de Novembro', 36, 'Água Branca', '78952459'),
('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '69582548')


--carro
INSERT INTO carro(placa, marca, modelo, cor, ano, id_cliente) VALUES
('AFT9087', 'VW', 'Gol', 'Preto', 2007, 5),
('DXO9876', 'Ford', 'Ka', 'Azul', 2000, 1),
('EGT4631', 'Renault', 'Clio', 'Verde', 2004, 3),
('LKM7380', 'Fiat', 'Palio', 'Prata', 1997, 2),
('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999, 4)

--peca
INSERT INTO peca (nome, valor) VALUES
('Vela', 70),
('Correia Dentada', 125),
('Trambulador', 90),
('Filtro de Ar', 30)

--servico
INSERT INTO servico(placa_carro, id_peca, quantidade, valor, data) VALUES
('DXO9876', 1, 4, 280.00, '2020-08-01'),
('DXO9876', 4, 1, 30.00, '2020-08-01'),
('EGT4631', 3, 1, 90.00, '2020-08-02'),
('DXO9876', 2, 1, 125.00, '2020-08-07')


---------------------------CONSULTAS COM SUBQUERIES----------------------

--Telefone do dono do carro Ka, Azul
SELECT nome, telefone FROM cliente
WHERE id IN (

	SELECT id_cliente
	FROM carro
	WHERE modelo = 'Ka' AND cor = 'Azul'

)

--Endereço concatenado do cliente que fez o serviço do dia 02/08/2009

SELECT (logradouro + ' - ' + bairro  + ' - ' + CAST(num AS VARCHAR)) AS endereco_completo, nome
FROM cliente
WHERE id IN (
		SELECT id_cliente FROM carro
		WHERE placa IN (
			SELECT placa_carro FROM servico
			WHERE data = '2020-08-02'
		)
)

---------------------------CONSULTAS----------------------

--placa dos carros de anos anteriores a 2001
SELECT placa, modelo, ano
FROM carro
WHERE ano < 2001

--carros posteriores a 2005
SELECT marca+' - '+ modelo +' - '+ cor AS caracteristicas, ano
FROM carro 
WHERE ano > 2005

--codigo, nome das pecas que custam menos de R$80.00
SELECT id, nome, valor FROM peca
WHERE valor < 80

SELECT * FROM carro;

exec sp_columns cliente;
exec sp_columns carro;
exec sp_columns peca;
exec sp_columns servico;
