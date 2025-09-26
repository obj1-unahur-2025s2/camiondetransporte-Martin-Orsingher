object knightRider {
    method peso() = 500
    method peligrosidad() = 10
    method esPesoPar() = self.peso().even()
    method bultos() = 1
    method consecuenciaDeLaCarga() {}
}

object bumblebee {
    var esAuto = true
    method peso() = 800

    method transformarEnAuto() {
        esAuto = true
    }
    method transformarEnRobot() {
        esAuto = false
    }
    method peligrosidad() = if(esAuto) 15 else 30
    method esPesoPar() = self.peso().even()
    method bultos() = 2
    method consecuenciaDeLaCarga() {
        self.transformarEnRobot()
    }
}


object paqueteDeLadrillos {
    var cantidad = 0
    method cantidad(nuevaCantidad) {
      cantidad = nuevaCantidad.max(0)
    }
    method peso() = 2 * cantidad
    method peligrosidad() = 2 
    method esPesoPar() = self.peso().even()
    method bultos() {
        return
        if(cantidad<=100) {1}
        else if(cantidad.between(101, 300)) {2}
        else {3}    
    }
    method consecuenciaDeLaCarga(){
        cantidad = cantidad + 12
    }
}

object arena {
    var property peso = 0
    /*  Property es lo mismo que hacer:
    method peso(nuevoPeso) {
      peso = nuevoPeso
    }
    method peso() { return peso}
    */

    method peligrosidad() = 1
    method esPesoPar() = self.peso().even()
    method bultos() = 1
    method consecuenciaDeLaCarga() {
        peso = (peso - 10).max(0)
    }
}

object bateriaAntiaerea {
    var tieneMisiles = false

    method cargarMisiles() {
      tieneMisiles = true
    }

    method descargarMisiles() {
      tieneMisiles = false
    }

    method peso() = if(tieneMisiles) 300 else 200
    method peligrosidad() = if(tieneMisiles) 100 else 0
    method esPesoPar() = self.peso().even()
    method bultos() {
        return if(tieneMisiles) {2}
        else {1}
    }
    method consecuenciaDeLaCarga(){
        self.cargarMisiles()
    }
}

object contenedor {
    const cosasAdentro = []

    method agregar(unaCosa) {
        cosasAdentro.add(unaCosa)
    }

    method agregarVariasCosas(variasCosas) {
        cosasAdentro.addAll(variasCosas)
    }

    method quitarCosa(unaCosa) {
        cosasAdentro.remove(unaCosa)
    }

    method peso() = 100 + cosasAdentro.sum({c => c.peso()})

    method peligrosidad() = 
    if(cosasAdentro.isEmpty()) 0 else cosasAdentro.max({c => c.peligrosidad()}).peligrosidad()
    method esPesoPar() = self.peso().even()
    method bultos() = 1 + cosasAdentro.sum({c => c.bultos()})
    method consecuenciaDeLaCarga() {
        if(not cosasAdentro.isEmpty()) {
            cosasAdentro.forEach({c => c.consecuenciaDeLaCarga()})
        }
    }
}

object residuos {
    var property peso = 0
    method peligrosidad() = 200
    method esPesoPar() = self.peso().even()
    method bultos() = 1
    method consecuenciaDeLaCarga() {
        peso = peso + 15
    }
}

object embalaje {
    var cosaEnvuelta = residuos 
    
    method envolverUnaCosa(unaCosa) {
        cosaEnvuelta = unaCosa
    }

    method peso() = cosaEnvuelta.peso()
    method peligrosidad() = cosaEnvuelta.peligrosidad() / 2
    method esPesoPar() = self.peso().even()
    method bultos() = 2
    method consecuenciaDeLaCarga() {}
}
