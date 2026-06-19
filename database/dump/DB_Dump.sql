DROP TABLE IF EXISTS `product_category`;
DROP TABLE IF EXISTS `order_product`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `orders`;

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

ALTER TABLE
    `products` ADD UNIQUE `products_slug_unique`(`slug`);

CREATE TABLE `categories`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `little_description` TEXT NOT NULL,
    `slug` VARCHAR(255) NOT NULL
);

ALTER TABLE
    `categories` ADD UNIQUE `categories_slug_unique`(`slug`);

CREATE TABLE `product_category`(
    `product_id` BIGINT UNSIGNED NOT NULL,
    `category_id` BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY(`product_id`, `category_id`)
);

ALTER TABLE
    `product_category` ADD INDEX `product_category_product_id_category_id_index`(`product_id`, `category_id`);

ALTER TABLE
    `product_category` ADD INDEX `product_category_product_id_index`(`product_id`);

ALTER TABLE
    `product_category` ADD INDEX `product_category_category_id_index`(`category_id`);

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

ALTER TABLE
    `order_product` ADD INDEX `order_product_product_id_order_id_index`(`product_id`, `order_id`);

ALTER TABLE
    `order_product` ADD INDEX `order_product_product_id_index`(`product_id`);

ALTER TABLE
    `order_product` ADD INDEX `order_product_order_id_index`(`order_id`);

ALTER TABLE
    `order_product` ADD CONSTRAINT `order_product_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `orders`(`id`);

ALTER TABLE
    `product_category` ADD CONSTRAINT `product_category_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`);

ALTER TABLE
    `order_product` ADD CONSTRAINT `order_product_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`);

ALTER TABLE
    `product_category` ADD CONSTRAINT `product_category_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `categories`(`id`);
    
   INSERT INTO products (name, slug,description, price, create_date, plastic_offset_kg,image)
