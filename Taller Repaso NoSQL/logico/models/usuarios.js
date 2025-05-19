const mongoose = require('mongoose');

const usuarioSchema = new mongoose.Schema({
    nombre: { type: String, required: true },
    edad: { type: Number, required: true },
    correo: { type: String, required: true },
    activo: {type: Boolean, required: false}
});

module.exports = mongoose.model('Usuarios', usuarioSchema);
