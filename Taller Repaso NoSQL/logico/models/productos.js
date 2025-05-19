const mongoose = require('mongoose');

const productoSchema = new mongoose.Schema({
    nombre: { type: String, required: true },
    precio: {type: Number, required: true},
    categoria: {type: String, required: true}
});

module.exports = mongoose.model('Productos', productoSchema);
