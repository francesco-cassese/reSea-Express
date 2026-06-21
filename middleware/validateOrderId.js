function validateOrderId(request, response, next) {
const { id } = request.params;
const orderId = Number(id);

if (!Number.isInteger(orderId) || orderId <= 0) {
return response.status(400).json({
error: "Richiesta non valida",
message: "Id non valido"
});
}

request.orderId = orderId;
next();
}

export default validateOrderId;