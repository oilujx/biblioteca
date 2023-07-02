<script>
    import Menu from "./menu.vue"
    export default {
    name: 'Autor',
    components:{
        Menu
    },
    data(){
        return {
            libros:[],
            libro:{
                isbn:0,
                titulo:"",
                idEditorial:0,
                idAutor:0,
                anioEdicion:"",
                precioPrestamo: 0 ,
                estado : 1               
            },
            autores:[],
            editoriales:[],
            mostrarFormulario: false,
            textoBoton : "",
            operacion: "",
            tituloCard: "",
            txtBusqIsbn : "",
            txtBusqTit: "",
            cmbBusqAut: 0
        }
    },
    methods:{ 
        mostrarMensaje(titulo, mensaje, icono){
            Swal.fire({
                position: 'center',
                icon: icono,
                title: titulo,
                text:mensaje,
                showConfirmButton: false,
                timer: 2000
            });
        },
        async obtenerLibros() {

            const response = await fetch('https://localhost:7103/api/biblioteca/Libros');

            const data = await response.json();
                
            this.libros = data.data;            
        },
        async obtenerAutores() {

            const response = await fetch('https://localhost:7103/api/biblioteca/Autores');

            const data = await response.json();
                
            this.autores = data.data; 
            this.libro.idAutor = 0;           
        },
        async obtenerEditoriales() {

            const response = await fetch('https://localhost:7103/api/biblioteca/Editoriales');

            const data = await response.json();

            this.editoriales = data.data; 
            this.libro.idEditorial = 0;           
        },
        agregarNuevo() {
            this.mostrarFormulario = true;
            this.textoBoton = "Crear";
            this.operacion = "agregar"
            this.tituloCard = "Agregar un nuevo Libro"
            
            this.libro.isbn = 0;
            this.libro.titulo = "";
            this.libro.idEditorial = 0;
            this.libro.idAutor = 0;
            this.libro.anioEdicion = "";
            this.libro.precioPrestamo = "";
        },
        async editarLibro(isbn, titulo, idEditorial, anioEdicion, idAutor,  precioPrestamo) {

            this.mostrarFormulario = true;
            this.textoBoton = "Editar";
            this.tituloCard = "Edición de Libro"
            this.operacion = "editar"

            this.libro.estado = 1;
            this.libro.isbn = isbn;
            this.libro.titulo = titulo;
            this.libro.idEditorial = idEditorial;
            this.libro.idAutor = idAutor;            
            this.libro.anioEdicion = anioEdicion;
            this.libro.precioPrestamo = precioPrestamo;            
        },
        async eliminarLibro(isbn, titulo, idEditorial, anioEdicion, idAutor,  precioPrestamo){

            this.operacion = "eliminar"
            this.libro.estado = 0;
            this.libro.isbn = isbn;
            this.libro.titulo = titulo;
            this.libro.idEditorial = idEditorial;
            this.libro.idAutor = idAutor;            
            this.libro.anioEdicion = anioEdicion;
            this.libro.precioPrestamo = precioPrestamo;   

            this.crearLibro();

        },
        async crearLibro(){    
            
            //validaciones solamente cuando no se necesita eliminar el libro.
            if (this.operacion != 'eliminar') {
                if (!this.libro.titulo || !this.libro.anioEdicion || !this.libro.precioPrestamo) {
                
                    this.mostrarMensaje('Error!', 'Ingresar los campos obligatorios marcados con *', 'error');
                    
                    return;
                }

                if( isNaN(this.libro.anioEdicion)  || isNaN(this.libro.precioPrestamo) )
                {
                    this.mostrarMensaje('Error!', 'Valor del año o del precio incorrectos.', 'error');
                    
                    return;
                }

                if (this.libro.idAutor == 0 || this.libro.idEditorial == 0) {
                    this.mostrarMensaje('Error!', 'Debe seleccionar un Autor y una Editorial', 'error');
                    
                    return;
                }    
            }
                    

            let response;

            if (this.operacion == "agregar") {
                response = await fetch('https://localhost:7103/api/biblioteca/agregarLibro', 
                {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(this.libro)
                });
            }
            else{
                response = await fetch('https://localhost:7103/api/biblioteca/modificarLibro', 
                {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(this.libro)
                });
            }
        
            const resp = await response.json();            

            if (resp.error != 1) {      
                this.mostrarFormulario = false;
                this.mostrarMensaje('Bien!', resp.mensaje, 'success');
                this.obtenerLibros();
            }
            else{        
                this.mostrarMensaje('Error!', resp.mensaje, 'error');
            }
        },
        cancelar(){
            this.mostrarFormulario = false;  
        },
        async buscarLibro(){           
            
            const response = await fetch(`https://localhost:7103/api/biblioteca/buscarLibros?id=${!this.txtBusqIsbn.trim() ? 0 : this.txtBusqIsbn.trim()}&titulo=${this.txtBusqTit.trim()}&idAutor=${this.cmbBusqAut}`);

            const data = await response.json();
                
            this.libros = data.data;           
        },
        borrar(){
            this.txtBusqIsbn = "";
            this.txtBusqTit = "";
            this.obtenerLibros();
        }   
    },
    async mounted()
    {        
        this.obtenerLibros();
        this.obtenerAutores();
        this.obtenerEditoriales();
    }
}

