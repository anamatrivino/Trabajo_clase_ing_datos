const express = require('express');
const router = express.Router();
const Productos = require('../models/productos');

// Registrar un producto
router.post('/', async (req, res) => {
    try {
        const prd = new Productos(req.body);
        await prd.save();
        res.status(201).json(prd);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

// Consultar todos los productos
router.get('/', async (req, res) => {
    try {
        const productos = await Productos.find();
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Consultar productos por ID
router.get('/:id', async (req, res) => {
    try {
        const productos = await Productos.findById(req.params.id);
        if (!productos) return res.status(404).json({ error: "producto no encontrado" });
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Consultar productos mayores a un precio
router.get('/mayores/:precio', async (req, res) => {
    try {
        const precioMinima = parseInt(req.params.precio);
        if (isNaN(precioMinima)) {
            return res.status(400).json({ error: "Producto no encontrado" });
        }

        const productos = await Productos.find({ precio: { $gt: precioMinima } });
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Ordenar los productos de manera descendente
router.get('/ordenar/desc', async (req, res) => {
    try {
        const productos = await Productos.find().sort({ precio: -1 });
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Agregar un campo de stock con valor true a todos los productos.
router.patch('/stock', async (req, res) => {
    try {
        const resultado = await Productos.updateMany({}, { $set: { stock: true } });
        res.json(resultado);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


//Eliminar los productos cuyo precio sea menor a 50000
router.delete('/50000', async (req, res) => {
    try {
        const resultado = await Productos.deleteMany({ precio: { $lt: 50000 } });
        res.json(resultado);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Realizar una agregación para consultar la categoría con el mayor precio promedio
router.get('/categoriaMayorPromedio/', async (req, res) => {
    try {
        const resultado = await Productos.aggregate([
            {
                $group: {
                    _id: "$categoria",
                    promedioPrecio: { $avg: "$precio" }
                }
            },
            { $sort: { promedioPrecio: -1 } },
            { $limit: 1 }
        ]);
        res.json(resultado);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Encontrar el número total de productos por categoría
router.get('/total', async (req, res) => {
    try {
        const resultado = await Productos.aggregate([
            {
                $group: {
                    _id: "$categoria",
                    total: { $sum: 1 }
                }
            }
        ]);
        res.json(resultado);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


//Implementar un sistema de búsqueda en la colección productos que permite 
//encontrar productos cuyo nombre contenga una palabra clave
router.get('/buscar', async (req, res) => {
    try {
        const palabra = req.query.q;
        if (!palabra) {
            return res.status(400).json({ error: "Debe proporcionar un parámetro de búsqueda (?q=...)" });
        }

        const resultado = await Productos.find({
            nombre: { $regex: palabra, $options: 'i' }
        });

        res.json(resultado);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


module.exports = router;
