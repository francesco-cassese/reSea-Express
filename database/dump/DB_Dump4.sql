-- 1. Pulizia totale del database
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `product_category`;
DROP TABLE IF EXISTS `order_product`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `orders`;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. Creazione Struttura Tabelle
CREATE TABLE `products`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `price` DECIMAL(8, 2) NOT NULL,
    `create_date` DATE NOT NULL,
    `plastic_offset_kg` DECIMAL(5, 2) NOT NULL,
    `image` VARCHAR(255) NOT NULL
);
ALTER TABLE `products` ADD UNIQUE `products_slug_unique`(`slug`);

CREATE TABLE `categories`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `little_description` TEXT NOT NULL,
    `slug` VARCHAR(255) NOT NULL
);
ALTER TABLE `categories` ADD UNIQUE `categories_slug_unique`(`slug`);

CREATE TABLE `product_category`(
    `product_id` BIGINT UNSIGNED NOT NULL,
    `category_id` BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY(`product_id`, `category_id`)
);

CREATE TABLE `orders`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `email_client` VARCHAR(255) NOT NULL,
    `shipping_address` TEXT NOT NULL,
    `billing_address` TEXT NOT NULL,
    `total_amount` DECIMAL(8, 2) NOT NULL,
    `order_date` TIMESTAMP NOT NULL,
    `client_name` VARCHAR(255) NOT NULL,
    `phone_number` VARCHAR(20) NOT NULL
);

CREATE TABLE `order_product`(
    `product_id` BIGINT UNSIGNED NOT NULL,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `quantity` INT NOT NULL,
    `price` DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY(`order_id`, `product_id`)
);

-- 3. Aggiunta Foreign Keys e Indici
ALTER TABLE `product_category` ADD CONSTRAINT `product_category_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`);
ALTER TABLE `product_category` ADD CONSTRAINT `product_category_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `categories`(`id`);
ALTER TABLE `order_product` ADD CONSTRAINT `order_product_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `orders`(`id`);
ALTER TABLE `order_product` ADD CONSTRAINT `order_product_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`);

-- 4. Inserimento Dati (Seed)
INSERT INTO products (name, slug, description, price, create_date, plastic_offset_kg, image) VALUES
('Abisso Rigenerato', 'abisso-rigenerato', '...', 99.99, '2026-06-19', 2.50, 'abisso-rigenerato.jpg'),
('Poseidon Wave', 'poseidon-wave', '...', 129.90, '2026-12-03', 1.75, 'poseidon-wave.jpg'),
('Corallo degli Abissi', 'corallo-degli-abissi', '...', 139.90, '2026-03-12', 2.10, 'corallo-degli-abissi.jpg'),
('Orizzonte di Fuoco', 'orizzonte-di-fuoco', '...', 149.90, '2026-06-18', 2.35, 'orizzonte-di-fuoco.jpg'),
('EcoMarea', 'ecomarea', '...', 119.90, '2026-07-01', 1.90, 'ecomarea.jpg'),
('Tramonto di Plastica', 'tramonto-di-plastica', '...', 134.90, '2026-10-09', 2.00, 'tramonto-di-plastica.jpg'),
('Bagliore Marino', 'bagliore-marino', '...', 144.90, '2026-06-19', 2.20, 'bagliore-marino.jpg'),
('Profondità Reclutata', 'profondita-reclutata', '...', 154.90, '2026-03-22', 2.50, 'profondita-reclutata.jpg'),
('Poseidon Net', 'poseidon-net', '...', 159.90, '2026-02-23', 2.65, 'poseidon-net.jpg'),
('Ambra della Costa', 'ambra-della-costa', '...', 124.90, '2026-05-11', 1.85, 'ambra-della-costa.jpg'),
('Cordoncino Gavitello', 'cordoncino-gavitello', '...', 19.90, '2026-04-08', 0.45, 'cordoncino-gavitello.jpg'),
('Cordoncino Ancora', 'cordoncino-ancora', '...', 24.90, '2026-05-22', 0.55, 'cordoncino-ancora.jpg'),
('Cordoncino Salvagente', 'cordoncino-salvagente', '...', 22.90, '2026-06-03', 0.50, 'cordoncino-salvagente.jpg'),
('Cordoncino Abisso', 'cordoncino-abisso', '...', 21.90, '2026-04-27', 0.48, 'cordoncino-abisso.jpg'),
('Cordoncino Veliero', 'cordoncino-veliero', '...', 29.90, '2026-05-30', 0.60, 'cordoncino-veliero.jpg'),
('Custodia Corallo', 'custodia-corallo', '...', 34.90, '2026-06-07', 0.80, 'custodia-corallo.jpg'),
('Custodia Abisso', 'custodia-abisso', '...', 39.90, '2026-05-18', 0.95, 'custodia-abisso.jpg'),
('Custodia Alga', 'custodia-alga', '...', 36.90, '2026-06-11', 0.85, 'custodia-alga.jpg'),
('Custodia Fondale', 'custodia-fondale', '...', 37.90, '2026-05-25', 0.90, 'custodia-fondale.jpg'),
('Custodia Arenile', 'custodia-arenile', '...', 35.90, '2026-06-14', 0.82, 'custodia-arenile.jpg');

