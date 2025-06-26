const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');

const app = express();
const port = 3000;

app.use(cors());
app.use('/Assets', express.static(path.join(__dirname, '..', 'Assets')));
// Configuración de conexión MySQL
const conexion = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Pl5083',
  database: 'MonsterHunter' // Reemplaza esto
});

conexion.connect(err => {
  if (err) {
    console.error('Error de conexión a MySQL:', err);
    return;
  }
  console.log('Conexión a MySQL exitosa');
});

// Ruta para obtener datos
app.get('/api/monstruos', (req, res) => {
  const consulta = `
    SELECT 
      m.ID_MONSTER,
      m.Name AS Nombre,
      m.Description AS Descripcion,
      m.Habitat,
      m.Notes,
      m.MaxSize,
      m.MinSize,
      e.Name AS Elemento,
      s.Name AS Estado,
      w.Name AS Debilidad,
      m.Name AS Clase
    FROM Monster m
    LEFT JOIN Element e ON m.ID_ELEMENT = e.ID_ELEMENT
    LEFT JOIN State s ON m.ID_STATE = s.ID_STATE
    LEFT JOIN Weakness w ON m.ID_WEAKNESS = w.ID_WEAKNESS
    LEFT JOIN MonsterClass c ON m.ID_CLASS = c.ID_CLASS
  `;

  conexion.query(consulta, (err, resultados) => {
    if (err) {
      console.error('Error en la consulta:', err);
      res.status(500).send('Error al consultar la base de datos');
      return;
    }
    res.json(resultados);
  });
});

app.get('/api/clases', (req, res) => {
  const consulta = 'SELECT Name FROM MonsterClass';
  conexion.query(consulta, (err, resultados) => {
    if (err) {
      console.error('Error al obtener clases:', err);
      res.status(500).send('Error al obtener clases');
      return;
    }
    res.json(resultados.map(row => row.Name));
      });
});


app.get('/api/elementos', (req, res) => {
  const consulta = 'SELECT Name FROM Element';
  conexion.query(consulta, (err, resultados) => {
    if (err) {
      console.error('Error al obtener elementos:', err);
      res.status(500).send('Error al obtener elementos');
      return;
    }
    res.json(resultados.map(row => row.Name));
  });
});

// Ruta para servir el index.html
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '..' , 'index.html'));
});

app.listen(port, () => {
  console.log(`Servidor Express en http://localhost:${port}`);
});
