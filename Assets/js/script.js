document.addEventListener("DOMContentLoaded", () => {
  const monsters = [
    {
      name: "Rathalos",
      image: "Rathalos.png",
      element: "Fuego",
      weakness: "Draco",
      state: "Plaga de Fuego",
      type: "Wyvern Volador",
      habitat: "Bosque Primigenio",
      sizeMin: 1140.6,
      sizeMax: 2248.6,
      notes: "Ataca con bolas de fuego y garras venenosas."
    },
    {
      name: "Diablos",
      image: "Diablos.png",
      element: "Ninguno",
      weakness: "Hielo",
      state: "Aturdimiento",
      type: "Wyvern Volador",
      habitat: "Yermo de Agujas",
      sizeMin: 1797.0,
      sizeMax: 3030.0,
      notes: "Excava y embiste con fuerza."
    },
    {
      name: "Kirin",
      image: "Kirin.png",
      element: "Rayo",
      weakness: "Fuego",
      state: "Plaga de Rayo",
      type: "Dragón Anciano",
      habitat: "Altiplanos Coralinos",
      sizeMin: 371.4,
      sizeMax: 928.6,
      notes: "Envuelto en electricidad pura."
    },
    {
      name: "Barroth",
      image: "Barroth.png",
      element: "",
      weakness: null,
      state: null,
      type: "",
      habitat: "Yermo de Agujas",
      sizeMin: null,
      sizeMax: 1217.1,
      notes: ""
    }
  ];

  let currentIndex = 0;

  const monsterImage = document.getElementById("monster-image");
  const monsterInfo = document.querySelector(".monster-info");
  const descripcionBox = document.querySelector(".descripcion-box p");

  function getIconHTML(tipo, valor) {
    if (!valor || typeof valor !== "string" || valor.trim() === "") {
      return "[Dato no encontrado]";
    }

    const valorLimpio = valor.trim().toLowerCase();
    const ignorarIcono = ["ninguno", "sin elemento", "sin estado", "no aplica"];

    if (ignorarIcono.includes(valorLimpio)) {
      return valor;
    }

    const folder = tipo === "Estado" ? "Estado_" : "Elemento_";
    const nombreArchivo = `${folder}${valor.replace(/ /g, "_")}.png`;
    const src = `Assets/images/Elements/${nombreArchivo}`;

    return `<img src="${src}" alt="${valor}" class="icono"> ${valor}`;
  }

  function mostrarMonstruo(index) {
    const m = monsters[index];

    monsterImage.src = `Assets/images/Monsters/${m.image || "placeholder.png"}`;
    monsterImage.alt = m.name || "[Dato no encontrado]";

    monsterInfo.innerHTML = `
      <h2 class="card-title">Nombre: ${m.name || "[Dato no encontrado]"}</h2>
      <p><strong>Tipo:</strong> ${m.type || "[Dato no encontrado]"}</p>
      <p><strong>Elemento:</strong> ${getIconHTML("Elemento", m.element)}</p>
      <p><strong>Debilidad:</strong> ${getIconHTML("Elemento", m.weakness)}</p>
      <p><strong>Estado:</strong> ${getIconHTML("Estado", m.state)}</p>
      <p><strong>Hábitat:</strong> ${m.habitat || "[Dato no encontrado]"}</p>
      <p><strong>Tamaño:</strong> ${m.sizeMin ?? "[Dato no encontrado]"} - ${m.sizeMax ?? "[Dato no encontrado]"}</p>
    `;

    descripcionBox.textContent = m.notes && m.notes.trim() !== "" ? m.notes : "[Dato no encontrado]";
  }

  document.querySelectorAll(".btn-side").forEach(btn => {
    btn.addEventListener("click", () => {
      if (btn.textContent.includes("⟵")) {
        currentIndex = (currentIndex - 1 + monsters.length) % monsters.length;
      } else {
        currentIndex = (currentIndex + 1) % monsters.length;
      }
      mostrarMonstruo(currentIndex);
    });
  });

  mostrarMonstruo(currentIndex);
});
