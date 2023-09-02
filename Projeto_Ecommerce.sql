-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
drop database ecommerce;
alter table clients auto_increment=1;

-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Adress varchar(255),
        constraint unique_cpf_client unique (CPF)
);

-- criar tabela produto
-- size equivale dimensão
drop table product;
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10),
        classification_kids bool,
        category enum('Eletonicos', 'Vestimenta','Brinquedos','Alimentos') not null,
        avaliação float default false,
        size varchar(10)
);

-- para ser cointinuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- Além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento

create table payments(
		idclient int,
        idpayment int,
        typepayment enum ('credito','debito','boleto'),
		limitAvailble float,
        primary key(idClient, idpayment)
);

-- criar tabela pedido

create table orders(
		idorder int auto_increment primary key,
        idClient int,
        idorderClient int,
        ordersStatus enum('Cancelado','Confirmado','Em Processamento') default 'Em Processamento',
        orderdescription varchar(255),
        sendValuefloat float default 10,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

desc orders;

-- criar tabela Estoque
Create table productStorage(
		idProductStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);


-- criar tabela Fornecedor
Create table supplier(
		idsupplier int auto_increment primary key,
        Socialname varchar(255) not null,
        CNPJ char(15) not null,
        Contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

desc supplier;

-- criar tabela Vendedor

Create table seller(
		idseller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstractName varchar(255),
        CNPJ char(15),
        CPF char(9),
        Location varchar(255),
        Contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

drop table productSeller;
Create table productSeller(
		idPseller int,
		idPproduct int,
        prodQuantity int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references seller(idseller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
desc productseller;

Create table productOrder(
		idPOproduct int,
		idPOorder int,
        poQuantity int default 1,
		postatus enum('Disponivel','Sem Estoque') default 'Disponivel',
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references product(idOrder)
);

drop table storageLocation;
Create table storageLocation(
		idLproduct int,
		idLstorage int,
        location varchar(255) not null,
		primary key (idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key (idLStorage) references productStorage(idProductstorage)
);

show tables;

use Information_Schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';


