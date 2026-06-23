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

ALTER TABLE `product_category` ADD INDEX `product_category_product_id_category_id_index`(`product_id`, `category_id`);
ALTER TABLE `product_category` ADD INDEX `product_category_product_id_index`(`product_id`);
ALTER TABLE `product_category` ADD INDEX `product_category_category_id_index`(`category_id`);

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

ALTER TABLE `order_product` ADD INDEX `order_product_product_id_order_id_index`(`product_id`, `order_id`);
ALTER TABLE `order_product` ADD INDEX `order_product_product_id_index`(`product_id`);
ALTER TABLE `order_product` ADD INDEX `order_product_order_id_index`(`order_id`);

-- 3. Aggiunta Foreign Keys
ALTER TABLE `order_product` ADD CONSTRAINT `order_product_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `orders`(`id`);
ALTER TABLE `product_category` ADD CONSTRAINT `product_category_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`);
ALTER TABLE `order_product` ADD CONSTRAINT `order_product_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`);
ALTER TABLE `product_category` ADD CONSTRAINT `product_category_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `categories`(`id`);

-- 4. Inserimento Dati (Seed) con descrizioni complete
INSERT INTO products (name, slug, description, price, create_date, plastic_offset_kg, image) VALUES
('Abisso Rigenerato', 'abisso-rigenerato', 'Questo occhiale unisce un design contemporaneo dalle linee classiche a un profondo valore etico. La montatura è interamente realizzata attraverso la valorizzazione degli scarti e la rigenerazione dei materiali plastici recuperati dai nostri mari. Le sfumature uniche della montatura celebrano la bellezza dell''ecosistema marino, trasformando i rifiuti in un accessorio di alta moda conscio e sostenibile.', 99.99, '2026-06-19', 2.50, 'abisso-rigenerato.jpg'),
('Poseidon Wave', 'poseidon-wave', 'Questo occhiale si distingue per un design contemporaneo dalle linee morbide ed eleganti, perfetto per chi cerca uno stile iconico e senza tempo. Il vero cuore del prodotto risiede nel suo profondo valore etico: la montatura è infatti realizzata dando una seconda vita ai materiali di scarto e ai rifiuti plastici recuperati direttamente dal mare. Attraverso un accurato processo di rigenerazione, le plastiche si fondono in una texture unica e irripetibile che evoca le correnti e le sfumature dell''oceano, trasformando l''impegno ecologico in un accessorio moda esclusivo.', 129.90, '2026-12-03', 1.75, 'poseidon-wave.jpg'),
('Corallo degli Abissi', 'corallo-degli-abissi', 'Caratterizzato da linee sinuose che sposano un design contemporaneo e d''impatto, questo occhiale mette al centro un profondo valore etico. La montatura prende vita attraverso la valorizzazione degli scarti e un attento processo di rigenerazione dei materiali plastici recuperati dal mare. Le striature calde e sottomarine si fondono con le tonalità scure, creando un contrasto unico che trasforma i rifiuti marini in un accessorio esclusivo, simbolo di rispetto e rinascita per i nostri oceani.', 139.90, '2026-03-12', 2.10, 'corallo-degli-abissi.jpg'),
('Orizzonte di Fuoco', 'orizzonte-di-fuoco', 'Questo occhiale coniuga linee dal design contemporaneo e sofisticato con un profondo valore etico volto alla salvaguardia dei mari. La montatura prende vita interamente attraverso la rigenerazione dei materiali e la valorizzazione degli scarti plastici recuperati dalle spiagge e dalle acque marine. La sua particolare texture stratificata unisce le tonalità profonde del Blu Oceano a sfumature calde, trasformando i rifiuti riciclati in un pezzo unico e in un forte messaggio di rinascita ambientale.', 149.90, '2026-06-18', 2.35, 'orizzonte-di-fuoco.jpg'),
('EcoMarea', 'ecomarea', 'Caratterizzato da una linea pulita e da un design contemporaneo ed ergonomico, questo modello esprime un profondo valore etico orientato alla rigenerazione dei materiali. La montatura è interamente realizzata attraverso la valorizzazione degli scarti e il riciclo di frammenti di plastica e reti fantasma recuperati dal mare. La finitura opaca con micro-frammenti colorati a contrasto rende ogni pezzo un''opera d''arte unica, che trasforma i rifiuti oceanici in un manifesto di sostenibilità e cura per l''ambiente.', 119.90, '2026-07-01', 1.90, 'ecomarea.jpg'),
('Tramonto di Plastica', 'tramonto-di-plastica', 'Questo modello fonde un design contemporaneo dalle linee morbide e versatili con un profondo valore etico basato sulla rigenerazione dei materiali. La montatura è realizzata interamente attraverso il riciclo creativo e la valorizzazione degli scarti plastici sottratti ai nostri mari. I micro-frammenti colorati incastonati nella resina arancione trasparente creano una trama unica, trasformando i rifiuti oceanici in un accessorio moda esclusivo e consapevole.', 134.90, '2026-10-09', 2.00, 'tramonto-di-plastica.jpg'),
('Bagliore Marino', 'bagliore-marino', 'Caratterizzato da una montatura geometrica che unisce sapientemente un design contemporaneo a linee d''ispirazione classica, questo modello è guidato da un profondo valore etico. La sua struttura prende vita attraverso la rigenerazione dei materiali e la valorizzazione degli scarti plastici sottratti al mare, visibili nei micro-frammenti colorati incastonati nella superficie. Un accessorio sofisticato che trasforma i rifiuti marini riciclati in un simbolo di eccellenza, stile e rispetto per gli ecosistemi oceanici.', 144.90, '2026-06-19', 2.20, 'bagliore-marino.jpg'),
('Profondità Reclutata', 'profondita-reclutata', 'Questo modello fonde sapientemente un design contemporaneo dalle linee geometriche decise con un autentico valore etico di rigenerazione. La montatura prende vita grazie alla valorizzazione degli scarti e al completo riciclo di plastiche recuperate dal mare, i cui micro-frammenti colorati rimangono visibili sulla superficie come testimonianza della rinascita del materiale. Un accessorio esclusivo e leggero che trasforma i rifiuti marini in un elemento di stile d''avanguardia e di rispetto per l''ambiente.', 154.90, '2026-03-22', 2.50, 'profondita-reclutata.jpg'),
('Poseidon Net', 'poseidon-net', 'Caratterizzato da una montatura squadrata con angoli morbidi che sposa un design contemporaneo e versatile, questo occhiale esprime un profondo valore etico. La struttura semitrasparente prende vita grazie alla valorizzazione degli scarti e al completo riciclo di rifiuti plastici e reti da pesca recuperati dal mare, lasciando intravedere micro-frammenti multicolore sulla superficie. Un accessorio esclusivo e leggero che trasforma la materia rigenerata in un forte simbolo di sostenibilità e tutela degli oceani.', 159.90, '2026-02-23', 2.65, 'poseidon-net.jpg'),
('Ambra della Costa', 'ambra-della-costa', 'Questo occhiale reinterpreta una silhouette dal design contemporaneo e pulito attraverso un profondo valore etico. La montatura semitrasparente è interamente realizzata dando una seconda vita ai materiali plastici di scarto e ai rifiuti recuperati dal mare. Grazie a un attento processo di rigenerazione, la plastica acquista una finitura cristallina e luminosa che cattura la luce, dimostrando come gli scarti marini possano trasformarsi in un accessorio moda esclusivo, elegante e rispettoso del nostro pianeta.', 124.90, '2026-05-11', 1.85, 'ambra-della-costa.jpg'),
('Cordoncino Gavitello', 'cordoncino-gavitello', 'Questo accessorio unisce un design contemporaneo, sportivo e minimale a un profondo valore etico volto alla pulizia dei mari. Il cordoncino regolabile è interamente realizzato tramite il riciclo e la valorizzazione di scarti plastici e vecchie cime da pesca recuperate dalle acque oceaniche. Grazie a questo virtuoso processo di rigenerazione dei materiali, i rifiuti vengono trasformati in un elemento funzionale, resistente e ricco di stile, pensato per completare la tua scelta ecologica e proteggere i tuoi occhiali in ogni avventura.', 19.90, '2026-04-08', 0.45, 'cordoncino-gavitello.jpg'),
('Cordoncino Ancora', 'cordoncino-ancora', 'Questo cordoncino intrecciato combina un design contemporaneo di ispirazione nautica con un profondo valore etico orientato alla rigenerazione dei materiali. Creato interamente attraverso la valorizzazione degli scarti e il riciclo di cime e plastiche recuperate dai fondali marini, l''accessorio si presenta robusto, funzionale e curato nei minimi dettagli. Una scelta d''avanguardia che trasforma i rifiuti oceanici in un simbolo di stile e impegno ecologico.', 24.90, '2026-05-22', 0.55, 'cordoncino-ancora.jpg'),
('Cordoncino Salvagente', 'cordoncino-salvagente', 'Questo cordoncino tecnico unisce un design contemporaneo, dinamico e fortemente legato al mondo nautico, con un profondo valore etico volto alla protezione dell''ambiente marino. L''accessorio regolabile è realizzato interamente attraverso la rigenerazione dei materiali e la valorizzazione degli scarti plastici e delle vecchie cime da pesca recuperate dai mari. Un dettaglio di stile resistente e funzionale che trasforma la materia riciclata in un vero e proprio manifesto di sostenibilità e amore per gli oceani.', 22.90, '2026-06-03', 0.50, 'cordoncino-salvagente.jpg'),
('Cordoncino Abisso', 'cordoncino-abisso', 'Questo cordoncino intrecciato combina un design contemporaneo di chiara ispirazione nautica con un profondo valore etico incentrato sulla pulizia dei nostri oceani. L''accessorio è interamente realizzato valorizzando gli scarti e rigenerando le vecchie cime da pesca e le plastiche recuperate direttamente dalle acque marine. Robusto, flessibile e rifinito con cura, si adatta perfettamente a ogni montatura, trasformando la materia riciclata in un dettaglio di stile consapevole e funzionale.', 21.90, '2026-04-27', 0.48, 'cordoncino-abisso.jpg'),
('Cordoncino Veliero', 'cordoncino-veliero', 'Questo cordoncino per occhiali reinterpreta lo stile nautico classico attraverso un design contemporaneo e sofisticato, arricchito da eleganti dettagli metallici. Il prodotto è guidato da un profondo valore etico: l''intero filato è ottenuto dal recupero, dalla valorizzazione degli scarti e dalla rigenerazione di reti da pesca e materiali plastici abbandonati in mare. Un accessorio funzionale e di carattere, perfetto per chi desidera coniugare l''eleganza a bordo o nella vita quotidiana con una scelta di consumo responsabile e attenta alla salute degli oceani.', 29.90, '2026-05-30', 0.60, 'cordoncino-veliero.jpg'),
('Custodia Corallo', 'custodia-corallo', 'Questa custodia per occhiali unisce un design contemporaneo, minimale e geometrico a un profondo valore etico orientato alla sostenibilità. Realizzata interamente attraverso la rigenerazione dei materiali e la valorizzazione degli scarti flessibili recuperati o derivati dalla pulizia dei mari, offre una protezione ottimale ed elegante per i tuoi occhiali. Una scelta d''avanguardia che trasforma la materia riciclata in un accessorio piacevole al tatto, funzionale e rispettoso dell''ecosistema marino.', 34.90, '2026-06-07', 0.80, 'custodia-corallo.jpg'),
('Custodia Abisso', 'custodia-abisso', 'Questa custodia per occhiali si distingue per un design contemporaneo dalle linee pulite, essenziali ed eleganti. Sviluppata secondo un profondo valore etico, la sua struttura è interamente realizzata attraverso la rigenerazione dei materiali e la valorizzazione degli scarti flessibili recuperati dagli ecosistemi marini. Un accessorio sofisticato e piacevole al tatto che offre una protezione impeccabile, trasformando la materia riciclata in un concreto simbolo di responsabilità ambientale e rispetto per l''oceano.', 39.90, '2026-05-18', 0.95, 'custodia-abisso.jpg'),
('Custodia Alga', 'custodia-alga', 'Questa custodia per occhiali reinterpreta la funzionalità quotidiana attraverso un design contemporaneo, geometrico ed essenziale. Il prodotto è mosso da un profondo valore etico incentrato sulla rigenerazione dei materiali: la sua struttura semitrasparente e texturizzata prende vita grazie alla valorizzazione di scarti plastici e polimeri recuperati dai fondali marini. Un accessorio leggero e protettivo che dimostra come l''economia circolare possa trasformare i rifiuti in un elemento di stile d''avanguardia e di rispetto per la natura.', 36.90, '2026-06-11', 0.85, 'custodia-alga.jpg'),
('Custodia Fondale', 'custodia-fondale', 'Questa custodia per occhiali unisce un design contemporaneo dalle linee pulite e geometriche a un profondo valore etico di rigenerazione dei materiali. Realizzata interamente attraverso il recupero e la valorizzazione degli scarti plastici e dei polimeri flessibili sottratti ai nostri mari, offre una protezione ottimale con un''elegante finitura opaca e testurizzata. Un accessorio sofisticato ed ecosostenibile che testimonia una rinascita della materia nel pieno rispetto dell''ambiente marino.', 37.90, '2026-05-25', 0.90, 'custodia-fondale.jpg'),
('Custodia Arenile', 'custodia-arenile', 'Questa custodia per occhiali reinterpreta la cura dei tuoi accessori attraverso un design contemporaneo, geometrico ed essenziale. Il progetto è guidato da un profondo valore etico basato sulla rigenerazione dei materiali: la sua struttura semitrasparente e puntinata prende vita grazie alla valorizzazione di scarti plastici e polimeri riciclati recuperati dagli ambienti marini. Un accessorio protettivo, leggero e dal look naturale, che dimostra come l''economia circolare possa trasformare i rifiuti in un elemento di stile d''avanguardia.', 35.90, '2026-06-14', 0.82, 'custodia-arenile.jpg');

INSERT INTO categories (name, slug, little_description) VALUES
('Occhiali da Vista', 'occhiali-da-vista', 'Il perfetto connubio tra benessere visivo, estetica contemporanea e rispetto per l''ambiente. Progettate per il massimo comfort quotidiano, queste montature etiche e leggere danno una seconda vita ai materiali di scarto, accompagnandoti nello studio e nel lavoro con uno stile consapevole.'),
('Occhiali da Sole', 'occhiali-da-sole', 'Protezione totale e stile senza tempo per le tue giornate all''aperto. Questa collezione unisce lenti di alta qualità a montature di design realizzate interamente con plastiche riciclate e rifiuti recuperati dal mare, trasformando la sostenibilità in un accessorio iconico.'),
('Accessori', 'accessori', 'I dettagli che fanno la differenza per la cura dei tuoi occhiali. Una linea di custodie e accessori protettivi creati con materiali rigenerati e scarti tessili o plastici recuperati, pensata per chi desidera completare la propria scelta ecologica con un occhio di riguardo alla funzionalità e al design pulito.');

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