import express from "express";
import { agentChatHandler } from "../controllers/agent.js";

const agentRouter = express.Router();

agentRouter.post("/", agentChatHandler);

export default agentRouter;