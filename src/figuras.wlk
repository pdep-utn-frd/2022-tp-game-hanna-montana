import wollok.game.*
import tetris.*

//----------FIGURAS----------//
//A la hora de definir los movimientos de cada pieza hay que tener en cuenta las posiciones relativas a las otras piezas
//para no mover una pieza encima de otra y disparar una colisión.

class Figura{
	method rotarDerechaDesde(posicion){
		if (posicion == 0){
			self.rotarDerechaDesde0()
		}
		if (posicion == 1){
			self.rotarDerechaDesde1()
		}
		if (posicion == 2){
			self.rotarDerechaDesde2()
		}
		if (posicion == 3){
			self.rotarDerechaDesde3()
		}
		colisiones.hayColisionSuperiorInferior()
	}
	
	method crearFiguraFija(){
		game.addVisual(new Pieza(position = pieza1.position().left(1), image = "src/assets/img/" + piezaActual.figura().toString() + ".png"))
		game.addVisual(new Pieza(position = pieza2.position().left(1), image = "src/assets/img/" + piezaActual.figura().toString() + ".png"))
		game.addVisual(new Pieza(position = pieza3.position().left(1), image = "src/assets/img/" + piezaActual.figura().toString() + ".png"))
		game.addVisual(new Pieza(position = pieza4.position().left(1), image = "src/assets/img/" + piezaActual.figura().toString() + ".png"))
	}
	
	method rotarDerechaDesde0(){}
	method rotarDerechaDesde1(){}
	method rotarDerechaDesde2(){}
	method rotarDerechaDesde3(){}
}

object movimientosFiguras{
	method moverDerecha(n){
		pieza4.position(pieza4.position().right(n))
		pieza3.position(pieza3.position().right(n))
		pieza2.position(pieza2.position().right(n))
		pieza1.position(pieza1.position().right(n))
	}
	
