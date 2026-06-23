import connection from "../database/connection.js";
import { formatProduct } from "../utils/utils.js";

async function index(request, response) {
    try {
        const { search, category, minPrice, maxPrice, sortBy } = request.query;

        const limit = request.validatedLimit || 12;
        const page = request.validatedPage || 1;

        let fromSql = "FROM products p";
        const params = [];
        const conditions = ["1 = 1"];

        if (category) {
            fromSql +=
                " JOIN product_category pc ON p.id = pc.product_id" +
                " JOIN categories c ON pc.category_id = c.id";
            conditions.push("c.slug = ?");
            params.push(category);
        }

        if (search) {
            const q = "%" + search + "%";
            conditions.push(
                "(" +
                    "p.name LIKE ? " +
                    "OR EXISTS (" +
                        "SELECT 1 " +
                        "FROM product_category pcs " +
                        "JOIN categories cs ON cs.id = pcs.category_id " +
                        "WHERE pcs.product_id = p.id " +
                        "AND cs.name LIKE ?" +
                    ")" +
                ")"
            );
            params.push(q, q);
        }

        if (minPrice !== undefined) {
            const parsedMinPrice = Number(minPrice);
            if (!Number.isNaN(parsedMinPrice)) {
                conditions.push("p.price >= ?");
                params.push(parsedMinPrice);
            }
        }

        if (maxPrice !== undefined) {
            const parsedMaxPrice = Number(maxPrice);
            if (!Number.isNaN(parsedMaxPrice)) {
                conditions.push("p.price <= ?");
                params.push(parsedMaxPrice);
            }
        }

        const whereSql = " WHERE " + conditions.join(" AND ");

        let orderSql = "ORDER BY p.id DESC";
        if (sortBy === "recent") {
            orderSql = "ORDER BY p.create_date DESC";
        } else if (sortBy === "price_asc") {
            orderSql = "ORDER BY p.price ASC";
        } else if (sortBy === "price_desc") {
            orderSql = "ORDER BY p.price DESC";
        } else if (sortBy === "name_asc") {
            orderSql = "ORDER BY p.name ASC";
        } else if (sortBy === "name_desc") {
            orderSql = "ORDER BY p.name DESC";
        }

        const countSql =
            "SELECT COUNT(DISTINCT p.id) AS total " +
            fromSql +
            whereSql;

        const [countRows] = await connection.execute(countSql, params);
        const total = Number(countRows[0]?.total ?? 0);
        const totalPages = Math.max(1, Math.ceil(total / limit));

        const safeLimit = Number.isInteger(limit) ? limit : 12;
        const safePage = Number.isInteger(page) ? page : 1;
        const safeOffset = (safePage - 1) * safeLimit;

        const querySql =
            "SELECT DISTINCT " +
                "p.id, " +
                "p.name, " +
                "p.slug, " +
                "p.description, " +
                "p.price, " +
                "p.create_date, " +
                "p.plastic_offset_kg, " +
                "p.image " +
            fromSql +
            whereSql + " " +
            orderSql + " " +
            "LIMIT " + safeLimit + " OFFSET " + safeOffset;

        const [rows] = await connection.execute(querySql, params);

        const baseURL = request.protocol + "://" + request.get("host");
        const productsFormatted = rows.map((product) => formatProduct(product, baseURL));

        return response.status(200).json({
            error: null,
            data: productsFormatted,
            pagination: {
                page: safePage,
                limit: safeLimit,
                total,
                totalPages
            }
        });
    } catch (error) {
        console.error("products.index error:", error);
        console.error("sqlMessage:", error?.sqlMessage);

        return response.status(500).json({
            error: "Errore interno del server",
            message: "Errore durante il recupero dei prodotti"
        });
    }
}

async function show(request, response) {
    try {
        const { slug } = request.params;
        const normalizedSlug = typeof slug === "string" ? slug.trim() : "";

        if (!normalizedSlug) {
            return response.status(400).json({
                error: "Richiesta non valida",
                message: "Slug non valido"
            });
        }

        const productSql =
            "SELECT DISTINCT " +
                "p.id, " +
                "p.name, " +
                "p.slug, " +
                "p.description, " +
                "p.price, " +
                "p.create_date, " +
                "p.plastic_offset_kg, " +
                "p.image " +
            "FROM products p " +
            "WHERE p.slug = ? " +
            "LIMIT 1";

        const [rows] = await connection.execute(productSql, [normalizedSlug]);

        if (rows.length === 0) {
            return response.status(404).json({
                error: "Risorsa non trovata",
                message: "Prodotto non trovato"
            });
        }

        const baseUrl = request.protocol + "://" + request.get("host");
        const product = formatProduct(rows[0], baseUrl);

        const categoriesSql =
            "SELECT " +
                "c.id, " +
                "c.name, " +
                "c.slug, " +
                "c.little_description " +
            "FROM categories c " +
            "JOIN product_category pc ON c.id = pc.category_id " +
            "WHERE pc.product_id = ? " +
            "ORDER BY c.name ASC";

        const [categories] = await connection.execute(categoriesSql, [rows[0].id]);

        product.categories = categories;

        return response.status(200).json({
            error: null,
            data: product
        });
    } catch (error) {
        console.error(error);

        return response.status(500).json({
            error: "Errore interno del server",
            message: "Errore durante il recupero dei prodotti"
        });
    }
}

async function getBestSellers(request, response) {
    try {
        const limit = request.validatedLimit || 4;

        const querySql =
            "SELECT " +
                "p.id, " +
                "p.name, " +
                "p.slug, " +
                "p.price, " +
                "p.image, " +
                "SUM(op.quantity) AS total_sold " +
            "FROM products p " +
            "JOIN order_product op ON p.id = op.product_id " +
            "GROUP BY p.id " +
            "ORDER BY total_sold DESC " +
            "LIMIT ?";

        const [rows] = await connection.query(querySql, [limit]);

        if (rows.length === 0) {
            return response.status(200).json({
                error: null,
                data: [],
                message: "Nessun prodotto venduto al momento."
            });
        }

        const baseUrl = request.protocol + "://" + request.get("host");
        const productsFormatted = rows.map((product) => formatProduct(product, baseUrl));

        return response.status(200).json({
            error: null,
            data: productsFormatted
        });
    } catch (error) {
        return response.status(500).json({
            error: "Errore interno del server",
            message: "Errore durante il recupero dei best seller"
        });
    }
}

export { index, show, getBestSellers };