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
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `dataNasc` DATE NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`telefone_cli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefone_cli` (
  `tel1` VARCHAR(45) NOT NULL,
  `tel2` VARCHAR(45) NULL,
  `cliente_cpf` VARCHAR(14) NOT NULL,
  INDEX `fk_table1_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  PRIMARY KEY (`cliente_cpf`),
  CONSTRAINT `fk_table1_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `mydb`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seguro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seguro` (
  `idseguro` INT NOT NULL,
  `apolice` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cliente_cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idseguro`),
  INDEX `fk_seguro_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_seguro_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `mydb`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`faturamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`faturamento` (
  `idfaturamento` INT NOT NULL,
  `procedimento` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  `valor_recebido` DECIMAL(8,2) NOT NULL,
  `cliente_cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idfaturamento`),
  INDEX `fk_faturamento_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_faturamento_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `mydb`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`forma_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`forma_pagamento` (
  `idforma_pagamento` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `parcelas` INT NULL,
  `valor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idforma_pagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lucro` (
  `faturamento_idfaturamento` INT NOT NULL,
  `forma_pagamento_idforma_pagamento` INT NOT NULL,
  INDEX `fk_table1_faturamento1_idx` (`faturamento_idfaturamento` ASC) VISIBLE,
  INDEX `fk_table1_forma_pagamento1_idx` (`forma_pagamento_idforma_pagamento` ASC) VISIBLE,
  PRIMARY KEY (`faturamento_idfaturamento`, `forma_pagamento_idforma_pagamento`),
  CONSTRAINT `fk_table1_faturamento1`
    FOREIGN KEY (`faturamento_idfaturamento`)
    REFERENCES `mydb`.`faturamento` (`idfaturamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_forma_pagamento1`
    FOREIGN KEY (`forma_pagamento_idforma_pagamento`)
    REFERENCES `mydb`.`forma_pagamento` (`idforma_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`agendamento` (
  `idagendamento` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `data` DATETIME NOT NULL,
  `responsavel` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `cliente_cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idagendamento`),
  INDEX `fk_agendamento_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_agendamento_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `mydb`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`procedimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`procedimento` (
  `idprocedimento` INT NOT NULL,
  `descricao` VARCHAR(90) NOT NULL,
  `custo` DECIMAL(8,2) NOT NULL,
  `agendamento_idagendamento` INT NOT NULL,
  PRIMARY KEY (`idprocedimento`),
  INDEX `fk_procedimento_agendamento1_idx` (`agendamento_idagendamento` ASC) VISIBLE,
  CONSTRAINT `fk_procedimento_agendamento1`
    FOREIGN KEY (`agendamento_idagendamento`)
    REFERENCES `mydb`.`agendamento` (`idagendamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`colaborador` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(90) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `registo_prof` VARCHAR(45) NOT NULL,
  `escolaridade` VARCHAR(45) NOT NULL,
  `salario` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`registro` (
  `idregistro` INT NOT NULL,
  `recomendacao` VARCHAR(45) NOT NULL,
  `detalhe` VARCHAR(45) NOT NULL,
  `prescricao` VARCHAR(200) NOT NULL,
  `cliente_cpf` VARCHAR(14) NOT NULL,
  `colaborador_cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idregistro`),
  INDEX `fk_registro_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  INDEX `fk_registro_colaborador1_idx` (`colaborador_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_registro_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `mydb`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registro_colaborador1`
    FOREIGN KEY (`colaborador_cpf`)
    REFERENCES `mydb`.`colaborador` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `mydb`.`tel_colab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tel_colab` (
  `tel1` VARCHAR(45) NOT NULL,
  `tel2` VARCHAR(45) NULL,
  `colaborador_cpf` VARCHAR(14) NOT NULL,
  INDEX `fk_tel_colab_colaborador1_idx` (`colaborador_cpf` ASC) VISIBLE,
  PRIMARY KEY (`colaborador_cpf`),
  CONSTRAINT `fk_tel_colab_colaborador1`
    FOREIGN KEY (`colaborador_cpf`)
    REFERENCES `mydb`.`colaborador` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`consulta` (
  `agendamento_idagendamento` INT NOT NULL,
  `colaborador_cpf` VARCHAR(14) NOT NULL,
  INDEX `fk_table2_agendamento1_idx` (`agendamento_idagendamento` ASC) VISIBLE,
  INDEX `fk_table2_colaborador1_idx` (`colaborador_cpf` ASC) VISIBLE,
  PRIMARY KEY (`agendamento_idagendamento`, `colaborador_cpf`),
  CONSTRAINT `fk_table2_agendamento1`
    FOREIGN KEY (`agendamento_idagendamento`)
    REFERENCES `mydb`.`agendamento` (`idagendamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table2_colaborador1`
    FOREIGN KEY (`colaborador_cpf`)
    REFERENCES `mydb`.`colaborador` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`despesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`despesa` (
  `iddespesa` INT NOT NULL,
  `colaborador_cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`iddespesa`),
  INDEX `fk_despesa_colaborador1_idx` (`colaborador_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_despesa_colaborador1`
    FOREIGN KEY (`colaborador_cpf`)
    REFERENCES `mydb`.`colaborador` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`folha_pag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`folha_pag` (
  `idfolha_pag` INT NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `data` DATETIME NOT NULL,
  `despesa_iddespesa` INT NOT NULL,
  PRIMARY KEY (`idfolha_pag`),
  INDEX `fk_folha_pag_despesa1_idx` (`despesa_iddespesa` ASC) VISIBLE,
  CONSTRAINT `fk_folha_pag_despesa1`
    FOREIGN KEY (`despesa_iddespesa`)
    REFERENCES `mydb`.`despesa` (`iddespesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`custos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`custos` (
  `idcustos` INT NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `data` DATETIME NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `despesa_iddespesa` INT NOT NULL,
  PRIMARY KEY (`idcustos`),
  INDEX `fk_custos_despesa1_idx` (`despesa_iddespesa` ASC) VISIBLE,
  CONSTRAINT `fk_custos_despesa1`
    FOREIGN KEY (`despesa_iddespesa`)
    REFERENCES `mydb`.`despesa` (`iddespesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compra` (
  `idcompra` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `despesa_iddespesa` INT NOT NULL,
  PRIMARY KEY (`idcompra`),
  INDEX `fk_compra_despesa1_idx` (`despesa_iddespesa` ASC) VISIBLE,
  CONSTRAINT `fk_compra_despesa1`
    FOREIGN KEY (`despesa_iddespesa`)
    REFERENCES `mydb`.`despesa` (`iddespesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`laboratorio` (
  `idlaboratorio` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `despesa_iddespesa` INT NOT NULL,
  PRIMARY KEY (`idlaboratorio`),
  INDEX `fk_laboratorio_despesa1_idx` (`despesa_iddespesa` ASC) VISIBLE,
  CONSTRAINT `fk_laboratorio_despesa1`
    FOREIGN KEY (`despesa_iddespesa`)
    REFERENCES `mydb`.`despesa` (`iddespesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`endereco_lab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco_lab` (
  `laboratorio_idlaboratorio` INT NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` INT NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  INDEX `fk_endereco_lab_laboratorio1_idx` (`laboratorio_idlaboratorio` ASC) VISIBLE,
  PRIMARY KEY (`laboratorio_idlaboratorio`),
  CONSTRAINT `fk_endereco_lab_laboratorio1`
    FOREIGN KEY (`laboratorio_idlaboratorio`)
    REFERENCES `mydb`.`laboratorio` (`idlaboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefone` (
  `tel1` VARCHAR(45) NOT NULL,
  `tel2` VARCHAR(45) NOT NULL,
  `laboratorio_idlaboratorio` INT NOT NULL,
  INDEX `fk_telefone_laboratorio1_idx` (`laboratorio_idlaboratorio` ASC) VISIBLE,
  PRIMARY KEY (`laboratorio_idlaboratorio`),
  CONSTRAINT `fk_telefone_laboratorio1`
    FOREIGN KEY (`laboratorio_idlaboratorio`)
    REFERENCES `mydb`.`laboratorio` (`idlaboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servico` (
  `idservico` INT NOT NULL auto_increment,
  `data` DATETIME NOT NULL,
  `descricao` VARCHAR(90) NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `laboratorio_idlaboratorio` INT NOT NULL,
  PRIMARY KEY (`idservico`),
  INDEX `fk_servico_laboratorio1_idx` (`laboratorio_idlaboratorio` ASC) VISIBLE,
  CONSTRAINT `fk_servico_laboratorio1`
    FOREIGN KEY (`laboratorio_idlaboratorio`)
    REFERENCES `mydb`.`laboratorio` (`idlaboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE endereco_colaborador (

    cpf VARCHAR(14) NOT NULL PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    FOREIGN KEY (cpf) REFERENCES colaborador(cpf)
);

CREATE TABLE endereco_cliente (
    
    cpf VARCHAR(14) NOT NULL primary key,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    FOREIGN KEY (cpf) REFERENCES cliente(cpf) 
);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
