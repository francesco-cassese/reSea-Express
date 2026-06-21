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

if (
email_client == null ||
shipping_address == null ||
billing_address == null ||
total_amount == null ||
order_date == null ||
client_name == null ||
phone_number == null
) {
return response.status(400).json({
error: "Richiesta non valida",
message: "Tutti i campi sono obbligatori."
});
}

if (
typeof email_client !== "string" ||
typeof shipping_address !== "string" ||
typeof billing_address !== "string" ||
typeof client_name !== "string"
) {
return response.status(400).json({
error: "Input non valido",
message: "Tipi di dato non validi."
});
}

const email = email_client.trim();
const shipping = shipping_address.trim();
const billing = billing_address.trim();
const name = client_name.trim();
const phone = String(phone_number).trim();

if (!email || !shipping || !billing || !name || !phone) {
return response.status(400).json({
error: "Richiesta non valida",
message: "Tutti i campi sono obbligatori."
});
}

const emailRegex = /^[^\s@]+@[^\s@]+.[^\s@]+$/;
if (!emailRegex.test(email)) {
return response.status(400).json({
error: "Input non valido",
message: "L'indirizzo email non è valido."
});
}

if (shipping.length < 8 || shipping.length > 150 || billing.length < 8 || billing.length > 150) {
return response.status(400).json({
error: "Input non valido",
message: "Gli indirizzi devono avere una lunghezza compresa tra 8 e 150 caratteri."
});
}

if (name.length < 2 || name.length > 100) {
return response.status(400).json({
error: "Input non valido",
message: "Il nome cliente deve avere una lunghezza compresa tra 2 e 100 caratteri."
});
}

const amount = Number(total_amount);
if (Number.isNaN(amount) || amount <= 0) {
return response.status(400).json({
error: "Input non valido",
message: "L'importo totale deve essere un numero maggiore di zero."
});
}

const phoneRegex = /^\d{7,15}$/;
if (!phoneRegex.test(phone)) {
return response.status(400).json({
error: "Input non valido",
message: "Il numero di telefono deve contenere solo cifre (7-15)."
});
}

const parsedDate = new Date(order_date);
if (Number.isNaN(parsedDate.getTime())) {
return response.status(400).json({
error: "Input non valido",
message: "La data ordine non è valida."
});
}

request.body.email_client = email;
request.body.shipping_address = shipping;
request.body.billing_address = billing;
request.body.client_name = name;
request.body.phone_number = phone;
request.body.total_amount = amount;
request.body.order_date = parsedDate.toISOString().slice(0, 19).replace("T", " ");

next();
}

export default validateCreationOrder;