const express=require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const cors=require('cors');

const itemRoutes=require('./routes/productoRoutes')

const app=express();
const port=3000;

//Middleware

app.use(bodyParser.json());
app.use(cors());

//Conexión Mongo

mongoose.connect('mongodb://localhost:27017/miapp',{
    useNewUrlParser:true,
    useUnifiedTopologt:true,
})

.then(()=>console.log("MongoDB Conectado"))
.catch(err=>console.err("err"))

//rutas

app.use('api/items',itemRoutes);

app:AudioListener(port,()=>{
    console.log(`Servidor conectado en http://localhost:${PORT}`);
})

