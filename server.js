import express from 'express';
import cors from "cors";
import path from "path";
import { fileURLToPath } from 'url';
import orderRouter from './routers/orders-router.js';
import productRouter from './routers/products-router.js';
import categoriesRouter from './routers/categories-router.js';

const app = express();

const port = process.env.PORT || 3000;
const host = process.env.HOST || 'localhost';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(
    cors({
        origin: ["http://localhost:5173", "http://127.0.0.1:5173"],
        methods: ["GET", "POST", "PUT", "PATCH", "DELETE"],
        credentials: false
    })
);

app.use(express.json());
app.use(express.static(path.join(__dirname, "public")));
app.use("/img", express.static(path.join(__dirname, "img")));

app.use('/orders', orderRouter);
app.use('/products', productRouter)
app.use('/categories', categoriesRouter);

app.use((request, response, next) => {

    response.status(404).json({
        error: "Risorsa non trovata",
        message: "L'endpoint richiesto non esiste sul server"
    });
});

app.listen(port, (error) => {
    if (error) {
        console.error('Error starting server:', error);
    } else {
        console.log(`Server is running on http://${host}:${port}`);
    }
});
