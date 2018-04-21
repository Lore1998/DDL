create database lancamentos_db;
use lancamentos_db;
create table pessoas ( id bigint auto_increment primary key,nome varchar (50),ativo tinyint) engine=InnoDB default charset = utf8;             

create table contatos ( id bigint auto_increment primary key , nome varchar (50),email varchar (255),telefone varchar (14)) engine=InnoDB default charset = utf8;  ;
                        
create table estados (sigla varchar (2), nome varchar (100)) engine=InnoDB default charset = utf8; 
                       
create table cidades (id bigint auto_increment primary key,  nome varchar (255) ) engine=InnoDB default charset = utf8;
                       
create table enderecos ( longradouro varchar (10), numero varchar (10),   bairro varchar (100),      cep varchar (20))engine=InnoDB default charset = utf8;
                        
create table categorias ( id bigint  auto_increment primary key, descricao varchar(100)) engine=InnoDB default charset = utf8; 
                           
create table lancamentos(id bigint  auto_increment  primary key,        descricao varchar (255),  dt_vencimento date, dt_pagamento date ,
                      	       valor decimal(10,2) unsigned ,             observacao text ,  tipo enum ('RECEITA', 'DESPESA')) engine=InnoDB default charset = utf8;

alter table pessoas modify nome varchar(50) not null;
alter table pessoas modify ativo tinyint not null;


alter table contatos modify nome varchar (50) not null;
alter table contatos modify email varchar (255) not null;
alter table contatos modify telefone varchar (14) not null;
alter table contatos add column pessoa_id bigint;
alter table contatos add constraint pessoa_id_fk foreign key(pessoa_id) references pessoas(id) on delete cascade on update no action;


alter table enderecos modify longradouro varchar (10) not null;
alter table enderecos modify numero varchar (10) not null;
alter table enderecos modify bairro varchar (10) not null;
alter table enderecos modify cep varchar (20) not null;
alter table enderecos add column pessoa_id bigint;
alter table enderecos add column cidade_id bigint;
alter table enderecos add constraint pessoas_id_fk foreign key(pessoa_id) references pessoas(id) on delete cascade on update no action;
alter table enderecos add constraint cidade_id_fk foreign key(cidade_id) references cidades(id) on delete cascade on update no action;


alter table estados modify sigla varchar (2) not null;
alter table estados modify nome varchar (100) not null;

alter table cidades modify nome varchar (255) not null;
alter table cidades add column estado_sigla varchar (2);
alter table cidades add constraint estados_sigla_fk foreign key(estado_sigla) references estados(sigla) on delete cascade on update no action;

alter table categorias modify descricao varchar (100) not null;

alter table lancamentos modify descricao varchar (255) not null;
alter table lancamentos modify  dt_vencimento date not null;
alter table lancamentos modify valor decimal (10,2) not null;
alter table lancamentos add column pessoa_id bigint;
alter table lancamentos add column categoria_id bigint;
 alter table lancamentos add constraint pesoa_id_fk foreign key(pessoa_id) references pesoa(id) on delete cascade on update no action;
alter table lancamentos add constraint categorias_id_fk foreign key (categoria_id) references categorias (id) on  delete cascade on update no action;
