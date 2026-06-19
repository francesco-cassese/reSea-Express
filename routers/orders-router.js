import express from "express";
import validateCreationOrder from '../middleware/validateCreationOrder.js'
import { index, show, create } from '../controllers/orders.js';

const orderRouter = express.Router();

orderRouter.get('/', index);

orderRouter.get('/:id', show);

orderRouter.post('/', validateCreationOrder, create)

export default orderRouter;
