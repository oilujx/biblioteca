<script>
    export default {
        name: 'Menu'
    }
</script>

<template>
    <nav class="navbar bg-dark navbar-expand-lg my-1" data-bs-theme="dark">
        <div class="container-fluid">
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                <router-link  class="nav-link" to="/">Inicio</router-link>
                </li>
                <li class="nav-item">
                <router-link  class="nav-link" to="/Autores">Autores</router-link >
                </li>
                <li class="nav-item">
                <router-link  class="nav-link" to="/Libros">Libros</router-link>
                </li>                
            </ul>
            
            </div>
        </div>
    </nav>
</template>