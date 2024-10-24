-- Obs.: As PKs e FKs já contém índices próprios

create database wk;

use wk;

CREATE TABLE clientes (
    cd_cliente INT PRIMARY KEY,
    ds_nome VARCHAR(100) NOT NULL,
    ds_cidade VARCHAR(100) NOT NULL,
    cd_uf CHAR(2) NOT NULL
);

CREATE TABLE produtos (
    cd_produto INT PRIMARY KEY,
    ds_descricao VARCHAR(100) NOT NULL,
    vl_preco_venda DECIMAL(10,2) NOT NULL
);

CREATE TABLE pedidos (
    nr_pedido INT AUTO_INCREMENT PRIMARY KEY,
    dt_emissao DATETIME NOT NULL,
    cd_cliente INT NOT NULL,
    vl_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cd_cliente) REFERENCES clientes(cd_cliente)
);

CREATE TABLE pedidos_produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nr_pedido INT NOT NULL,
    cd_produto INT NOT NULL,
    nr_quantidade INT NOT NULL,
    vl_unitario DECIMAL(10,2) NOT NULL,
    vl_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (nr_pedido) REFERENCES pedidos(nr_pedido),
    FOREIGN KEY (cd_produto) REFERENCES produtos(cd_produto)
);
