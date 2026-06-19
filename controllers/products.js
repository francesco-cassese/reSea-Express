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

        return response.status(200).json({
            error: null,
            data: rows
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

        if(!normalizedSlug){
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