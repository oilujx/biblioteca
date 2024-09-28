import Home from './components/inicio.vue'
import Autor from './components/autor.vue'
import Libro from './components/libro.vue'
import Registro from './components/registro.vue'
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
    {
        name: 'Home',
        component: Home,
        path: '/'
    },
    {
        name: 'Autor',
        component: Autor,
        path: '/autores'
    },
    {
        name: 'Libro',
        component: Libro,
        path: '/libros'
    },
    {
        name: 'Registro',
        component: Registro,
        path: '/registro'
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router