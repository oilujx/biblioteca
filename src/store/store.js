import { reactive } from "vue";

export const store = reactive   ({
    autor:{
        nombre:""
    },
    autores:[]
});

export async function obtenerAutores() {

    const response = await fetch('https://localhost:7103/api/biblioteca/Autores');
    
    const data = await response.json();
        
    return data;
}

export async function crearAutor(nuevoAutor) {

    const response = await fetch('https://localhost:7103/api/biblioteca/agregarAutor', 
    {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({nombre:store.autor.nombre})
      })
        
    return await response.json();
}