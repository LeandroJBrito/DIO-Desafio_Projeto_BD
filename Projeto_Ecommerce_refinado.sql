-- criação do banco de dados para o cenário de E-commerce
create database ecommerce_refinado;

-- criar tabela cliente - considerando cadatro como pessoa física e CNPJ opcional

create table cliente(
		idCliente int auto_increment primary key,
        Nome_completo varchar(30),
		CPF char(11) not null,
        Classificação_cliente enum('PF', 'PJ') default 'PF',
        CNPJ char(14), 
		Nome_Fantasia varchar(50),
        Endereço varchar(255),
		constraint unique_CPF_cliente unique (CPF),
		constraint unique_CNPJ_cliente unique (CNPJ)
);

-- criar tabela produto

create table produto(
		idProduto int auto_increment primary key,
        Pnome varchar(15),
        classificacao_etaria bool,
        categoria enum('Eletonicos', 'Vestimenta','Brinquedos','Alimentos') not null,
        avaliação float default false,
        tamanho varchar(10)
);

select * from produto 

create table pagamentos(
		idcliente int,
        idpagamento int,
        tipo_pagamento enum ('credito','debito','boleto','pix'),
        primary key(idCliente, idpagamento)
);

-- criar tabela pedido

create table pedido(
		idpedido int auto_increment primary key,
        idCliente int,
        idpedido_cliente int,
        status_pedido enum('Cancelado','Confirmado','Em Processamento') default 'Em Processamento',
        descricao_pedido varchar(255),
        sendValuefloat float default 10,
        paymentCash bool default false,
        constraint fk_pedido_cliente foreign key (idPedidoCliente) references cliente(idCliente)
);

desc orders;

-- criar tabela Estoque
Create table productStorage(
		idProductStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);


-- criar tabela Fornecedor
Create table fornecedor(
		idfornecedor int auto_increment primary key,
        razao_social varchar(255) not null,
        CNPJ char(15) not null,
        contato char(11) not null,
        constraint unique_fornecedor unique (CNPJ)
);


-- criar tabela Vendedor

Create table vendedor(
		idvendedor int auto_increment primary key,
        razao_social_vendedor varchar(255) not null,
        nome_fantasia varchar(255),
        CNPJ char(15),
        CPF char(9),
        contato char(11) not null,
        constraint unique_cnpj_vendedor unique (CNPJ),
        constraint unique_cpf_vendedor unique (CPF)
);

Create table productSeller(
		idProd_vendedor int,
		idPproduto int,
        produto_qtd int default 1,
        primary key (idProd_vendedor, idPproduto),
        constraint fk_produto_vendedor foreign key (idProdvendedor) references seller(idvendedor),
        constraint fk_produto_produto foreign key (idProduto) references product(idproduto)
);
desc productseller;

Create table productOrder(
		idPOproduto int,
		idPOorder int,
        poQuantity int default 1,
		postatus enum('Disponivel','Sem Estoque') default 'Disponivel',
        primary key (idPOproduto, idPOorder),
        constraint fk_productorder_vendedor foreign key (idPOproduto) references product(idproduto),
        constraint fk_productorder_produto foreign key (idPOorder) references product(idOrder)
);

show tables;
show databases;
select * from produto
where categoria = 'Eletonicos'
having avaliação >'5'
order by Pnome;
