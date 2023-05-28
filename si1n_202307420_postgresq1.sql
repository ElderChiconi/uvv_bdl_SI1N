-- PSET1 - Turma SI1N 
-- Aluno - Elder Alexandre de Oliveira Chiconi
-- email - elderchiconi.ifes@gmail.com
-- Matricula - 202307420
-- SCRIPT Banco de dados - UVV
-- Usuário - Elder
-- Professor - Abrantes
-- Data 28/05/2023


-- O script se inicia

--------------------------------------------------------------------------------
-- apagando banco de dados existente com nome UVV

DROP DATABASE IF EXISTS uvv;

--------------------------------------------------------------------------------
-- apagando usuário existente com o nome elder

DROP USER IF EXISTS elder;

--------------------------------------------------------------------------------
-- agora ele CRIA um usuário com nome elder e suas permissões de:
-- criar um banco de dados
-- criar outras roles
-- e ter uma senha criptografada

CREATE USER elder WITH 
CREATEDB 
CREATEROLE
INHERIT
ENCRYPTED PASSWORD '123';

--------------------------------------------------------------------------------
-- agora CRIA um novo Banco de dados com o nome UVV com seus parametros:
-- Usuario elder
-- template  facilita as operações cotidianas de administração de um banco de dados
-- encoding UFT8  suporta todo o alfabeto e acentos além de uma gama gigantesca de caracteres especiais
-- lc_collate e lc_ctype, são determinadas quando o utilitário initdb é executado, não podendo ser mudadas sem que o initdb seja executado novamente
-- allow_connections true verdadeira a conexão 

CREATE DATABASE uvv WITH
OWNER = 'elder'
template = 'template0'
encoding = 'UTF8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true;

--------------------------------------------------------------------------------
-- conecta ao novo banco de dados uvv

\c uvv;

--------------------------------------------------------------------------------
-- define o usuário elder

SET ROLE elder;

--------------------------------------------------------------------------------
-- Cria uma autorização para usuario elder no banco de dados

CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION elder;

--------------------------------------------------------------------------------
-- altera para o usuario elder

ALTER USER elder;

--------------------------------------------------------------------------------
-- define o esquema lojas e não public

SET SEARCH_PATH TO lojas, "&user", public;

--------------------------------------------------------------------------------
-- agora vamos iniciar a criação das tabelas do banco de dados:
----------------------------------------------------------------------------------------------------------------------
-- criar a tabela Produtos com suas colunas(produto_id, nome, preco_unitario,detalhes,
-- imagem,imagem_mime_type,imagem_charset e imagem_ultima_atualizacao) com suas caracteristicas de cada coluna

CREATE TABLE produtos (
                produto_id                          NUMERIC(38)           NOT NULL,
                nome                                VARCHAR(255)          NOT NULL,
                preco_unitario                      NUMERIC(10,2)         CHECK (preco_unitario > 0),
                detalhes                            BYTEA,
                imagem                              BYTEA,
                imagem_mime_type                    VARCHAR(512),
                imagem_arquivo                      VARCHAR(512),
                imagem_charset                      VARCHAR(512),
                imagem_ultima_atualizacao           DATE                  NOT NULL,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);
COMMENT ON COLUMN produtos.produto_id IS                'chave primaria da coluna produtos';
COMMENT ON COLUMN produtos.nome IS                      'nome coluna produtos';
COMMENT ON COLUMN produtos.preco_unitario IS            'preco unitario coluna produtos';
COMMENT ON COLUMN produtos.detalhes IS                  'detalhes coluna produtos';
COMMENT ON COLUMN produtos.imagem IS                    'imagem coluna produtos';
COMMENT ON COLUMN produtos.imagem_mime_type IS          'imagem coluna produtos';
COMMENT ON COLUMN produtos.imagem_arquivo IS            'imagem coluna produtos';
COMMENT ON COLUMN produtos.imagem_charset IS            'imagem charset coluna produtos';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'data ultima atualizacao coluna produtos';




--------------------------------------------------------------------------------------------------------------
-- cria a tabela lojas com suas colunas(loja_id,nome,endereco_web,endereco_fisico,latitude,longitude,logo,
-- logo_mime_type,logo_arquivo,logo_charset,logo_ultima_atualizacao) e suas caracteristica de cada coluna