	method subir(n){
		pieza1.position(pieza1.position().up(n))
		pieza2.position(pieza2.position().up(n))
		pieza3.position(pieza3.position().up(n))
		pieza4.position(pieza4.position().up(n))
		colisiones.cambiarUltimoMovimiento(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(n){
		pieza4.position(pieza4.position().down(n))
		pieza3.position(pieza3.position().down(n))
		pieza2.position(pieza2.position().down(n))
		pieza1.position(pieza1.position().down(n))
		colisiones.cambiarUltimoMovimiento(pieza1, pieza2, pieza3, pieza4)
	}
}

object cuadrado inherits Figura{															// 1 - 2
	method iniciarPieza(){																	// 3 - 4
		pieza1.position(posicionInicialPieza.left(1).up(1))
		pieza2.position(posicionInicialPieza.up(1))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	// No hacemos nada ya que no tiene sentido rotar el cuadrado
	override method rotarDerechaDesde(posicion){
		
	}
}

object i inherits Figura{																	//1 - 2 - 3 - 4
	method iniciarPieza(){
		pieza1.position(posicionInicialPieza.left(3))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	override method rotarDerechaDesde0(){
		pieza1.position(pieza1.position().right(2).up(2))
		pieza2.position(pieza2.position().right(1).up(1))
		pieza4.position(pieza4.position().left(1).down(1))
		piezaActual.rotacion(1)
	}
	
	override method rotarDerechaDesde1(){
		pieza1.position(pieza1.position().left(2).down(2))
		pieza2.position(pieza2.position().left(1).down(1))
		pieza4.position(pieza4.position().right(1).up(1))
		piezaActual.rotacion(0)
	}
}

object lDerecha inherits Figura{															//		  1
	method iniciarPieza(){																	//2 - 3 - 4
		pieza1.position(posicionInicialPieza.up(1))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	override method rotarDerechaDesde0(){
		pieza1.position(pieza1.position().left(1))
		pieza3.position(pieza3.position().down(1))
		pieza2.position(pieza2.position().right(1))
		pieza4.position(pieza4.position().down(1))
		piezaActual.rotacion(1)
	}
	
	override method rotarDerechaDesde1(){
		pieza1.position(pieza1.position().left(1).down(1))
		pieza3.position(pieza3.position().right(1).up(1))
		pieza4.position(pieza4.position().left(2))
		piezaActual.rotacion(2)
	}
	
	override method rotarDerechaDesde2(){
		pieza1.position(pieza1.position().up(1))
		pieza2.position(pieza2.position().up(1))
		pieza3.position(pieza3.position().left(1))
		pieza4.position(pieza4.position().right(1))
		piezaActual.rotacion(3)
	}
	
	override method rotarDerechaDesde3(){
		pieza1.position(pieza1.position().right(2))
		pieza2.position(pieza2.position().left(1).down(1))
		pieza4.position(pieza4.position().right(1).up(1))
		piezaActual.rotacion(0)
	}
		
}

object lIzquierda inherits Figura{															//1
	method iniciarPieza(){																	//2 - 3 - 4
		pieza1.position(posicionInicialPieza.left(2).up(1))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	override method rotarDerechaDesde0(){
		pieza1.position(pieza1.position().right(1))
		pieza2.position(pieza2.position().right(2).up(1))
		pieza4.position(pieza4.position().left(1).down(1))
		piezaActual.rotacion(1)
	}
	
	override method rotarDerechaDesde1(){
		pieza1.position(pieza1.position().left(1).down(1))
		pieza3.position(pieza3.position().right(1))
		pieza2.position(pieza2.position().left(1).down(1))
		pieza4.position(pieza4.position().right(1))
		piezaActual.rotacion(2)
	}
	
	override method rotarDerechaDesde2(){
		pieza1.position(pieza1.position().right(1).up(1))
		pieza3.position(pieza3.position().left(2).down(1))
		pieza4.position(pieza4.position().left(1))
		piezaActual.rotacion(3)
	}
	
	override method rotarDerechaDesde3(){
		pieza1.position(pieza1.position().left(1))
		pieza2.position(pieza2.position().left(1))
		pieza3.position(pieza3.position().right(1).up(1))
		pieza4.position(pieza4.position().right(1).up(1))
		piezaActual.rotacion(0)
	}

}

object nDerecha inherits Figura{															//	  1
	method iniciarPieza(){																	//2 - 3
		pieza1.position(posicionInicialPieza.up(1))											//4
		pieza2.position(posicionInicialPieza.left(1))
		pieza3.position(posicionInicialPieza)
		pieza4.position(posicionInicialPieza.left(1).down(1))
	}
	
	override method rotarDerechaDesde0(){
		pieza1.position(pieza1.position().left(2).down(1))
		pieza4.position(pieza4.position().right(1))
		pieza3.position(pieza3.position().left(1).down(1))
		piezaActual.rotacion(1)
	}
	
	override method rotarDerechaDesde1(){
		pieza1.position(pieza1.position().right(2).up(1))
		pieza4.position(pieza4.position().left(1))
		pieza3.position(pieza3.position().right(1).up(1))
		piezaActual.rotacion(0)
	}
}

object nIzquierda inherits Figura{															//1
	method iniciarPieza(){																	//2 - 3
		pieza1.position(posicionInicialPieza.left(1).up(1))									//	  4
		pieza2.position(posicionInicialPieza.left(1))
		pieza3.position(posicionInicialPieza)
		pieza4.position(posicionInicialPieza.down(1))
	}
	
	override method rotarDerechaDesde0(){
		pieza3.position(pieza3.position().left(1).down(1))
		pieza1.position(pieza1.position().right(1).down(1))
		pieza2.position(pieza2.position().right(2))
		piezaActual.rotacion(1)
	}
	
	override method rotarDerechaDesde1(){
		pieza3.position(pieza3.position().right(1).up(1))
		pieza1.position(pieza1.position().left(1).up(1))
		pieza2.position(pieza2.position().left(2))
		piezaActual.rotacion(0)
	}
}

object t inherits Figura{																	//	  1
	method iniciarPieza(){																	//2 - 3 - 4
		pieza1.position(posicionInicialPieza.left(1).up(1))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	override method rotarDerechaDesde0(){
		pieza2.position(pieza2.position().right(1))
		pieza3.position(pieza3.position().right(1))
		pieza4.position(pieza4.position().left(1).down(1))
		piezaActual.rotacion(1)
	}
	
	override method rotarDerechaDesde1(){
		pieza1.position(pieza1.position().left(1).down(1))
			piezaActual.rotacion(2)
	}
	
	override method rotarDerechaDesde2(){
		pieza1.position(pieza1.position().right(1).up(1))
		pieza2.position(pieza2.position().left(1))
		pieza3.position(pieza3.position().left(1))
		piezaActual.rotacion(3)
	}
	
	override method rotarDerechaDesde3(){
		pieza4.position(pieza4.position().right(1).up(1))
		piezaActual.rotacion(0)
	}
}
