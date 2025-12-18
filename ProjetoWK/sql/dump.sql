-- ------------------------------------------------------
-- DUMP COMPLETO – SISTEMA DE PEDIDOS (WK Technology)
-- ------------------------------------------------------

DROP DATABASE IF EXISTS sistema_pedidos;
CREATE DATABASE sistema_pedidos
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE sistema_pedidos;

-- =============================
-- TABELA CLIENTES
-- =============================
CREATE TABLE clientes (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100),
    uf CHAR(2)
) ENGINE=InnoDB;

INSERT INTO clientes (nome, cidade, uf) VALUES
('Mercadinho São José', 'Fortaleza', 'CE'),
('Padaria Doce Pão', 'Fortaleza', 'CE'),
('Super Rio', 'Aquiraz', 'CE'),
('Farmácia Popular', 'Caucaia', 'CE'),
('Loja do João', 'Maracanaú', 'CE'),
('Rações Vida Animal', 'Pacajus', 'CE'),
('Super Mix', 'Eusébio', 'CE'),
('Mercadinho Central', 'Fortaleza', 'CE'),
('Restaurante Saboroso', 'Horizonte', 'CE'),
('Casa da Construção', 'Caucaia', 'CE'),
('Papelaria Fofa', 'Fortaleza', 'CE'),
('Mundo Kids', 'Fortaleza', 'CE'),
('Loja da Economia', 'Aquiraz', 'CE'),
('Beauty Center', 'Fortaleza', 'CE'),
('Doceria Amor Doce', 'Fortaleza', 'CE'),
('Moto Peças Ceará', 'Maracanaú', 'CE'),
('Variedades Lima', 'Pacatuba', 'CE'),
('Shopping Mix', 'Caucaia', 'CE'),
('Pet House', 'Eusébio', 'CE'),
('Loja Fashion', 'Fortaleza', 'CE');

-- =============================
-- TABELA PRODUTOS
-- =============================
CREATE TABLE produtos (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(200) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

INSERT INTO produtos (descricao, preco_venda) VALUES
('Arroz Tipo 1 5kg', 22.50),
('Feijão Carioca 1kg', 8.90),
('Macarrão Espaguete 500g', 4.80),
('Café Tradicional 500g', 12.70),
('Açúcar Refinado 1kg', 5.10),
('Sabonete Neutro', 2.30),
('Detergente 500ml', 3.50),
('Shampoo 350ml', 11.90),
('Papel Higiênico 12un', 14.30),
('Farinha de Trigo 1kg', 6.50),
('Biscoito Cream Cracker', 4.20),
('Achocolatado 400g', 9.90),
('Óleo de Soja 900ml', 7.30),
('Água Sanitária 1L', 3.80),
('Desinfetante 2L', 6.90),
('Manteiga 200g', 12.40),
('Fralda Infantil P', 25.90),
('Pão de Forma 500g', 8.70),
('Cerveja Lata', 3.99),
('Refrigerante 2L', 7.99);

-- =============================
-- TABELA PEDIDOS (CABECALHO)
-- =============================
CREATE TABLE pedidos (
    numero_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_emissao DATE NOT NULL,
    codigo_cliente INT NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0,
    
    CONSTRAINT fk_pedido_cliente 
        FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo)
) ENGINE=InnoDB;

-- =============================
-- TABELA PEDIDOS – PRODUTOS
-- =============================
CREATE TABLE pedidos_produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero_pedido INT NOT NULL,
    codigo_produto INT NOT NULL,
    quantidade DECIMAL(10,3) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_item_pedido 
        FOREIGN KEY (numero_pedido) REFERENCES pedidos(numero_pedido)
            ON DELETE CASCADE,

    CONSTRAINT fk_item_produto
        FOREIGN KEY (codigo_produto) REFERENCES produtos(codigo)
) ENGINE=InnoDB;

-- Índices
CREATE INDEX idx_pedidos_produtos_np ON pedidos_produtos(numero_pedido);
CREATE INDEX idx_pedidos_produtos_produto ON pedidos_produtos(codigo_produto);