</script>
<template>
    <Menu />
     <div class="card text-bg-dark my-3">
        <div class="card-header text-center">
            <h5 class="card-title">Administración de libros</h5>
        </div>
        <div class="card-body">
            
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-12 mb-3">
                        <div class="row">
                            <div class="col-md-2 mb-2">                            
                            <input type="text" class="form-control" id="txtBusqIsbn" required v-model="txtBusqIsbn" placeholder="isbn">                                       
                            </div>  
                            <div class="col-md-3 mb-2">
                                <input type="text" class="form-control" id="txtBusqTit" required v-model="txtBusqTit" placeholder="Título"> 
                            </div>                             
                            <div class="col-md-2 mb-2">                                    
                                    <select class="form-select" id="cmbBusqAut" v-model="cmbBusqAut">
                                        <option selected value="0">Autor</option>
                                        <option v-for="autor in autores" :key="autor.id" :value="autor.id">
                                            {{ autor.nombre }}
                                        </option>
                                    </select>
                                </div>                           
                            <div class="col-md-4">
                                <button  class="btn btn-primary mx-2" @click.prevent="buscarLibro">Buscar</button> 
                                <button  class="btn btn-primary " @click.prevent="borrar">Borrar</button>                                             
                            </div>                            
                        </div>
                    </div>

                    <div class="mia col-md-12">
                        <table class="table  table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">ISBN</th>
                                    <th scope="col">Título</th>
                                    <th class="d-none">idEditorial</th>
                                    <th scope="col">Editorial</th>  
                                    <th class="text-center">Año Edición</th> 
                                    <th class="d-none">idAutor</th>
                                    <th class="text-center">Autor</th> 
                                    <th class="text-center">Precio Prestamo</th> 
                                    <th class="text-center">Acción</th> 
                                    
                                </tr>
                            </thead>
                            <tbody class="">               
                                <tr v-for="item in libros" :key="item.isbn"> 
                                    <td>{{ item.isbn }}</td>
                                    <td>{{ item.titulo }}</td>
                                    <td class="d-none">{{ item.idEditorial }}</td>
                                    <td>{{ item.editorial }}</td> 
                                    <td>{{ item.anioEdicion }}</td>
                                    <td class="d-none">{{ item.idAutor }}</td>
                                    <td>{{ item.autor }}</td>
                                    <td>{{ item.precioPrestamo }}</td>                  
                                    <td class="text-center">
                                        <button @click="editarLibro(item.isbn, item.titulo, item.idEditorial, item.anioEdicion, item.idAutor, item.precioPrestamo)" class="btn btn-sm btn-outline-success mx-2">Editar</button>
                                        <button @click="eliminarLibro(item.isbn, item.titulo, item.idEditorial, item.anioEdicion, item.idAutor, item.precioPrestamo)" class="btn btn-sm btn-outline-danger  ">Eliminar</button>
                                    </td>
                                </tr>            
                            </tbody>
                        </table>  
                    </div> 
                    <div class="col-md-12 text-center">
                        <button @click="agregarNuevo" class="btn btn-sm btn-success my-3">Agregar Libro</button>  
                    </div> 
                            
                </div>
            </div>

            <div class="row">
                <div class="col-md-12"  v-if="mostrarFormulario">

                    <div class="card">
                        <div class="card-header">
                            {{ tituloCard }}
                        </div>                        
                        <div class="card-body">
                            <form class="row g-3">
                                <div class="col-md-4">
                                    <label for="txtTitulo" class="form-label">Título (*)</label>
                                    <input type="text" class="form-control" id="txtTitulo" required v-model="libro.titulo" placeholder="Titulo">            
                                </div>  
                                <div class="col-md-2">
                                    <label for="txtAnio" class="form-label">Año Edición (*)</label>
                                    <input type="text"  class="form-control" id="txtAnio" required v-model="libro.anioEdicion" placeholder="Año">            
                                </div>
                                <div class="col-md-2">
                                    <label for="txtPrecio" class="form-label">Precio Prestamo (*)</label>
                                    <input type="text" class="form-control" id="txtPrecio" required v-model="libro.precioPrestamo" placeholder="Precio">            
                                </div>
                                <div class="col-md-2">
                                    <label for="cmbEditorial" class="form-label">Editorial</label>
                                    <select class="form-select" id="cmbEditorial" v-model="libro.idEditorial">
                                        <option selected value="0">Selecciona</option>
                                        <option v-for="editorial in editoriales" :key="editorial.id" :value="editorial.id">
                                            {{ editorial.nombre }}
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="cmbAutor" class="form-label">Autor</label>
                                    <select class="form-select" id="cmbAutor" v-model="libro.idAutor">
                                        <option selected value="0">Selecciona</option>
                                        <option v-for="autor in autores" :key="autor.id" :value="autor.id">
                                            {{ autor.nombre }}
                                        </option>
                                    </select>
                                </div>                                
                                <div class="col-md-12 text-center">
                                    <button  class="btn btn-success mx-2" @click.prevent="crearLibro">{{textoBoton}}</button>
                                    <input class="btn btn-danger" @click="cancelar" type="button" value="Cancelar" />                 
                                </div>      
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>