create database lancamentos_db;
use lancamentos_db;

CREATE TABLE categorias(   id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,  descricao VARCHAR(255) NOT NULL) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE estados( sigla VARCHAR(2) NOT NULL PRIMARY KEY , nome VARCHAR(100) NOT NULL) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE cidades( id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,nome VARCHAR(255) NOT NULL, estado_sigla VARCHAR(2) NOT NULL, 
CONSTRAINT fk_cidade_estados1 FOREIGN KEY (estado_sigla) REFERENCES estados (sigla) ON DELETE NO ACTION ON UPDATE NO ACTION) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE pessoas (id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,  nome VARCHAR(255) NOT NULL, ativo TINYINT(4) NOT NULL) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE contatos( id BIGINT(20) NOT NULL AUTO_INCREMENT primary key, nome VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, telefone VARCHAR(14) NOT NULL,
  pessoa_id BIGINT(20) NOT NULL, CONSTRAINT fk_contatos_pessoa FOREIGN KEY (pessoa_id) REFERENCES pessoas (id) ON DELETE CASCADE ON UPDATE NO ACTION)ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE enderecos(  pessoa_id BIGINT(20) NOT NULL, logradouro VARCHAR(255) NOT NULL, numero VARCHAR(45) NOT NULL, complemento VARCHAR(255) NOT NULL,
  bairro VARCHAR(45) NOT NULL, cep VARCHAR(10) NOT NULL, cidade_id BIGINT(20) NOT NULL, CONSTRAINT fk_endereco_cidade1  FOREIGN KEY (cidade_id)  REFERENCES cidades (id) 
    ON DELETE NO ACTION ON UPDATE NO ACTION, CONSTRAINT fk_endereco_pessoas1 FOREIGN KEY (pessoa_id)   REFERENCES pessoas (id) ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE lancamentos( id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY, descricao VARCHAR(255) NOT NULL,dt_vencimento DATE NOT NULL,dt_pagamento DATE NULL DEFAULT NULL,
valor DECIMAL(10,2) NOT NULL,observacao TEXT NULL DEFAULT NULL, tipo ENUM('RECEITA', 'DESPESA') NOT NULL,pessoa_id BIGINT(20) NOT NULL,categoria_id BIGINT(20) NOT NULL,
CONSTRAINT fk_lancamento_pessoa1 FOREIGN KEY (pessoa_id) REFERENCES pessoas (id) ON DELETE CASCADE ON UPDATE NO ACTION, CONSTRAINT fk_lancamentos_categorias1
    FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE NO ACTION ON UPDATE NO ACTION) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

alter table contatos drop foreign key fk_contatos_pessoa;

alter table enderecos drop foreign key fk_endereco_pessoas1;

alter table lancamentos drop foreign key fk_lancamento_pessoa1;

alter table pessoas add column pessoa_cpf varchar(20) not null;

update pessoas set pessoa_cpf = '89674582310' where id = 1;
update pessoas set pessoa_cpf = '89856320314' where id = 2;
update pessoas set pessoa_cpf = '96385274103' where id = 3;
update pessoas set pessoa_cpf = '89536920339' where id = 4;
update pessoas set pessoa_cpf = '04503620532' where id = 5;

alter table pessoas modify column id bigint unique ;
alter table pessoas drop primary key;
alter table pessoas add primary key (pessoa_cpf);

alter table contatos add column pessoa_cpf varchar (20);
alter table contatos modify column id bigint unique auto_increment;
alter table contatos drop primary key;
alter table contatos add primary key(id);

update contatos c inner join pessoas p on c.pessoa_id = p.id set c.pessoa_cpf = p.pessoa_cpf;

alter table contatos add constraint fk_pessoa_cpf foreign key (pessoa_cpf) references pessoas (pessoa_cpf);

alter table lancamentos add column pessoa_cpf varchar (20);

update lancamentos l inner join pessoas p on l.pessoa_id = p.id set l.pessoa_cpf = p.pessoa_cpf;


alter table lancamentos add constraint pessoa1_cpf_fk foreign key (pessoa_cpf) references pessoas (pessoa_cpf);

alter table enderecos add column pessoa1_cpf varchar (20) not null;

update enderecos e inner join pessoas p on e.pessoa_id = p.id set e.pessoa1_cpf = p.pessoa_cpf;

alter table enderecos add constraint fk_pessoa1_cpf foreign key (pessoa1_cpf) references pessoas (pessoa_cpf);
