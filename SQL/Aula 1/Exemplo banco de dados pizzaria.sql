CREATE DATABASE pizzaria; -- cadastro de base de dados

USE pizzaria; -- Especifica a base de dados que irá ultilizar

-- Existem boas práticas de código SQL na modelagem de dados.
-- Utilize o padrão uppercase, todo código SQL deve ser escrito em Uppercase, somente declarações e nomes podem seguir seus padrões, ex: camelCase, lowerCase, etc...

-- Fluxo sugerido do sistema

--    Usuário se cadastra e faz login.
--    Usuário escolhe pizzas e adiciona ao carrinho.
--    Usuário pode aplicar um código promocional.
--    Usuário finaliza o pedido, seleciona forma de pagamento.
--    Pedido é salvo, com itens e valores.
--    Funcionário recebe o pedido para preparo/entrega.
--    Transação de pagamento é registrada.
--    Histórico de pedidos fica disponível para consulta.


-- Usuários/Clientes
CREATE TABLE usuario (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  senha VARCHAR(100),
  telefone VARCHAR(20)
);

-- Funcionários
CREATE TABLE funcionario (
  id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  cargo VARCHAR(50)
);

-- Pizzas
CREATE TABLE pizza (
  id_pizza INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  descricao TEXT,
  preco DECIMAL(10,2)
);

-- Pedidos
CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT,
  data_pedido DATETIME,
  status VARCHAR(20),
  valor_total DECIMAL(10,2),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Itens do Pedido
CREATE TABLE item_pedido (
  id_item INT PRIMARY KEY AUTO_INCREMENT,
  id_pedido INT,
  id_pizza INT,
  quantidade INT,
  preco_unitario DECIMAL(10,2),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_pizza) REFERENCES pizza(id_pizza)
);

-- Códigos Promocionais
CREATE TABLE codigo_promocional (
  id_codigo INT PRIMARY KEY AUTO_INCREMENT,
  codigo VARCHAR(20) UNIQUE,
  desconto_percentual DECIMAL(5,2),
  validade DATE
);

-- Aplicação de Código Promocional no Pedido
ALTER TABLE pedido ADD COLUMN id_codigo INT NULL;
ALTER TABLE pedido ADD FOREIGN KEY (id_codigo) REFERENCES codigo_promocional(id_codigo);

-- Formas de Pagamento
CREATE TABLE forma_pagamento (
  id_forma INT PRIMARY KEY AUTO_INCREMENT,
  descricao VARCHAR(50)
);

-- Transações
CREATE TABLE transacao (
  id_transacao INT PRIMARY KEY AUTO_INCREMENT,
  id_pedido INT,
  id_forma INT,
  valor DECIMAL(10,2),
  data_transacao DATETIME,
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_forma) REFERENCES forma_pagamento(id_forma)
);
