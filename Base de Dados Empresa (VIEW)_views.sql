select * from fornecedores;
select * from marcas;
select * from produtos;
select * from produtos_has_fornecedores;
select * from produtos_com_marcas;
select * from produtos_com_fornecedores;
select * from produtos_com_marcas_e_fornecedores;
select * from produtos_com_estoque_baixo;
select * from produtos_com_validade_vencida;

-- Alterado o estoque mínimo de um produto para testar a view. pois os produtos nao estava atinguindo o minimo
UPDATE `produtos` SET `prd_qtd_estoque` = 10, `prd_estoque_min` = 20 WHERE `prd_id` = 1;




-- Esta view mostra a lista de produtos com seus IDs, nomes e marcas correspondentes.
CREATE VIEW produtos_com_marcas AS
SELECT p.prd_id, p.prd_nome, m.mrc_nome AS marca
FROM produtos p
INNER JOIN marcas m ON p.prd_marcas_id = m.mrd_id;

-- Esta view mostra a lista de produtos com seus IDs, nomes e fornecedores correspondentes.
CREATE VIEW produtos_com_fornecedores AS
SELECT p.prd_id, p.prd_nome, f.frn_nome AS fornecedor
FROM produtos p
INNER JOIN produtos_has_fornecedores pf ON p.prd_id = pf.pf_prod_id
INNER JOIN fornecedores f ON pf.pf_forn_id = f.frn_id;

-- Esta view mostra a lista de produtos com seus IDs, nomes, marcas e fornecedores correspondentes.
CREATE VIEW produtos_com_marcas_e_fornecedores AS
SELECT p.prd_id, p.prd_nome, m.mrc_nome AS marca, f.frn_nome AS fornecedor
FROM produtos p
INNER JOIN marcas m ON p.prd_marcas_id = m.mrd_id
INNER JOIN produtos_has_fornecedores pf ON p.prd_id = pf.pf_prod_id
INNER JOIN fornecedores f ON pf.pf_forn_id = f.frn_id;

CREATE OR REPLACE VIEW produtos_com_estoque_baixo AS
SELECT * FROM produtos WHERE prd_qtd_estoque < prd_estoque_min;

-- Adicionando o campo de data de validade à tabela `produtos`.
ALTER TABLE `produtos` ADD COLUMN `prd_data_validade` DATE;

-- Inserindo dados com a data de validade para alguns produtos.
UPDATE `produtos` SET `prd_data_validade` = '2023-12-31' WHERE `prd_id` IN (1, 4, 6, 9, 10, 11, 12, 13, 15, 16, 18, 19);

ALTER TABLE `produtos` ADD COLUMN `prd_data_validade` DATE;

-- Inserir produtos para a primeira marca (ID 1)
INSERT INTO `produtos` (`prd_nome`, `prd_qtd_estoque`, `prd_estoque_min`, `prd_data_fabricacao`, `prd_perecivel`, `prd_valor`, `prd_marcas_id`, `prd_data_validade`)
VALUES
('Chocolate Ao Leite', 200, 20, '2023-10-15', 'Sim', 3.99, 1, '2024-01-15'),
('Biscoitos de Aveia', 150, 15, '2023-10-20', 'Sim', 2.49, 1, '2024-02-01'),
('Batata Chips', 180, 18, '2023-10-25', 'Sim', 1.99, 1, '2023-12-31');

-- Inserindo produtos com data de validade vencida (subtraindo 90 dias da data atual)
INSERT INTO `produtos` (`prd_nome`, `prd_qtd_estoque`, `prd_estoque_min`, `prd_data_fabricacao`, `prd_perecivel`, `prd_valor`, `prd_marcas_id`, `prd_data_validade`) VALUES
('Leite Vencido', 50, 20, '2023-07-15', 'Sim', 4.99, 1, DATE_SUB(CURDATE(), INTERVAL 90 DAY)),
('Arroz Vencido', 30, 50, '2023-06-20', 'Não', 3.50, 2, DATE_SUB(CURDATE(), INTERVAL 105 DAY)),
('Feijão Vencido', 20, 30, '2023-05-12', 'Não', 4.25, 2, DATE_SUB(CURDATE(), INTERVAL 120 DAY));



CREATE VIEW produtos_com_validade_vencida AS
SELECT p.prd_id, p.prd_nome, p.prd_data_validade, m.mrc_nome AS marca
FROM produtos p
INNER JOIN marcas m ON p.prd_marcas_id = m.mrd_id
WHERE p.prd_data_validade < CURDATE();

SELECT prd_id, prd_nome, prd_valor
FROM produtos
WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);

