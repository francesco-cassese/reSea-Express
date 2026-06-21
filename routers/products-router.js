import express from "express";
import validateProductsQuery from "../middleware/validateProductsQuery.js";
import validateSlug from "../middleware/validateSlug.js";

import { index, show } from '../controllers/products.js';

const productRouter = express.Router();

productRouter.get('/', validateProductsQuery, index);

productRouter.get('/:slug', validateSlug, show);

export default productRouter;
