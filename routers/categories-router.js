import express from "express";
import { index, show } from "../controllers/categories.js";
import validateSlug from "../middleware/validateSlug.js";

const categoriesRouter = express.Router();

categoriesRouter.get("/", index);
categoriesRouter.get("/:slug", validateSlug, show);

export default categoriesRouter;