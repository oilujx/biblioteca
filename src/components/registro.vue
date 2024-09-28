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
            textoBoton : "Registrar",            
            tituloCard: "Ingrese los siguientes datos para registrar el código único de la compra realizada"           
        }
    },
    methods:{        
        
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

            response = await fetch('https://localhost:7103/api/biblioteca/agregarAutor', 
            {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({nombre:this.nombreAutor})
            });           
        
            const resp = await response.json();            

            if (resp.error != 1) {                      
                this.mostrarMensaje('Bien!', resp.mensaje, 'success');               
            }
            else{        
                this.mostrarMensaje('Error!', resp.mensaje, 'error');
            }
        }
    },    
    async mounted()
    {        
        //this.obtenerAutores();
    }
}

</script>

<template>
<Menu />
    <div class="card text-bg-dark my-3">
        <div class="card-header text-center">
            <h5 class="card-title">Registro de códigos FIDO</h5>
        </div>
        <div class="card-body">

            <div class="row">
                
                <div class="col-md-8 offset-md-2">

                    <div class="card">
                        <div class="card-header">
                            {{ tituloCard }}
                        </div>
                        <div class="card-body">
                            <form class="row g-3">
                                <div class="col-md-6">
                                    <label for="txtNombre" class="form-label">Nombre (*)</label>
                                    <input type="text" class="form-control" id="txtNombre" required v-model="nombreAutor" >            
                                </div> 
                                <div class="col-md-6">
                                    <label for="txtCorreo" class="form-label">Correo (*)</label>
                                    <input type="text" class="form-control" id="txtCorreo" required v-model="nombreAutor">            
                                </div>  
                                <div class="col-md-4">
                                    <label for="txtTelefono" class="form-label">Teléfono (*)</label>
                                    <input type="text" class="form-control" id="txtTelefono" required v-model="nombreAutor">            
                                </div> 
                                <div class="col-md-4">
                                    <label for="txtRaza" class="form-label">Raza del perro (*)</label>
                                    <input type="text" class="form-control" id="txtRaza" required v-model="nombreAutor">            
                                </div>
                                <div class="col-md-4">
                                    <label for="txtCodigo" class="form-label">Código (*)</label>
                                    <input type="text" class="form-control" id="txtCodigo" required v-model="nombreAutor">            
                                </div>     
                                <div class="col-md-12 text-center">
                                    <button  class="btn btn-success mx-2" @click.prevent="crearAutor">{{textoBoton}}</button>                                                     
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