CREATE TABLE lojas (
                loja_id                             NUMERIC(38)           NOT NULL,
                nome                                VARCHAR(255)          NOT NULL,
                endereco_web                        VARCHAR(100),
                endereco_fisico                     VARCHAR(512),
                latitude                            NUMERIC,
                longitude                           NUMERIC,
                logo                                BYTEA,
                logo_mime_type                      VARCHAR(512),
                logo_arquivo                        VARCHAR(512),
                logo_charset                        VARCHAR(512),
                logo_ultima_atualizacao             DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);
COMMENT ON COLUMN lojas.loja_id IS                      'chave primaria da coluna Lojas';
COMMENT ON COLUMN lojas.nome IS                         'nome da coluna lojas';
COMMENT ON COLUMN lojas.endereco_web IS                 'endereco web da coluna lojas';
COMMENT ON COLUMN lojas.endereco_fisico IS              'endereco fisico da coluna lojas';
COMMENT ON COLUMN lojas.latitude IS                     'latitude da coluna lojas';
COMMENT ON COLUMN lojas.longitude IS                    'longitude da coluna lojas';
COMMENT ON COLUMN lojas.logo IS                         'logo da coluna lojas';
COMMENT ON COLUMN lojas.logo_mime_type IS               'logo mime type da coluna lojas';
COMMENT ON COLUMN lojas.logo_arquivo IS                 'logo arquivo da coluna lojas';
COMMENT ON COLUMN lojas.logo_charset IS                 'logo charset da coluna lojas';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS      'data ultima atualizacao da coluna lojas';



--------------------------------------------------------------------------------------------------------------
-- cria a tabela estoques com suas colunas(estoque_id,loja_id,produto_id,quantidade) e suas caracteristicas de cada coluna.

