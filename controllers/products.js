import connection from "../database/connection.js";

async function index(request, response) {
    try {
        const querySql = `
            SELECT
                id,
                name,
                slug,
                description,
                price,
                create_date,
                plastic_offset_kg,
                image
            FROM products
            ORDER BY id DESC
        `;

        const [rows] = await connection.execute(querySql);

        // per creare un percorso assoluto verso le immagini nel backend
        // request.protocol intercetta automaticamente "http" o "https" a seconda dalla chiamata che arriva al database
        // request.get('host') intercetta invece l'host che nel nostro caso è "localhost:3000" quindi alla fine ci ritroveremo con 
        // baseURL='http://localhost:3000'    
        const baseUrl = `${request.protocol}://${request.get('host')}`;

        // Utilizzo .map() per creare un nuovo array trasformando ogni singolo oggetto 'product'
        const productsFormatted = rows.map(product => {

            //Assegno alla variabile il "nome dell'immagine" e gli do un placeholder in caso di immagine inesistente 
            const imageFileName = product.image ? product.image : "placeholder.png";

            //Estraggo create_date dall'oggetto JSON per non farlo arrivare alla card. Non sono dati 
            //che interessano al cliente
            const { create_date, ...productData } = product;

            return {
                //restituisco l'altra parte dell'oggetto
                ...productData,

                //trasformo sia prezzo che plastic_offset_kg per poi poterci fare
                //operazioni in futuro aggiungendo 0 in caso che arrivi una stringa vuota
                price: parseFloat(product.price) || 0,
                plastic_offset_kg: parseFloat(product.plastic_offset_kg) || 0,

                //qui viene montato l'URL completo delle immagini, così al momento della richiesta gli viene passato tutto l'URL
                // 'http://localhost:3000/assets/nome-img.jpg'
                image: `${baseUrl}/assets/${imageFileName}`
            };
        })

        return response.status(200).json({
            error: null,
            data: productsFormatted
        })

    } catch (error) {
        console.error(error);

        return response.status(500).json({
            error: "Internal Server Error",
            message: "Errore durante il recupero dei prodotti"
        })
    }
}

async function show(request, response) {
    try {
        const { slug } = request.params;
        const normalizedSlug = String(slug || "").trim().toLocaleLowerCase();

        if (!normalizedSlug) {
            return response.status(400).json({
                error: "Bad Request",
                message: "Slug non valido"
            });
        }

        const querySql = `
            SELECT
                id,
                name,
                slug,
                description,
                price,
                create_date,
                plastic_offset_kg,
                image
            FROM products
            WHERE slug = ?
            LIMIT 1
        `;

        const [rows] = await connection.execute(querySql, [normalizedSlug]);

        if (rows.length === 0) {
            return response.status(404).json({
                error: "Not Found",
                message: "Prodotto non trovato"
            });
        }

        return response.status(200).json({
            error: null,
            data: rows[0]
        });

    } catch (error) {
        console.error(error);

        return response.status(500).json({
            error: "Internal Server Error",
            message: "Errore durante il recupero dei prodotti"
        })
    }

}

export { index, show };