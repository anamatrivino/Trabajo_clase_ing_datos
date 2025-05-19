require('dotenv').config();

const express=require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const cors=require('cors');

const usuarioRoute=require('./routes/usuariosRoutes.js');
const productoRoute=require('./routes/productosRoutes.js');

const app=express();
const PORT=3000;

//Middleware

app.use(bodyParser.json());
app.use(cors());

//Conexión Mongo

mongoose.connect('mongodb://localhost:27017/miapp',{
    useNewUrlParser:true,
    useUnifiedTopology:true,
})

.then(()=>console.log("MongoDB Conectado"))
.catch(err=>console.error(err))


//Rutas

app.use('/api/usuario', usuarioRoute);
app.use('/api/producto', productoRoute);

app.listen(PORT,()=>{
    console.log(`Servidor Conectado en http://localhost:${PORT}`);
});
