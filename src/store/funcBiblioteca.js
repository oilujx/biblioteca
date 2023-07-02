import { reactive } from "vue";

export const store = reactive   ({
    autor:{
        nombre:""
    }
});

export async function obtenerAutores() {

    const response = await fetch('https://localhost:7103/api/biblioteca/Autores');
    
    const data = await response.json();
        
    return data;
}

export async function crearAutor() {

    const response = await fetch('https://localhost:7103/api/biblioteca/Autores');
    
    const data = await response.json();
        
    return data;
}