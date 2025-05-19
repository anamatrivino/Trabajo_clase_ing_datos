const express = require('express');
const router = express.Router();
const Usuarios = require('../models/usuarios');

// Registrar un usuario
router.post('/', async (req, res) => {
    try {
        const usu = new Usuarios(req.body);
        await usu.save();
        res.status(201).json(usu);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

// Consultar todos los usuarios
router.get('/', async (req, res) => {
    try {
        const usuarios = await Usuarios.find();
        res.json(usuarios);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Consultar usuario por ID
router.get('/:id', async (req, res) => {
    try {
        const usuario = await Usuarios.findById(req.params.id);
        if (!usuario) return res.status(404).json({ error: "Usuario no encontrado" });
        res.json(usuario);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Consultar usuarios mayores a una edad dada
router.get('/mayores/:edad', async (req, res) => {
    try {
        const edadMinima = parseInt(req.params.edad);
        if (isNaN(edadMinima)) {
            return res.status(400).json({ error: "Usuario no encontrado" });
        }

        const usuarios = await Usuarios.find({ edad: { $gt: edadMinima } });
        res.json(usuarios);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Modificar usuario
router.put('/:id', async (req, res) => {
    try {
        const usuario = await Usuarios.findByIdAndUpdate(req.params.id, req.body, { new: true });
        if (!usuario) return res.status(404).json({ error: "Usuario no encontrado" });
        res.json(usuario);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Agregrar un campo
router.put('/activo/:edad', async (req, res) => {
    try {
        const edadmin = parseInt(req.params.edad);
        const resultado = await Usuarios.updateMany(
            { edad: { $gte: edadmin} },
            { $set: { activo: true } }
        );
        res.json(resultado);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Eliminar usuario
router.delete('/:id', async (req, res) => {
    try {
        const usuario = await Usuarios.findByIdAndDelete(req.params.id);
        if (!usuario) return res.status(404).json({ error: "Usuario no encontrado" });
        res.json(usuario);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Eliminar todos los usuarios que tengan sean menores a una edad
router.delete('/menores/:edad', async (req, res) => {
    try {
        const edadMaxima = parseInt(req.params.edad);
        if (isNaN(edadMaxima)) {
            return res.status(400).json({ error: "Usuario no encontrado" });
        }
        const usuario = await Usuarios.deleteMany({ edad: { $lt: edadMaxima } });
        res.json(usuario);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
