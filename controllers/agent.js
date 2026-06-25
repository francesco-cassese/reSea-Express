import { callClaude } from "../services/agentService.js";

export async function agentChatHandler(request, response) {
    try{
        const prompt = typeof request.body?.prompt === "string"
            ? request.body.prompt.trim()
            : "";

        if(!prompt) {
            return response.status(400).json({
                error: "Richiesta non valida",
                message: "Il campo prompt è obbligatorio",
                data: null
            });
        }

        if(prompt.length > 2000) {
            return response.status(400).json({
                error: "Richiesta non valida",
                message: "Il prompt è troppo lungo (max 2000 caratteri)",
                data: null
            });
        }

        const answerHtml = await callClaude(prompt);

        return response.status(200).json({
            error: null,
            message: "Risposta generata con succeso",
            data: {
                answerHtml
            }
        });
    } catch (error) {
        console.error("agentChatHandler error:", error);

        const fallbackHtml =
        "<p> Mi dispiace, al momento il servizio AI non è disponibile</p>";

        return response.status(500).json({
            error: "Errore interno del server",
            message: "Impossibile generare la risposta AI",
            data: {
                fallbackHtml
            }
        });
    }
}