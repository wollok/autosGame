import wollok.game.*

/** First Wollok example */
object personaje {
	
	var puntos = 0
	var property position = game.center()
	
	method image() = "personaje.png"

	method avanzar() {
		position = position.up(1)
	}
	method sumarPuntos(cantidad){
		puntos = puntos + cantidad
	}
	
	method retroceder() {
		position = position.down(1)
	}
	
	method derecha() {
		position = position.right(1)
	}
	
	method izquierda() {
		position = position.left(1)	
	}
	
	method puntos() = puntos
}

class Auto {
	
	var property position 
	var nro 
	
	method image() = "auto" +  nro + ".png"

	method serAgarradaPor(personaje){
		game.removeVisual(self)
		personaje.sumarPuntos(nro)
	}	
}


object juego {
	method iniciar() {

		game.height(12)
		game.width(20)
		game.title("juego")
		
		self.agregarVisuales()
		self.configurarTeclas()
		self.definirColisiones()

	}
	method agregarVisuales() {
		game.addVisual(personaje)
		
		10.times({x=>self.agregarAuto(x)})
		
		game.addVisual(puntaje)
	}
	method configurarTeclas() {
		keyboard.up().onPressDo{ personaje.avanzar()}
		keyboard.down().onPressDo{ personaje.retroceder()}
		keyboard.left().onPressDo{ personaje.izquierda()}
		keyboard.right().onPressDo{ personaje.derecha()}
		 
	}
	method definirColisiones() {
		
		game.onCollideDo(personaje,{cosa=>cosa.serAgarradaPor(personaje)})
		
	}
	method agregarAuto(valor) {
		game.addVisual( new Auto( position =game.at(valor,10)  ,nro = valor % 5 + 1)) 
	}
}

object puntaje {
	
	method position() = game.at(game.width()-1,game.height()-1)
	
	method text() = personaje.puntos().toString()
	
	method serAgarradaPor(personaje){}
}
