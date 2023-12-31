-- MySQL Script generated by MySQL Workbench
-- Sun Oct 15 20:42:32 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`marcas` (
  `mrd_id` INT(11) NOT NULL AUTO_INCREMENT,
  `mrc_nome` VARCHAR(50) NULL,
  `mrc_nacionalidade` VARCHAR(50) NULL,
  PRIMARY KEY (`mrd_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produtos` (
  `prd_id` INT(11) NOT NULL AUTO_INCREMENT,
  `prd_nome` VARCHAR(50) NOT NULL,
  `prd_qtd_estoque` INT(11) NOT NULL,
  `prd_estoque_min` INT(11) NOT NULL,
  `prd_data_fabricacao` TIMESTAMP(6) NOT NULL,
  `prd_perecivel` TINYTEXT NULL,
  `prd_valor` DECIMAL(10,2) NULL,
  `prd_marcas_id` INT(11) NOT NULL,
  PRIMARY KEY (`prd_id`),
  INDEX `fk_produtos_marcas_idx` (`prd_marcas_id` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_marcas`
    FOREIGN KEY (`prd_marcas_id`)
    REFERENCES `mydb`.`marcas` (`mrd_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fornecedores` (
  `frn_id` INT(11) NOT NULL AUTO_INCREMENT,
  `frn_nome` VARCHAR(50) NULL,
  `frn_email` VARCHAR(50) NULL,
  PRIMARY KEY (`frn_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produtos_has_fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produtos_has_fornecedores` (
  `pf_prod_id` INT(11) NOT NULL,
  `pf_forn_id` INT(11) NOT NULL,
  PRIMARY KEY (`pf_prod_id`, `pf_forn_id`),
  INDEX `fk_produtos_has_fornecedores_fornecedores1_idx` (`pf_forn_id` ASC) VISIBLE,
  INDEX `fk_produtos_has_fornecedores_produtos1_idx` (`pf_prod_id` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_has_fornecedores_produtos1`
    FOREIGN KEY (`pf_prod_id`)
    REFERENCES `mydb`.`produtos` (`prd_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_has_fornecedores_fornecedores1`
    FOREIGN KEY (`pf_forn_id`)
    REFERENCES `mydb`.`fornecedores` (`frn_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Inserindo dados na tabela `produtos` (20 produtos, 8 perecíveis)
INSERT INTO `produtos` (`prd_nome`, `prd_qtd_estoque`, `prd_estoque_min`, `prd_data_fabricacao`, `prd_perecivel`, `prd_valor`, `prd_marcas_id`) VALUES
('Leite Condensado', 200, 20, '2023-10-15', 'Sim', 4.99, 1), -- Perecível
('Arroz', 500, 50, '2023-09-20', 'Não', 3.50, 2),
('Feijão', 300, 30, '2023-08-12', 'Não', 4.25, 2),
('Óleo de Soja', 150, 15, '2023-07-05', 'Sim', 6.99, 3), -- Perecível
('Bolachas', 400, 40, '2023-06-18', 'Não', 2.75, 1),
('Molho de Tomate', 250, 25, '2023-05-10', 'Sim', 3.99, 2), -- Perecível
('Café', 180, 18, '2023-04-15', 'Não', 7.50, 3),
('Açúcar', 350, 35, '2023-03-20', 'Não', 2.25, 1),
('Chocolate', 280, 28, '2023-02-10', 'Sim', 5.49, 1), -- Perecível
('Mel', 100, 10, '2023-01-05', 'Sim', 9.99, 3), -- Perecível
('Frango', 150, 15, '2023-09-25', 'Sim', 12.99, 4), -- Perecível
('Maçãs', 120, 12, '2023-10-01', 'Sim', 1.99, 5), -- Perecível
('Pão', 200, 20, '2023-09-30', 'Sim', 2.50, 6), -- Perecível
('Presunto', 100, 10, '2023-09-29', 'Sim', 7.99, 7), -- Perecível
('Leite', 300, 30, '2023-10-05', 'Sim', 3.49, 8), -- Perecível
('Iogurte', 250, 25, '2023-10-07', 'Sim', 2.99, 9), -- Perecível
('Cenouras', 80, 8, '2023-10-02', 'Sim', 1.25, 10), -- Perecível
('Ovos', 200, 20, '2023-09-27', 'Sim', 4.99, 11), -- Perecível
('Batatas', 150, 15, '2023-10-10', 'Sim', 0.99, 12), -- Perecível
('Alface', 90, 9, '2023-10-12', 'Sim', 1.75, 13); -- Perecível

-- Inserindo dados na tabela `fornecedores` (8 fornecedores reais)
INSERT INTO `fornecedores` (`frn_nome`, `frn_email`) VALUES
('Nestlé', 'contato@nestle.com'),
('Tio João', 'contato@tiojoao.com.br'),
('Camil', 'contato@camil.com.br'),
('Liza', 'contato@liza.com.br'),
('Mondelez', 'contato@mondelez.com'),
('Heinz', 'contato@heinz.com'),
('Danone', 'contato@danone.com'),
('Wickbold', 'contato@wickbold.com');

CREATE TABLE IF NOT EXISTS `mydb`.`marcas` (
  `mrd_id` INT(11) NOT NULL AUTO_INCREMENT,
  `mrc_nome` VARCHAR(50) NULL,
  `mrc_nacionalidade` VARCHAR(50) NULL,
  PRIMARY KEY (`mrd_id`)
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`fornecedores` (
  `frn_id` INT(11) NOT NULL AUTO_INCREMENT,
  `frn_nome` VARCHAR(50) NULL,
  `frn_email` VARCHAR(50) NULL,
  PRIMARY KEY (`frn_id`)
) ENGINE = InnoDB;

INSERT INTO `marcas` (`mrc_nome`, `mrc_nacionalidade`) VALUES
('Nestlé', 'Suíça'),
('Tio João', 'Brasil'),
('Camil', 'Brasil'),
('Liza', 'Brasil'),
('Mondelez', 'Estados Unidos'),
('Heinz', 'Estados Unidos'),
('Danone', 'França'),
('Wickbold', 'Brasil');

-- Inserindo dados na tabela fornecedores como nome e email.
INSERT INTO `fornecedores` (`frn_nome`, `frn_email`) VALUES
('Distribuidora de Laticínios', 'distribuidora@laticinios.com'),
('Comércio de Alimentos', 'contato@alimentos.com'),
('Fornecedor de Produtos Naturais', 'fornecedor@produtosnaturais.com'),
('Frigorífico Frango Dourado', 'contato@frangodourado.com'),
('Frutas Frescas Ltda.', 'contato@frutasfrescas.com'),
('Panificadora Pão Quente', 'contato@paoquente.com'),
('Frigorífico Delícia', 'contato@frigodelicia.com'),
('Laticínios Leitinho', 'contato@leitinho.com');


INSERT INTO `produtos_has_fornecedores` (`pf_prod_id`, `pf_forn_id`) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 3),
(5, 1),
(6, 2),
(7, 3),
(8, 1),
(9, 1),
(10, 3),
(11, 4),
(12, 5),
(13, 6),
(14, 7),
(15, 8),
(16, 8),
(17, 6),
(18, 7),
(19, 6),
(20, 5);

