DROP DATABASE IF EXISTS restaurant; 
CREATE DATABASE restaurant;
USE restaurant;

-- customer
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
	`id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(250) NOT NULL,
	`email` VARCHAR(250) NULL,
	`cpf` VARCHAR(11) NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- `product`
DROP TABLE IF EXISTS product_category;
CREATE TABLE product_category (
	`id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(250) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS product;
CREATE TABLE product (
	`id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(250) NOT NULL,
	`description` VARCHAR(250) NOT NULL,
	`category_id` BIGINT NOT NULL,
	`price` DECIMAL(8, 2) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS order_item;
CREATE TABLE order_item (
	`id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`order_id` BIGINT NOT NULL,
	`product_id` BIGINT NOT NULL,
	`quantity` INT NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
	`id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`customer_id` BIGINT NULL,
	`status` VARCHAR(100) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- foreign keys
ALTER TABLE `product` ADD CONSTRAINT `products_fk` FOREIGN KEY (`category_id`) REFERENCES `product_category`(`id`);
ALTER TABLE `order_item` ADD CONSTRAINT `order_item_fk` FOREIGN KEY (`order_id`) REFERENCES `order`(`id`);
ALTER TABLE `order_item` ADD CONSTRAINT `product_order_fk` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`);
ALTER TABLE `order` ADD CONSTRAINT `order_customer_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`);

-- data insertions
INSERT INTO `customer` (`name`, `email`, `cpf`) VALUES (N'João', N'j@gmail.com', '12345678901');
INSERT INTO `customer` (`name`, `email`, `cpf`) VALUES (N'Maria', N'm@gmail,com', '12345678902');
INSERT INTO `customer` (`name`, `email`, `cpf`) VALUES (N'José', N'jj@gmail.com', '12345678903');
INSERT INTO `customer` (`name`, `email`, `cpf`) VALUES (N'Ana', N'a@gmail.com', '12345678904');

INSERT INTO `product_category` (`name`) VALUES (N'Lanche');
INSERT INTO `product_category` (`name`) VALUES (N'Acompanhamento');
INSERT INTO `product_category` (`name`) VALUES (N'Bebida');
INSERT INTO `product_category` (`name`) VALUES (N'Sobremesa');

INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'X-Burguer', N'Pão, carne, queijo, alface, tomate e maionese', 1, 10.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'X-Salada', N'Pão, carne, queijo, alface, tomate, maionese e batata palha', 1, 12.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'X-Bacon', N'Pão, carne, queijo, alface, tomate, maionese e bacon', 1, 15.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'X-Tudo', N'Pão, carne, queijo, alface, tomate, maionese, bacon, ovo e batata palha', 1, 18.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'Batata Frita', N'Batata frita com molho especial', 2, 5.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'Refrigerante', N'Refrigerante lata 350ml', 3, 4.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'Suco', N'Suco natural 500ml', 3, 6.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'Milk Shake', N'Milk Shake 500ml', 3, 8.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'Sorvete', N'Sorvete 500ml', 4, 10.00);
INSERT INTO `product` (`name`, `description`, `category_id`, `price`) VALUES (N'Pudim', N'Pudim de leite', 4, 8.00);
