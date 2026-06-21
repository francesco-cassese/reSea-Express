import express from "express";
import validateOrderId from "../middleware/validateOrderId.js";
import validateCreationOrder from '../middleware/validateCreationOrder.js'
import { index, show, create } from '../controllers/orders.js';

const orderRouter = express.Router();

orderRouter.get('/', index);

orderRouter.get('/:id', validateOrderId, show);

orderRouter.post('/', validateCreationOrder, create)

export default orderRouter;