INSERT INTO categories (name, slug, little_description) VALUES
('Occhiali da Vista', 'occhiali-da-vista', '...'),
('Occhiali da Sole', 'occhiali-da-sole', '...'),
('Accessori', 'accessori', '...');

INSERT INTO orders (email_client, shipping_address, billing_address, total_amount, order_date, client_name, phone_number) VALUES
('marco.rossi@email.com', 'Via Roma 12, Milano', 'Via Roma 12, Milano', 129.90, '2026-06-15', 'Marco Rossi', '3331234567'),
('giulia.bianchi@email.com', 'Via Garibaldi 45, Torino', 'Via Garibaldi 45, Torino', 259.80, '2026-06-16', 'Giulia Bianchi', '3342345678'),
('luca.verdi@email.com', 'Corso Italia 88, Napoli', 'Corso Italia 88, Napoli', 99.99, '2026-06-17', 'Luca Verdi', '3353456789'),
('sara.esposito@email.com', 'Via Dante 21, Bologna', 'Via Dante 21, Bologna', 144.90, '2026-06-17', 'Sara Esposito', '3364567890'),
('alessandro.russo@email.com', 'Via Mazzini 67, Firenze', 'Via Mazzini 67, Firenze', 154.90, '2026-06-18', 'Alessandro Russo', '3375678901'),
('francesca.gallo@email.com', 'Piazza Duomo 5, Palermo', 'Piazza Duomo 5, Palermo', 239.80, '2026-06-18', 'Francesca Gallo', '3386789012'),
('davide.ferrari@email.com', 'Via Manzoni 103, Genova', 'Via Manzoni 103, Genova', 119.90, '2026-06-19', 'Davide Ferrari', '3397890123'),
('chiara.conti@email.com', 'Via Veneto 17, Verona', 'Via Veneto 17, Verona', 149.90, '2026-06-19', 'Chiara Conti', '3408901234'),
('matteo.greco@email.com', 'Via Leopardi 9, Bari', 'Via Leopardi 9, Bari', 134.90, '2026-06-20', 'Matteo Greco', '3419012345'),
('elena.marino@email.com', 'Via Cavour 34, Catania', 'Via Cavour 34, Catania', 159.90, '2026-06-20', 'Elena Marino', '3420123456');

INSERT INTO product_category (product_id, category_id) SELECT p.id, c.id FROM products p JOIN categories c ON c.slug = 'occhiali-da-vista' WHERE p.slug IN ('ecomarea', 'tramonto-di-plastica', 'bagliore-marino', 'profondita-reclutata', 'poseidon-net');
INSERT INTO product_category (product_id, category_id) SELECT p.id, c.id FROM products p JOIN categories c ON c.slug = 'occhiali-da-sole' WHERE p.slug IN ('abisso-rigenerato', 'poseidon-wave', 'corallo-degli-abissi', 'orizzonte-di-fuoco', 'ambra-della-costa');
INSERT INTO product_category (product_id, category_id) SELECT p.id, c.id FROM products p JOIN categories c ON c.slug = 'accessori' WHERE p.slug IN ('cordoncino-gavitello', 'cordoncino-ancora', 'cordoncino-salvagente', 'cordoncino-abisso', 'cordoncino-veliero', 'custodia-corallo', 'custodia-abisso', 'custodia-alga', 'custodia-fondale', 'custodia-arenile');

INSERT INTO order_product (order_id, product_id, quantity, price) VALUES 
(1, 2, 1, 129.90), (2, 2, 2, 129.90), (3, 1, 1, 99.99), (4, 7, 1, 144.90), (5, 8, 1, 154.90), (6, 1, 2, 99.99), (7, 5, 1, 119.90), (8, 4, 1, 149.90), (9, 6, 1, 134.90), (10, 9, 1, 159.90);