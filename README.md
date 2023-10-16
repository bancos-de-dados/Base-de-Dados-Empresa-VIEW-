# Base de Dados Empresa (VIEW)
## Descrição
Foi criado um banco de dados para gerenciar informações sobre produtos, marcas e fornecedores. Ele inclui tabelas para armazenar dados, como nome do produto, quantidade em estoque, preço, data de fabricação e validade. O código também insere dados fictícios nessas tabelas e cria visualizações para mostrar produtos com estoque baixo e produtos com validade vencida. Além disso, há consultas que selecionam produtos com preços acima da média. Este esquema básico pode ser modificado e expandido para atender a diferentes necessidades de aplicativos de gerenciamento de produtos.

## views

## 1 Crie uma view que mostra todos os produtos e suas respectivas marcas;

    -- Esta view mostra a lista de produtos com seus IDs, nomes e marcas correspondentes.
    CREATE VIEW produtos_com_marcas AS
    SELECT p.prd_id, p.prd_nome, m.mrc_nome AS marca
    FROM produtos p
    INNER JOIN marcas m ON p.prd_marcas_id = m.mrd_id;

![Base de Dados Empresa (VIEW)](https://github.com/bancos-de-dados/Base-de-Dados-Empresa-VIEW-/assets/127689567/eb3c9995-8931-4ad6-af9f-47aca0a46160)


## 2 Crie uma view que mostra todos os produtos e seus respectivos fornecedores;

    -- Esta view mostra a lista de produtos com seus IDs, nomes e fornecedores correspondentes.
    CREATE VIEW produtos_com_fornecedores AS
    SELECT p.prd_id, p.prd_nome, f.frn_nome AS fornecedor
    FROM produtos p
    INNER JOIN produtos_has_fornecedores pf ON p.prd_id = pf.pf_prod_id
    INNER JOIN fornecedores f ON pf.pf_forn_id = f.frn_id;

![Crie uma view que mostra todos os produtos e seus respectivos fornecedores](https://github.com/bancos-de-dados/Base-de-Dados-Empresa-VIEW-/assets/127689567/90d24cab-5c36-409a-8d24-49fe447b0e62)


## 3 Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas;


    -- Esta view mostra a lista de produtos com seus IDs, nomes, marcas e fornecedores correspondentes.
    CREATE VIEW produtos_com_marcas_e_fornecedores AS
    SELECT p.prd_id, p.prd_nome, m.mrc_nome AS marca, f.frn_nome AS fornecedor
    FROM produtos p
    INNER JOIN marcas m ON p.prd_marcas_id = m.mrd_id
    INNER JOIN produtos_has_fornecedores pf ON p.prd_id = pf.pf_prod_id
    INNER JOIN fornecedores f ON pf.pf_forn_id = f.frn_id;

![Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas;](https://github.com/bancos-de-dados/Base-de-Dados-Empresa-VIEW-/assets/127689567/503d6ca8-8344-46dc-ab69-c0d64400084f)


## 4 Crie uma view que mostra todos os produtos com estoque abaixo do mínimo;

    CREATE OR REPLACE VIEW produtos_com_estoque_baixo AS
    SELECT * FROM produtos WHERE prd_qtd_estoque < prd_estoque_min;

![image](https://github.com/bancos-de-dados/Base-de-Dados-Empresa-VIEW-/assets/127689567/3fdd4c04-f2c8-41c6-ba26-590ee5f37c63)



## 5 Adicione o campo data de validade. Insira novos produtos com essa informação;

    -- Inserindo produtos com data de validade vencida (subtraindo 90 dias da data atual)
    INSERT INTO `produtos` (`prd_nome`, `prd_qtd_estoque`, `prd_estoque_min`, `prd_data_fabricacao`, `prd_perecivel`, `prd_valor`, `prd_marcas_id`, `prd_data_validade`) VALUES
    ('Leite Vencido', 50, 20, '2023-07-15', 'Sim', 4.99, 1, DATE_SUB(CURDATE(), INTERVAL 90 DAY)),
    ('Arroz Vencido', 30, 50, '2023-06-20', 'Não', 3.50, 2, DATE_SUB(CURDATE(), INTERVAL 105 DAY)),
    ('Feijão Vencido', 20, 30, '2023-05-12', 'Não', 4.25, 2, DATE_SUB(CURDATE(), INTERVAL 120 DAY));

![Base de Dados Empresa (VIEW)](https://github.com/bancos-de-dados/Base-de-Dados-Empresa-VIEW-/assets/127689567/eb3c9995-8931-4ad6-af9f-47aca0a46160)

## 6 Crie uma view que mostra todos os produtos e suas respectivas marcas;

    CREATE VIEW produtos_com_validade_vencida AS
    SELECT p.prd_id, p.prd_nome, p.prd_data_validade, m.mrc_nome AS marca
    FROM produtos p
    INNER JOIN marcas m ON p.prd_marcas_id = m.mrd_id
    WHERE p.prd_data_validade < CURDATE();

![image](https://github.com/bancos-de-dados/Base-de-Dados-Empresa-VIEW-/assets/127689567/b27b3711-b968-44ec-8aa5-11eee8297d2d)

## 7  Selecionar os produtos com preço acima da média.

    SELECT prd_id, prd_nome, prd_valor
    FROM produtos
    WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);

## Obrigado

## Última atualização 15/10/23
