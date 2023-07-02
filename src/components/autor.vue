<script>
import Menu from "./menu.vue"
export default {
    name: 'Autor',    
    components:{
        Menu
    },
    data(){
        return {
            nombreAutor: '',
            idAutor : 0,
            autores:[],
            mostrarFormulario: false,
            textoBoton : "",
            operacion: "",
            tituloCard: "",
            txtBusqId : "",
            txtBusqNom: ""
        }
    },
    methods:{ 
        async obtenerAutores() {

            const response = await fetch('https://localhost:7103/api/biblioteca/Autores');

            const data = await response.json();
                
            this.autores = data.data;            
        },
        cancelar(){
            this.mostrarFormulario = false;  
        },
        mostrarMensaje(titulo, mensaje, icono){
            Swal.fire({
                position: 'top-center',
                icon: icono,
                title: titulo,
                text:mensaje,
                showConfirmButton: false,
                timer: 2000
            });

            
        },
        async crearAutor(){    

            if (!this.nombreAutor) {
                
                this.mostrarMensaje('Error!', 'Ingresar nombre del autor', 'error');
                
                return;
            }

            let response;

            if (this.operacion == "agregar") {
                response = await fetch('https://localhost:7103/api/biblioteca/agregarAutor', 
                {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({nombre:this.nombreAutor})
                });
            }
            else{
                response = await fetch('https://localhost:7103/api/biblioteca/modificarAutor', 
                {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({Nombre:this.nombreAutor, Id: this.idAutor, Estado:1})
                });
            }
        
            const resp = await response.json();            

            if (resp.error != 1) {      
                this.mostrarFormulario = false;
                this.mostrarMensaje('Bien!', resp.mensaje, 'success');
                this.obtenerAutores();
            }
            else{        
                this.mostrarMensaje('Error!', resp.mensaje, 'error');
            }
        },
        editarAutor(idAutor, nombre){
            this.mostrarFormulario = true;
            this.textoBoton = "Editar";
            this.tituloCard = "Edicion de Autor"
            this.operacion = "editar"

            this.nombreAutor = nombre;
            this.idAutor = idAutor;            
        },
        async eliminarAutor(idAutor){
            const response = await fetch('https://localhost:7103/api/biblioteca/modificarAutor', 
            {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({Estado:0, Id:idAutor})
            });

            const resp = await response.json(); 
            
            console.log(resp);

            if (resp.error != 1) {        
                this.mostrarMensaje('Bien!', resp.mensaje, 'success');
                this.obtenerAutores();
            }
            else{        
                this.mostrarMensaje('Error!', resp.mensaje, 'error');
            }
        },
        async buscarAutor(){           
            
            const response = await fetch(`https://localhost:7103/api/biblioteca/buscarAutores?id=${!this.txtBusqId.trim() ? 0 : this.txtBusqId.trim()}&nombre=${this.txtBusqNom.trim()}`);

            const data = await response.json();
                
            this.autores = data.data;
        },
        agregarNuevo(){
            this.mostrarFormulario = true;
            this.textoBoton = "Crear";
            this.operacion = "agregar"
            this.tituloCard = "Agregar un nuevo Autor"
            this.nombreAutor = "";
        },
        borrar(){
            this.txtBusqId = "";
            this.txtBusqNom = "";
            this.obtenerAutores();
        }        
    },    
    async mounted()
    {        
        this.obtenerAutores();
    }
}

</script>

<template>
<Menu />
    <div class="card text-bg-dark my-3">
        <div class="card-header text-center">
            <h5 class="card-title">Administración de Autores</h5>
        </div>
        <div class="card-body">
            
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="col-md-12 mb-3">
                        <div class="row">
                            <div class="col-md-2 mb-2">                            
                            <input type="text" class="form-control" id="txtBusqId" required v-model="txtBusqId" placeholder="id">                                       
                            </div>  
                            <div class="col-md-3 mb-2">
                                <input type="text" class="form-control" id="txtBusqNom" required v-model="txtBusqNom" placeholder="Nombre"> 
                            </div>
                            <div class="col-md-4">
                                <button  class="btn btn-primary mx-2" @click.prevent="buscarAutor">Buscar</button> 
                                <button  class="btn btn-primary " @click.prevent="borrar">Borrar</button>                                             
                            </div>                            
                        </div>
                    </div>

                    <div class="mia col-md-12">
                        <table class="table  table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">Id</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Fecha Creación</th>  
                                    <th class="text-center">Acción</th> 
                                </tr>
                            </thead>
                            <tbody class="">               
                                <tr v-for="item in autores" :key="item.id"> 
                                    <td>{{ item.id }}</td>
                                    <td>{{ item.nombre }}</td>
                                    <td>{{ item.fecCreacion }}</td>                    
                                    <td class="text-center">
                                        <button @click="editarAutor(item.id, item.nombre)" class="btn btn-sm btn-outline-success mx-2">Editar</button>
                                        <button @click="eliminarAutor(item.id)" class="btn btn-sm btn-outline-danger  ">Eliminar</button>
                                    </td>
                                </tr>            
                            </tbody>
                        </table>  
                    </div> 
                    <div class="col-md-12 text-center">
                        <button @click="agregarNuevo" class="btn btn-sm btn-success my-3">Agregar nuevo</button>  
                    </div> 
                            
                </div>
            </div>

            <div class="row">
                <div class="col-md-8 offset-md-2"  v-if="mostrarFormulario">

                    <div class="card">
                        <div class="card-header">
                            {{ tituloCard }}
                        </div>
                        <div class="card-body">
                            <form class="row g-3">
                                <div class="col-md-12">
                                    <label for="txtNombre" class="form-label">Nombre (*)</label>
                                    <input type="text" class="form-control" id="txtNombre" required v-model="nombreAutor" placeholder="Nombre">            
                                </div>  
                                <div class="col-md-12 text-center">
                                    <button  class="btn btn-success mx-2" @click.prevent="crearAutor">{{textoBoton}}</button>
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
<style scoped>
.mia {
  height: 300px;
  overflow: scroll;
}
</style>