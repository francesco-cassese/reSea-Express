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

app.use(cors());
app.use(express.json());
app.use('/assets', express.static('public/assets'))


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
