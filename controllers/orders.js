import connection from "../database/connection.js";

async function index(request, response) {
    try {
        const querySql = `
            SELECT
                id,
                email_client,
                shipping_address,
                billing_address, 
                total_amount, 
                order_date, 
                client_name, 
                phone_number
            FROM orders
            ORDER BY id DESC
        `;

        const [rows] = await connection.execute(querySql);

        return response.status(200).json({
            error: null,
            data: rows
        });

    } catch (error) {
        console.error(error);

        return response.status(500).json({
            error: "Internal Server Error",
            message: "Errore durante il recupero delle categorie"
        });
    }
}

async function show(request, response) {
    try {
        const { slug } = request.params;
        const normalizedSlug = String(slug || "").trim().toLocaleLowerCase();

        if (!normalizedSlug) {
            return response.status(400).json({
                error: "Bad Request",
                error: "Slug non valido"
            })
        }

        const querySql = `
            SELECT
                id,
                email_client,
                shipping_address,
                billing_address, 
                total_amount, 
                order_date, 
                client_name, 
                phone_number
            FROM orders
            WHERE slug = ?
            LIMIT 1
        `;

        const [rows] = await connection.execute(querySql);

        if (rows.lenght === 0) {
            return response.status(404).json({
                error: "Not Found",
                message: "Categoria non troavata"
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
            message: "Errore durante il recupero delle categorie"
        });
    }
}

async function create(request, response) {
    try {
        const {
            email_client,
            shipping_address,
            billing_address,
            total_amount,
            order_date,
            client_name,
            phone_number
        } = request.body;

        if (
            !email_client ||
            !shipping_address ||
            !billing_address ||
            total_amount == null ||
            !order_date ||
            !client_name ||
            !phone_number
        ) {
            return response.status(400).json({
                error: "Bad Request",
                message: "Dati obbligatori mancanti"
            });
        }

        const querySql = `
            INSERT INTO orders (
                email_client,
                shipping_address,
                billing_address,
                total_amount,
                order_date,
                client_name,
                phone_number
            )
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `;

        const [result] = await connection.execute(querySql, [
            email_client,
            shipping_address,
            billing_address,
            total_amount,
            order_date,
            client_name,
            phone_number
        ]);

        return response.status(201).json({
            error: null,
            message: "Ordine creato con successo",
            data: {
                id: result.insertId
            }
        });
    }catch (error) {
        console.error(error);

        return response.status(500).json({
            error: "Internal Server Error",
            message: "Errore durante la creazione dell'ordine"
        });
    }
}

export { index, show, create};