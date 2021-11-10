CREATE DATABASE comerciodb;
USE comerciodb;

-----------CRIANDO AS TABELAS

CREATE TABLE cliente(
	cpf VARCHAR(12) NOT NULL,
	nome VARCHAR(100) NOT NULL,
	telefone VARCHAR(12) NOT NULL
	
	PRIMARY KEY(cpf)
)

CREATE TABLE fornecedor(
	id INT IDENTITY,
	nome VARCHAR(100),
	logradouro VARCHAR(100),
	num VARCHAR(10),
	complemento VARCHAR(100),
	cidade VARCHAR(100)
	
	PRIMARY KEY(id)
)

CREATE TABLE produto(
	codigo INT IDENTITY,
	descricao VARCHAR(100),
	id_fornecedor INT NOT NULL,
	preco DECIMAL(10,2) NOT NULL
	
	PRIMARY KEY(codigo),
	FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id)
)


CREATE TABLE venda(
	codigo INT NOT NULL,
	codigo_produto INT NOT NULL,
	cpf_cliente VARCHAR(12) NOT NULL,
	quantidade INT NOT NULL,
	valor_total DECIMAL(10,2) NOT NULL,
	data DATE
	
	PRIMARY KEY(codigo, codigo_produto, cpf_cliente),
	FOREIGN KEY(codigo_produto) REFERENCES produto(codigo),
	FOREIGN KEY(cpf_cliente) REFERENCES cliente(cpf)
)

------INSERINDO DADOS
INSERT INTO cliente(cpf, nome, telefone)VALUES
('34578909290', 'Julio Cesar', '82736541'),
('25186533710', 'Maria Antonia', '87652314'),
('87627315416', 'Luiz Carlos', '61289012'),
('79182639800', 'Paulo Cesar', '90765273')

INSERT INTO fornecedor(nome, logradouro, num, complemento, cidade) VALUES
('LG','Rod. Bandeirantes', '70000', 'Km 70', 'Itapeva'),
('Asus','Av. Nações Unidas', '10206', 'Sala 225', 'São Paulo'),
('AMD','Av. Nações Unidas', '10206', 'Sala 1095', 'São Paulo'),
('Leadership','Av. Nações Unidas', '10206', 'Sala 87', 'São Paulo'),
('Inno','Av. Nações Unidas', '10206', 'Sala 34', 'São Paulo')

INSERT INTO produto(descricao, id_fornecedor, preco) VALUES
('Monitor 19 pol.', 1, 449.99),
('Netbook 1GB Ram 4 Gb HD', 2, 699.99),
('Gravador de DVD - Sata', 1, 99.99),
('Leitor de CD', 1, 49.99),
('Processador - Phenom X3 - 2.1GHz', 3, 349.99),
('Mouse', 4, 19.99),
('Teclado', 4, 25.99),
('Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5, 599.99)

INSERT INTO venda(codigo, codigo_produto, cpf_cliente, quantidade, valor_total, data) VALUES
(1, 1, '25186533710', 1, 499.99, '2009-09-03'),
(1, 4, '25186533710', 1, 49.99, '2009-09-03'),
(1, 5, '25186533710', 1, 349.99, '2009-09-03'),
(2, 6, '79182639800', 4, 79.96, '2009-09-06'),
(3, 8, '87627315416', 1, 599.99, '2009-09-06'),
(3, 3, '87627315416', 1, 99.99, '2009-09-06'),
(3, 7, '87627315416', 1, 25.99, '2009-09-06'),
(4, 2, '34578909290', 2, 1399.98, '2009-09-08')


-------------------------------- CONSULTAS
-----DATA DA VENDA 4
SELECT CONVERT(CHAR(11), data, 103) AS data_venda
FROM venda
WHERE codigo = 4

----INSERIR COLUNA TELEFONE NA TABELA FORNECEDOR
ALTER TABLE fornecedor
ADD telefone VARCHAR(12)

UPDATE fornecedor
SET telefone = '72165371'
WHERE id = 1

UPDATE fornecedor
SET telefone = '87153738'
WHERE id = 2

UPDATE fornecedor
SET telefone = '36546289'
WHERE id = 4

--Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores
SELECT nome, (logradouro+', '+num + 'º ' + complemento + ' - '+ cidade) AS endereco, telefone
FROM fornecedor 
ORDER BY nome


--Produto, quantidade e valor total do comprado por Julio Cesar
SELECT p.descricao AS produto, v.quantidade, v.valor_total, c.nome AS cliente
FROM produto p, venda v, cliente c 
WHERE v.cpf_cliente = c.cpf
AND v.codigo_produto = p.codigo
AND c.nome = 'Julio Cesar'

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar
SELECT CONVERT(CHAR(11), v.data, 103) AS data_venda, v.valor_total, c.nome
FROM venda v, cliente c
WHERE v.cpf_cliente = c.cpf
AND c.nome = 'Paulo Cesar'

--Consultar, em ordem decrescente, o nome e o preço de todos os produtos 
SELECT descricao, preco 
FROM produto
ORDER BY descricao DESC


exec sp_columns cliente
exec sp_columns fornecedor
exec sp_columns produto
exec sp_columns venda




