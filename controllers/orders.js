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
            error: "Errore interno del server",
            message: "Errore durante il recupero degli ordini"
        });
    }
}

async function show(request, response) {
    try {
        const orderId = request.orderId;

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
            WHERE id = ?
            LIMIT 1
        `;

        const [rows] = await connection.execute(querySql, [orderId]);

        if (rows.length === 0) {
            return response.status(404).json({
                error: "Risorsa non trovata",
                message: "Ordine non trovato"
            });
        }

        return response.status(200).json({
            error: null,
            data: rows[0]
        });

    } catch (error) {
        console.error(error);

        return response.status(500).json({
            error: "Errore interno del server",
            message: "Errore durante il recupero dell'ordine"
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
            error: "Errore interno del server",
            message: "Errore durante la creazione dell'ordine"
        });
    }
}

export { index, show, create};