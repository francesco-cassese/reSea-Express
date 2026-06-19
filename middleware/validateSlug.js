function validateSlug(request, response, next) {
    const { slug } = request.params;

    if (!slug) {
        return response.status(400).json({ 
            error: "Bad Request", 
            message: "Slug mancante" 
        });
    }

    if (typeof slug !== "string") {
        return response.status(400).json({ 
            error: "Bad Request", 
            message: "Slug non valido" 
        });
    }

    if (!slug.trim()) {
        return response.status(400).json({ 
            error: "Bad Request", 
            message: "Slug vuoto" 
        });
    }

    next();
}

export default validateSlug;