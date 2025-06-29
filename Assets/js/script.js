  const monsterImage = document.getElementById("monster-image");
  const monsterInfo = document.querySelector(".monster-info");
  const descripcionBox = document.querySelector(".descripcion-box p");
  const monsterElement= document.querySelector(".elemento p");

  let monsters = [];
  let currentIndex = 0;

document.addEventListener("DOMContentLoaded", () => {

// Esta función compara los elementos o estados mostrados y busca las imaganes para mostrarlas
  function getIconHTML(tipo, valor) {
    if (!valor || typeof valor !== "string" || valor.trim() === "") {
      return "[Dato no encontrado]";
    }
    const valorLimpio = valor.trim().toLowerCase();
    const ignorarIcono = ["ninguno", "sin elemento", "sin estado", "no aplica"];
    if (ignorarIcono.includes(valorLimpio)) return valor;

    const folder = tipo === "Estado" ? "Estado_" : "Elemento_";
    const nombreArchivo = `${folder}${valor.replace(/ /g, "_")}.png`;
    const src = `Assets/images/Elements/${nombreArchivo}`;
    return `<img src="${src}" alt="${valor}" class="icono"> ${valor}`;
  }

// Esta función busca al monstruo por su ID y devuelve los datos encontrados
async function mostrarMonstruo(monstruo) {
  console.log(monstruo.Nombre);

  const monsterImage = document.getElementById("monster-image");
  const monsterInfo = document.querySelector(".monster-info");
  const descripcionBox = document.querySelector(".descripcion-box p");
  const monsterElement= document.querySelector(".elemento p");

  monsterImage.src = `Assets/images/Monsters/${monstruo.image || "Rathalos.png"}`;
  monsterImage.alt = monstruo.Nombre || "[Dato no encontrado]";

  let template = `
    <h2 class="card-title">Nombre: ${monstruo.Nombre || "[Dato no encontrado]"}</h2>
    <p><strong>Descripción:</strong> ${monstruo.Descripcion || "[Dato no encontrado]"}</p>
    <p><strong>Hábitat:</strong> ${monstruo.Habitat || "[Dato no encontrado]"}</p>
    <p><strong>Elemento:</strong> ${monstruo.Elemento|| "[Dato no encontrado]"}</p>
    <p><strong>MaxSize:</strong> ${monstruo.MaxSize|| "[Dato no encontrado]"}</p>
    <p><strong>MinSize:</strong> ${monstruo.MinSize|| "[Dato no encontrado]"}</p>

  `;

  descripcionBox.textContent = monstruo.Notes || "[Dato no encontrado]";
  monsterInfo.innerHTML = template;
}

// Esta función carga los monstruos desde el servidor de la base de datos
  function cargarMonstruosDesdeAPI() {
    fetch("http://localhost:3000/api/monstruos")
      .then(res => res.json())
      .then(data => {
        monsters = data;
        currentIndex = 0;
        mostrarMonstruo(currentIndex);
      })
      .catch(err => {
        console.error("Error al cargar monstruos desde la API:", err);
      });
  }
// Esta función busca al monstruo correspondiente a la id buscada
  async function SearchMonster(inputId) {
    const nombre = document.getElementById(inputId).value.trim().toLowerCase();
    if (!nombre) return;

    fetch(`http://localhost:3000/api/monstruos?nombre=${encodeURIComponent(nombre)}`)
      .then(res => res.json())
      .then(data => {
        if (!data.length) {
          alert("Monstruo no encontrado.");
          return;
        }
        monsters = data; // Reemplaza lista con resultados
        currentIndex = 0;
        mostrarMonstruo(monsters[currentIndex]);
      })
      .catch(err => {
        console.error("Error al buscar monstruo:", err);
      });
  }

  // Esta función le suma o resta 1 a la variable para buscar el monstruo perteneciente a ese numero
  document.querySelectorAll(".btn-side").forEach(btn => {
    btn.addEventListener("click", () => {
      if (monsters.length === 0) return;
      currentIndex = btn.textContent.includes("⟵")
        ? (currentIndex - 1 + monsters.length) % monsters.length
        : (currentIndex + 1) % monsters.length;
      mostrarMonstruo(monsters[currentIndex]);
    });
  });

  // Carga inicial
  cargarMonstruosDesdeAPI();
  
  // Hacer buscador accesible globalmente
  window.SearchMonster = SearchMonster;
});