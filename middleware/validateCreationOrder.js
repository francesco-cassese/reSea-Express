function validateCreationOrder(request, response, next) {
    const {
        email_client,
        shipping_address,
        billing_address,
        total_amount,
        order_date,
        client_name,
        phone_number
    } = request.body;

    // Valida che tutti i campi esistano o non siano vuoti
    if (
        !email_client || email_client.trim().length === 0 ||
        !shipping_address || shipping_address.trim().length === 0 ||
        !billing_address || billing_address.trim().length === 0 ||
        !total_amount || String(total_amount).trim().length === 0 ||
        !order_date || String(order_date).trim().length === 0 ||
        !client_name || client_name.trim().length === 0 ||
        !phone_number || String(phone_number).trim().length === 0
    ) {
        return response.status(400).json({
            error: "Bad Request",
            message: "Tutti i campi sono obbligatori."
        });
    }

    // Validazione e-mail
    if (
        typeof email_client !== 'string' ||
        !email_client.includes('@') ||
        !email_client.includes('.')
    ) {
        return response.status(400).json({
            error: "Invalid Input",
            message: "L'indirizzo email non è valido o non è in formato corretto."
        });
    }

    // Validazione indirizzi
    if (
        shipping_address.trim().length < 8 || shipping_address.trim().length > 150 ||
        billing_address.trim().length < 8 || billing_address.trim().length > 150
    ) {
        return response.status(400).json({
            error: "Invalid Input",
            message: "Gli indirizzi devono avere una lunghezza compresa tra 8 e 150 caratteri."
        });
    }

    // Validazione prezzo
    const amount = parseFloat(total_amount);
    if (isNaN(amount) || amount <= 0) {
        return response.status(400).json({
            error: "Invalid Input",
            message: "L'importo totale deve essere un numero maggiore di zero."
        });
    }

    // Validazione nome cliente
    if (
        typeof client_name !== 'string' ||
        client_name.trim().length < 2 ||
        client_name.trim().length > 100
    ) {
        return response.status(400).json({
            error: "Invalid Input",
            message: "Il nome cliente non è valido: deve essere una stringa con lunghezza compresa fra 2 e 100 caratteri."
        });
    }

    // Validazione numero di telefono
    if (isNaN(Number(phone_number))) {
        return response.status(400).json({
            error: "Invalid Input",
            message: "Il numero di telefono deve contenere solo cifre."
        });
    }

    next();
};

export default validateCreationOrder;