import wollok.vm.*
import cosas.*

object camion {
    const carga = []

    method cargar(unaCosa) {
      carga.add(unaCosa)
      unaCosa.consecuenciaDeLaCarga()
    }

    method descargar(unaCosa) {
      carga.remove(unaCosa)
    }
    method pesoTotal() = 1000 + carga.sum({c => c.peso()})
    method todoPesoPar() = carga.all({c => c.esPesoPar()})
    method algunaCosaPesa(unValor) = carga.any({c => c.peso() == unValor})
    method primerCosaConPeligrosidad(unValor) {
        return carga.find({c => c.peligrosidad() == unValor}) 
    }
    method todasLasCosasConMasPeligrosidad(unValor) {
        return carga.filter({c => c.peligrosidad() > unValor})
    }
    method todasLasCosasConMasPeligrosidadDe(unaCosa) {
        return carga.filter({c => c.peligrosidad() > unaCosa.peligrosidad()})
    }
    method excedePesoMaximo() = self.pesoTotal() > 2500
    method puedeCircular(nivelMaximo) {
        return not self.excedePesoMaximo()
        and self.todasLasCosasConMasPeligrosidad(nivelMaximo).isEmpty()
    }
    method algunaCosaPesaEntre(valorMinimo, valorMaximo) {
        return carga.any({c => c.peso().between(valorMinimo, valorMaximo)})
    }
    method laCosaMasPesada() {
      return carga.max({c => c.peso()})
    }
}