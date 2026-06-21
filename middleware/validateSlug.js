function validateSlug(request, response, next) {
    const { slug } = request.params;

    if (!slug) {
        return response.status(400).json({ 
            error: "Richiesta non valida", 
            message: "Slug mancante" 
        });
    }

    if (typeof slug !== "string") {
        return response.status(400).json({ 
            error: "Richiesta non valisa", 
            message: "Slug non valido" 
        });
    }

    if (!slug.trim()) {
        return response.status(400).json({ 
            error: "Richiesta non valida", 
            message: "Slug vuoto" 
        });
    }

    next();
}

export default validateSlug;