VALUES(
'Abisso Rigenerato',
'abisso-rigenerato',
'Questo occhiale unisce un design contemporaneo dalle linee classiche a un profondo valore etico. La montatura è interamente realizzata attraverso la valorizzazione degli scarti e la rigenerazione dei materiali plastici recuperati dai nostri mari. Le sfumature uniche della montatura celebrano la bellezza dell''ecosistema marino, trasformando i rifiuti in un accessorio di alta moda conscio e sostenibile.',
99.99,
'2026-06-19',
2.50,
'abisso-rigenerato.jpg'
),
(
    'Poseidon Wave',
    'poseidon-wave',
    'Questo occhiale si distingue per un design contemporaneo dalle linee morbide ed eleganti, perfetto per chi cerca uno stile iconico e senza tempo. Il vero cuore del prodotto risiede nel suo profondo valore etico: la montatura è infatti realizzata dando una seconda vita ai materiali di scarto e ai rifiuti plastici recuperati direttamente dal mare. Attraverso un accurato processo di rigenerazione, le plastiche si fondono in una texture unica e irripetibile che evoca le correnti e le sfumature dell''oceano, trasformando l''impegno ecologico in un accessorio moda esclusivo.',
    129.90,
    '2026-12-03',
    1.75,
    'poseidon-wave.jpg'
),
(
    'Corallo degli Abissi',
    'corallo-degli-abissi',
    'Caratterizzato da linee sinuose che sposano un design contemporaneo e d''impatto, questo occhiale mette al centro un profondo valore etico. La montatura prende vita attraverso la valorizzazione degli scarti e un attento processo di rigenerazione dei materiali plastici recuperati dal mare. Le striature calde e sottomarine si fondono con le tonalità scure, creando un contrasto unico che trasforma i rifiuti marini in un accessorio esclusivo, simbolo di rispetto e rinascita per i nostri oceani.',
    139.90,
    '2026-03-12',
    2.10,
    'corallo-degli-abissi.jpg'
),
 (
    'Orizzonte di Fuoco',
    'orizzonte-di-fuoco',
    'Questo occhiale coniuga linee dal design contemporaneo e sofisticato con un profondo valore etico volto alla salvaguardia dei mari. La montatura prende vita interamente attraverso la rigenerazione dei materiali e la valorizzazione degli scarti plastici recuperati dalle spiagge e dalle acque marine. La sua particolare texture stratificata unisce le tonalità profonde del Blu Oceano a sfumature calde, trasformando i rifiuti riciclati in un pezzo unico e in un forte messaggio di rinascita ambientale.',
     149.90,
    '2026-06-18',
     2.35,
    'orizzonte-di-fuoco.jpg'
),
(
    'EcoMarea',
    'ecomarea',
    'Caratterizzato da una linea pulita e da un design contemporaneo ed ergonomico, questo modello esprime un profondo valore etico orientato alla rigenerazione dei materiali. La montatura è interamente realizzata attraverso la valorizzazione degli scarti e il riciclo di frammenti di plastica e reti fantasma recuperati dal mare. La finitura opaca con micro-frammenti colorati a contrasto rende ogni pezzo un''opera d''arte unica, che trasforma i rifiuti oceanici in un manifesto di sostenibilità e cura per l''ambiente.',
     119.90,
    '2026-07-01',
     1.90,
    'ecomarea.jpg'
),
(
   'Tramonto di Plastica',
    'tramonto-di-plastica',
    'Questo modello fonde un design contemporaneo dalle linee morbide e versatili con un profondo valore etico basato sulla rigenerazione dei materiali. La montatura è realizzata interamente attraverso il riciclo creativo e la valorizzazione degli scarti plastici sottratti ai nostri mari. I micro-frammenti colorati incastonati nella resina arancione trasparente creano una trama unica, trasformando i rifiuti oceanici in un accessorio moda esclusivo e consapevole.',
    134.90,
    '2026-10-09',
     2.00,
    'tramonto-di-plastica.jpg'
),
(
	'Bagliore Marino',
    'bagliore-marino',
    'Caratterizzato da una montatura geometrica che unisce sapientemente un design contemporaneo a linee d''ispirazione classica, questo modello è guidato da un profondo valore etico. La sua struttura prende vita attraverso la rigenerazione dei materiali e la valorizzazione degli scarti plastici sottratti al mare, visibili nei micro-frammenti colorati incastonati nella superficie. Un accessorio sofisticato che trasforma i rifiuti marini riciclati in un simbolo di eccellenza, stile e rispetto per gli ecosistemi oceanici.',
    144.90,
    '2026-06-19',
    2.20,
    'bagliore-marino.jpg'
    ),
    (
    'Profondità Reclutata',
    'profondita-reclutata',
    'Questo modello fonde sapientemente un design contemporaneo dalle linee geometriche decise con un autentico valore etico di rigenerazione. La montatura prende vita grazie alla valorizzazione degli scarti e al completo riciclo di plastiche recuperate dal mare, i cui micro-frammenti colorati rimangono visibili sulla superficie come testimonianza della rinascita del materiale. Un accessorio esclusivo e leggero che trasforma i rifiuti marini in un elemento di stile d''avanguardia e di rispetto per l''ambiente.',
    154.90,
    '2026-03-22',
    2.50,
    'profondita-reclutata.jpg'
    ),
    (
    'Poseidon Net',
    'poseidon-net',
    'Caratterizzato da una montatura squadrata con angoli morbidi che sposa un design contemporaneo e versatile, questo occhiale esprime un profondo valore etico. La struttura semitrasparente prende vita grazie alla valorizzazione degli scarti e al completo riciclo di rifiuti plastici e reti da pesca recuperati dal mare, lasciando intravedere micro-frammenti multicolore sulla superficie. Un accessorio esclusivo e leggero che trasforma la materia rigenerata in un forte simbolo di sostenibilità e tutela degli oceani.',
    159.90,
    '2026-02-23',
    2.65,
    'poseidon-net.jpg'
    );
 
INSERT INTO categories (name, slug, little_description)
    VALUES(
    'Occhiali da Vista',
    'occhiali-da-vista',
    'Il perfetto connubio tra benessere visivo, estetica contemporanea e rispetto per l''ambiente. Progettate per il massimo comfort quotidiano, queste montature etiche e leggere danno una seconda vita ai materiali di scarto, accompagnandoti nello studio e nel lavoro con uno stile consapevole.'
    ),
    (
    'Occhiali da Sole',
    'occhiali-da-sole',
    'Protezione totale e stile senza tempo per le tue giornate all''aperto. Questa collezione unisce lenti di alta qualità a montature di design realizzate interamente con plastiche riciclate e rifiuti recuperati dal mare, trasformando la sostenibilità in un accessorio iconico.'
    ),
    (
    'Accessori',
    'accessori',
    'I dettagli che fanno la differenza per la cura dei tuoi occhiali. Una linea di custodie e accessori protettivi creati con materiali rigenerati e scarti tessili o plastici recuperati, pensata per chi desidera completare la propria scelta ecologica con un occhio di riguardo alla funzionalità e al design pulito.'
    );

    