CREATE TABLE estoques (
                estoque_id                          NUMERIC(38)           NOT NULL,
                loja_id                             NUMERIC(38)           NOT NULL,
                produto_id                          NUMERIC(38)           NOT NULL,
                quantidade                          NUMERIC(38)           NOT NULL CHECK (quantidade > 0),
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON COLUMN estoques.estoque_id IS                'chave primaria coluna estoques';
COMMENT ON COLUMN estoques.loja_id IS                   'chave estrangeira loja_id referencia loja_id da coluna lojas';
COMMENT ON COLUMN estoques.produto_id IS                'chave estrangeira produto_id referencia a produto_id da coluna produtos';
COMMENT ON COLUMN estoques.quantidade IS                'quantidade coluna estoques';



---------------------------------------------------------------------------------------------------------------
--cria a tabela clientes com suas colunas(cliente_id,email,nome,telefone1,telefone2,telefone3)



CREATE TABLE clientes (
                cliente_id 							NUMERIC(38)           NOT NULL,
                email                               VARCHAR(255)          NOT NULL,
                nome                                VARCHAR(255)          NOT NULL,
                telefone1                           VARCHAR(20),
                telefone2                           VARCHAR(20),
                telefone3                           VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
COMMENT ON COLUMN clientes.cliente_id IS                'chave primaria cliente_id da coluna clientes';
COMMENT ON COLUMN clientes.email IS                     'email da coluna clientes';
COMMENT ON COLUMN clientes.nome IS                      'nome da coluna clientes';
COMMENT ON COLUMN clientes.telefone1 IS                 'telefone1 da coluna clientes';
COMMENT ON COLUMN clientes.telefone2 IS                 'telefone2 da coluna clientes';
COMMENT ON COLUMN clientes.telefone3 IS                 'telefone3 da coluna clientes';


-------------------------------------------------------------------------------------------------------------
--cria uma tabela com suas colunas(envio_id,loja_id,cliente_id,endereco_entrega,status(valores definidos))

CREATE TABLE envios (
                envio_id                            NUMERIC(38)           NOT NULL,
                loja_id                             NUMERIC(38)           NOT NULL,
                cliente_id                          NUMERIC(38)           NOT NULL,
                endereco_entrega                    VARCHAR(512)          NOT NULL,
                status                              VARCHAR(15)           NOT NULL CHECK (status IN('CRIADO','ENVIADO','TRANSITO','ENTREGUE')),
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
COMMENT ON COLUMN envios.envio_id IS                    'chave primaria coluna envios';
COMMENT ON COLUMN envios.loja_id IS                     'chave estrangeira loja_id referencia loja_id da coluna lojas';
COMMENT ON COLUMN envios.cliente_id IS                  'chave estrangeira cliente_id referencia cliente_id da coluna clientes';
COMMENT ON COLUMN envios.endereco_entrega IS            'endereco entrega da coluna envios';
COMMENT ON COLUMN envios.status IS                      'status da coluna envios';


------------------------------------------------------------------------------------------------------------
--cria uma tabela pedidos com suas colunas(pedido_id,data_hora,cliente_id,status(valores definidos),loja_id)

CREATE TABLE pedidos (
                pedido_id                           NUMERIC(38)           NOT NULL,
                data_hora                           TIMESTAMP             NOT NULL,
                cliente_id                          NUMERIC(38)           NOT NULL,
                status                              VARCHAR(15)           NOT NULL CHECK (status IN('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO')),
                loja_id                             NUMERIC(38)           NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
COMMENT ON COLUMN pedidos.pedido_id IS                  'chave primaria pedido_id da coluna pedidos';
COMMENT ON COLUMN pedidos.data_hora IS                  'data e hora da coluna pedidos';
COMMENT ON COLUMN pedidos.cliente_id IS                 'chave estrangeira cliente_id referencia cliente_id da coluna clientes';
COMMENT ON COLUMN pedidos.status IS                     'status da coluna pedidos';
COMMENT ON COLUMN pedidos.loja_id IS                    'chave estrangeira loja_id referencia loja_id da coluna Lojas';


-------------------------------------------------------------------------------------------------------------
--cria uma tabela com suas colunas(pedido_id,produto_id,numero_da_linha,preco_unitario(definido que nao
--pode ser menor que zero),quantidade(defenido que nao pode ser menor que zero))

CREATE TABLE pedidos_itens (
                pedido_id                           NUMERIC(38)           NOT NULL,
                produto_id                          NUMERIC(38)           NOT NULL,
                numero_da_linha                     NUMERIC(38)           NOT NULL,
                preco_unitario                      NUMERIC(10,2)         NOT NULL CHECK (preco_unitario > 0),
                quantidade                          NUMERIC(38)           NOT NULL CHECK (quantidade > 0),
                envio_id                            NUMERIC(38)           NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON COLUMN pedidos_itens.pedido_id IS            'chave primaria e estrangeira pedido_id da coluna pedidos_itens referencia a coluna pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS           'chave primaira e estrangeira produto_id referencia de produto_id da coluna produtos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS      'numero da linha da coluna pedidos_itens';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS       'preco unitario da coluna pedidos_itens';
COMMENT ON COLUMN pedidos_itens.quantidade IS           'quantidade da coluna pedidos_itens';
COMMENT ON COLUMN pedidos_itens.envio_id IS             'chave estrangeira envio_id da coluna pedidos_itens referencia envio_id da coluna envios';




-------------------------------------------------------------------------------------------------------------
--altera na tabela lojas onde se torna obrigatorio o preenchimento de um dos campos endereco_web ou endereco_fisico


ALTER TABLE lojas ADD CONSTRAINT CHK_endereco CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

 



-------------------------------------------------------------------------------------------------------------
--construindo o relacionamento entre as tabelas atraves de suas chaves primarias e estrangeiras


-------------------------------------------------------------------------------------------------------------
--altera definindo na tabela estoque a chave estrangeira produto_id que se refere a tabela produtos chave primaria produto_id

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-------------------------------------------------------------------------------------------------------------
--altera definindo na tabela pedidos_itens a chave estrangeira produto_id que se refere a tabela produtos chave primaria produto_id

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--------------------------------------------------------------------------------------------------------------
-- altera definindo na tabela pedidos a chave estrangeira loja_id que se refere a tabela lojas chave primaria loja_id

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--------------------------------------------------------------------------------------------------------------
--altera definindo na tabela envios a chave estrangeira loja_id que se refere a tabela lojas chave primaria loja_id

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-------------------------------------------------------------------------------------------------------------
--altera definindo na tabela estoque a chave estrangeira loja_id se refere a tabela lojas chave primaria loja_id

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--------------------------------------------------------------------------------------------------------------
--altera definindo na tabela pedidos a chave estrangeira cliente_id se refere a tabela clientes chave primaria cliente_id

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--------------------------------------------------------------------------------------------------------------
--altera definindo na tabela envios a chave estrangeira cliente_id se refere a tabela clientes chave primaria cliente_id

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-------------------------------------------------------------------------------------------------------------
--altera definindo na tabela pedidos_itens a chave estrangeira envio_id se refere a tabela envios chave primaria envio_id

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-------------------------------------------------------------------------------------------------------------
--altera definindo na tabela pedidos_itens a chave estrangeira pedido_id se refere a tabela pedidos chave primaria pedido_id

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;





