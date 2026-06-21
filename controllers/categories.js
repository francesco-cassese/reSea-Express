import connection from "../database/connection.js";

async function index(request, response) {
    try {
        const querySql = `
            SELECT
                id,
                name,
                slug,
                little_description
            FROM categories
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
            message: "Errore durante il recupero delle categorie"
        });
    }
}

async function show(request, response) {
    try {
        const { slug } = request.params;

        if (!slug) {
            return response.status(400).json({
                error: "Richiesta non valida",
                message: "Slug non valido"
            })
        }

        const querySql = `
            SELECT
                id,
                name,
                slug,
                little_description
            FROM categories
            WHERE slug = ?
            LIMIT 1
        `;

        const [rows] = await connection.execute(querySql, [slug]);

        if (rows.length === 0) {
            return response.status(404).json({
                error: "Risorsa non trovata",
                message: "Categoria non trovata"
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
            message: "Errore durante il recupero delle categorie"
        });
    }
}

export { index, show };