<script>
export default {
    name: 'Inicio',
    methods:{
        accederAutores(){
            this.$router.push({name:'Autor'});
        },
        accederLibros(){
            this.$router.push({name:'Libro'});
        }
    }
}
</script>
<template>

    <div class="row">
        <div class="col-md-6 my-2">
        <div class="card text-bg-dark " >
            <div class="card-header"></div>
            <div class="card-body text-center">
                <h2 class="card-title">Administración de Autores</h2>
                <p class="card-text">En esta opción puedes administrar los autores del sistema.</p>
                <div class="col-md-12 text-center">
                    <button @click="accederAutores" class="btn btn-primary my-3">Acceder</button>  
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card text-bg-dark my-2" >
            <div class="card-header"></div>
            <div class="card-body text-center">
                <h2 class="card-title">Administración de Libros</h2>
                <p class="card-text">En esta opción puedes administrar los Libros del sistema.</p>
                <div class="col-md-12 text-center">
                    <button @click="accederLibros" class="btn btn-primary my-3">Acceder</button>  
                </div>
            </div>
        </div>
    </div>

    </div>

    

</template>