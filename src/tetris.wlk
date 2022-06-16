import wollok.game.*
import consola.*

const posicionInicialPieza = game.at(-2,6)										//Posicion desde la cual cae la pieza
const formas = [cuadrado, i, lDerecha, lIzquierda, nDerecha, nIzquierda, t]		//Colección de las piezas

class Juego {
	var property position = null
	var property color
	
	method iniciar(){
		game.addVisual(fondo)
		game.addVisual(pieza1)
		game.addVisual(pieza2)
		game.addVisual(pieza3)
		game.addVisual(pieza4)
		game.addVisual(barrera1)
		game.addVisual(barrera2)
		game.addVisual(barrera3)
		game.addVisual(barrera4)
		game.addVisual(barrera5)
		game.addVisual(barrera6)
		game.addVisual(barrera7)
		game.addVisual(barrera8)
		game.addVisual(barrera9)
		game.addVisual(barrera10)
		game.addVisual(reloj)
		game.addVisual(columna1)
		game.addVisual(columna2)
		game.addVisual(columna3)
		keyboard.down().onPressDo{
			piezaActual.bajar()
		}
		keyboard.up().onPressDo{
			piezaActual.subir()
		}
		keyboard.r().onPressDo{
			piezaActual.cambiarPieza()
			self.reiniciar()
		}
		game.onTick(100, "reloj", {reloj.contar()})
		game.onCollideDo(pieza1, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza2, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza3, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza4, {pieza => piezaActual.chocar()})
		piezaActual.figura().iniciarPieza()
	}
	
	method terminar(){
		game.stop()
	}
	
	method reiniciar(){
		game.clear()
		self.iniciar()
		reloj.contador(0)
	}
	
	method image() = "src/assets/img/tetrisLogo.png"
	

}

class PiezaFija {
	var property position
	var property figura
   
	method image() = "src/assets/img/" + figura + ".png"
}

class PiezaInvisible {
	var property position
}

class PiezaInvisibleConImagen {
	var property position
	var property image
}

class Pieza {
	var property position
	var property image = "src/assets/img/piezaBase.png"
}
//No se usa game.boardGround() porque no se pueden definir dos fondos diferentes
object fondo{
	method position() = game.origin()
	method image() = "src/assets/img/background.png"
}

object reloj{
	var property contador = 0
	
	method text() = "Puntaje: " + contador.toString()
	method textColor() = "FFFFFF"
	method position() = game.at(1,11)
	
	method contar(){
		contador += 1
		piezaActual.derecha()
	}
}

//Piezas con las que se forman las figuras
const pieza1 = new Pieza (position = game.at(-1, -1))
const pieza2 = new Pieza (position = game.at(-2, -2))
const pieza3 = new Pieza (position = game.at(-3, -3))
const pieza4 = new Pieza (position = game.at(-4, -4))

//Barrera del Piso
const barrera1 = new PiezaInvisible (position = game.at(game.width(), 1))
const barrera2 = new PiezaInvisible (position = game.at(game.width(), 2))
const barrera3 = new PiezaInvisible (position = game.at(game.width(), 3))
const barrera4 = new PiezaInvisible (position = game.at(game.width(), 4))
const barrera5 = new PiezaInvisible (position = game.at(game.width(), 5))
const barrera6 = new PiezaInvisible (position = game.at(game.width(), 6))
const barrera7 = new PiezaInvisible (position = game.at(game.width(), 7))
const barrera8 = new PiezaInvisible (position = game.at(game.width(), 8))
const barrera9 = new PiezaInvisible (position = game.at(game.width(), 9))
const barrera10 = new PiezaInvisible (position = game.at(game.width(), 10))

class ColumnaLlena {
	var llena = false
	var x;
	method text() = x.toString()+" - Llena: " + llena.toString()
	method textColor() = "FFFFFF"
	method position() = game.at(x,11)
	
	method estaLlena() {
		llena = self.generadorColumna().all{posicion => game.getObjectsIn(posicion).size() == 1}
		return llena
	}
	
	method generadorColumna() {	
		return [
			game.at(x,1),
			game.at(x,2),
			game.at(x,3),
			game.at(x,4),
			game.at(x,5),
			game.at(x,6),
			game.at(x,7),
			game.at(x,8),
			game.at(x,9)
		]
	}
	
	method todas_las_posiciones_posibles() {
		return [
			game.at(x+1,1),
			game.at(x+1,2),
			game.at(x+1,3),
			game.at(x+1,4),
			game.at(x+1,5),
			game.at(x+1,6),
			game.at(x+1,7),
			game.at(x+1,8),
			game.at(x+1,9),
			game.at(x,1),
			game.at(x,2),
			game.at(x,3),
			game.at(x,4),
			game.at(x,5),
			game.at(x,6),
			game.at(x,7),
			game.at(x,8),
			game.at(x,9)	
		]
	}
	
}

object columna1 inherits ColumnaLlena(x=15) {}
object columna2 inherits ColumnaLlena(x=13) {}
object columna3 inherits ColumnaLlena(x=11) {}


object piezaActual{
	var numeroFigura = 0.randomUpTo(6)
	var property figura = t
	var property ultimoMovimiento = "derecha"
	
	method image() = "src/assets/img/piezaBase.png"
	
	method derecha(){
		if (ultimoMovimiento == "derecha"){
			figura.moverDerecha()
		}
	}
	
	method bajar(){
		if (pieza4.position().y() != 1){	//La pieza 4 siempre está abajo
			ultimoMovimiento = "bajar"
			figura.bajar()
		}
	}
	
	method subir(){ 
		if (pieza1.position().y() != 10){	//La pieza 1 siempre está arriba
			ultimoMovimiento = "subir"
			figura.subir()
		}
	}
	
	method chocar(){
		colisiones.figuraChocar()
	}
	
	method cambiarPieza(){
		numeroFigura = 0.randomUpTo(6)
		if (numeroFigura == 5){
			figura = "nada"
			nIzquierda.iniciarPieza()
		}else{
			figura = formas.get(numeroFigura)
			figura.iniciarPieza()
		}
	}
}

object colisiones{
	method hayColision(visual1, visual2, visual3, visual4){
		if ((game.colliders(visual1) == []) and (game.colliders(visual2) == []) and (game.colliders(visual3) == []) and (game.colliders(visual4) == [])){
			piezaActual.ultimoMovimiento("derecha")
		}
	}
	
	method figuraChocar(){
		if (piezaActual.ultimoMovimiento() == "derecha"){
			game.addVisual(new Pieza(position = pieza4.position().left(1)))
			game.addVisual(new Pieza(position = pieza1.position().left(1)))
			game.addVisual(new Pieza(position = pieza2.position().left(1)))
			game.addVisual(new Pieza(position = pieza3.position().left(1)))
			piezaActual.cambiarPieza()
		}
		if (piezaActual.ultimoMovimiento() == "bajar"){
			piezaActual.subir()
			piezaActual.ultimoMovimiento("derecha")
		}
		if (piezaActual.ultimoMovimiento() == "subir"){
			piezaActual.bajar()
			piezaActual.ultimoMovimiento("derecha")
		}
		
		const posiblesColumnasLlenas = [columna1, columna2, columna3]
		posiblesColumnasLlenas.forEach{columna => columna.estaLlena()}
		/*
		 * ALGORITMO PARA ROMPER LINEAS (FALTA TERMINAR) NO TOCAR XDDD
		
		const columnas_llenas = posibles_columnas_llenas.filter{columna => columna.esta_llena() == true}
		const posiciones_a_remover = columnas_llenas.map{columna => columna.todas_las_posiciones_posibles()}
		posiciones_a_remover.forEach{
			pares_ordenados =>
			pares_ordenados.forEach{
			par_ordenado => 
				{
						if (game.getObjectsIn(par_ordenado).size() == 1) 
						{
							game.removeVisual(game.getObjectsIn(par_ordenado).first())
						}
				}
			}
		}*/
	}
}


//----------FIGURAS----------//
//A la hora de definir los movimientos de cada pieza hay que tener en cuenta las posiciones relativas a las otras piezas
//para no mover una pieza encima de otra y disparar una colisión.

object cuadrado{
	method iniciarPieza(){																	// 1 - 2
		pieza3.position(posicionInicialPieza.right(1))										// 4 - 3
		pieza2.position(posicionInicialPieza.up(1).right(1))
		pieza1.position(posicionInicialPieza.up(1))
		pieza4.position(posicionInicialPieza)
	}
	
	method moverDerecha(){
		pieza3.position(pieza3.position().right(1))
		pieza2.position(pieza2.position().right(1))
		pieza1.position(pieza1.position().right(1))
		pieza4.position(pieza4.position().right(1))
	}
	
	method subir(){
		pieza2.position(pieza2.position().up(1))
		pieza1.position(pieza1.position().up(1))
		pieza3.position(pieza3.position().up(1))
		pieza4.position(pieza4.position().up(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(){
		pieza4.position(pieza4.position().down(1))
		pieza3.position(pieza3.position().down(1))
		pieza2.position(pieza2.position().down(1))
		pieza1.position(pieza1.position().down(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}

object i{
	method iniciarPieza(){																	//4 - 1 - 2 - 3
		pieza4.position(posicionInicialPieza.left(3))
		pieza1.position(posicionInicialPieza.left(2))
		pieza2.position(posicionInicialPieza.left(1))
		pieza3.position(posicionInicialPieza)
	}
	
	method moverDerecha(){
		pieza3.position(pieza3.position().right(1))
		pieza2.position(pieza2.position().right(1))
		pieza1.position(pieza1.position().right(1))
		pieza4.position(pieza4.position().right(1))
	}
	
	method subir(){
		pieza2.position(pieza2.position().up(1))
		pieza3.position(pieza3.position().up(1))
		pieza1.position(pieza1.position().up(1))
		pieza4.position(pieza4.position().up(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(){
		pieza4.position(pieza4.position().down(1))
		pieza1.position(pieza1.position().down(1))
		pieza2.position(pieza2.position().down(1))
		pieza3.position(pieza3.position().down(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}

object lDerecha{																			//		  1
	method iniciarPieza(){																	//4 - 3 - 2
		pieza4.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza2.position(posicionInicialPieza)
		pieza1.position(posicionInicialPieza.up(1))
	}
	
	method moverDerecha(){
		pieza1.position(pieza1.position().right(1))
		pieza2.position(pieza2.position().right(1))
		pieza3.position(pieza3.position().right(1))
		pieza4.position(pieza4.position().right(1))
	}
	
	method subir(){
		pieza1.position(pieza1.position().up(1))
		pieza2.position(pieza2.position().up(1))
		pieza3.position(pieza3.position().up(1))
		pieza4.position(pieza4.position().up(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(){
		pieza4.position(pieza4.position().down(1))
		pieza3.position(pieza3.position().down(1))
		pieza2.position(pieza2.position().down(1))
		pieza1.position(pieza1.position().down(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}

object lIzquierda{																			//1
	method iniciarPieza(){																	//4 - 3 - 2
		pieza4.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza2.position(posicionInicialPieza)
		pieza1.position(posicionInicialPieza.up(1).left(2))
	}
	
	method moverDerecha(){
		pieza1.position(pieza1.position().right(1))
		pieza2.position(pieza2.position().right(1))
		pieza3.position(pieza3.position().right(1))
		pieza4.position(pieza4.position().right(1))
	}
	
	method subir(){
		pieza1.position(pieza1.position().up(1))
		pieza2.position(pieza2.position().up(1))
		pieza3.position(pieza3.position().up(1))
		pieza4.position(pieza4.position().up(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(){
		pieza4.position(pieza4.position().down(1))
		pieza3.position(pieza3.position().down(1))
		pieza2.position(pieza2.position().down(1))
		pieza1.position(pieza1.position().down(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}

object nDerecha{																			//	  1
	method iniciarPieza(){																	//3 - 2
		pieza4.position(posicionInicialPieza.down(1).left(1))								//4
		pieza1.position(posicionInicialPieza.up(1))
		pieza2.position(posicionInicialPieza)
		pieza3.position(posicionInicialPieza.left(1))
	}
	
	method moverDerecha(){
		pieza4.position(pieza4.position().right(1))
		pieza2.position(pieza2.position().right(1))
		pieza3.position(pieza3.position().right(1))
		pieza1.position(pieza1.position().right(1))
	}
	
	method subir(){
		pieza1.position(pieza1.position().up(1))
		pieza2.position(pieza2.position().up(1))
		pieza3.position(pieza3.position().up(1))
		pieza4.position(pieza4.position().up(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(){
		pieza4.position(pieza4.position().down(1))
		pieza3.position(pieza3.position().down(1))
		pieza2.position(pieza2.position().down(1))
		pieza1.position(pieza1.position().down(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}

object nIzquierda{																			//1
	method iniciarPieza(){																	//3 - 2
		pieza4.position(posicionInicialPieza.down(1))										//	  4
		pieza1.position(posicionInicialPieza.left(1).up(1))
		pieza2.position(posicionInicialPieza)
		pieza3.position(posicionInicialPieza.left(1))
	}
	
	method moverDerecha(){
		pieza2.position(pieza2.position().right(1))
		pieza1.position(pieza1.position().right(1))
		pieza3.position(pieza3.position().right(1))
		pieza4.position(pieza4.position().right(1))
	}
	
	method subir(){
		pieza1.position(pieza1.position().up(1))
		pieza2.position(pieza2.position().up(1))
		pieza3.position(pieza3.position().up(1))
		pieza4.position(pieza4.position().up(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(){
		pieza4.position(pieza4.position().down(1))
		//piezaInvisible4.position(piezaInvisible4.position().down(1))
		pieza3.position(pieza3.position().down(1))
		pieza2.position(pieza2.position().down(1))
		pieza1.position(pieza1.position().down(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}

object t{																					//	  1
	method iniciarPieza(){																	//4 - 3 - 2
		pieza4.position(posicionInicialPieza.left(2))
		pieza1.position(posicionInicialPieza.left(1).up(1))
		pieza2.position(posicionInicialPieza)
		pieza3.position(posicionInicialPieza.left(1))
	}
	
	method moverDerecha(){
		pieza2.position(pieza2.position().right(1))
		pieza3.position(pieza3.position().right(1))
		pieza4.position(pieza4.position().right(1))
		pieza1.position(pieza1.position().right(1))
	}
	
	method subir(){
		pieza1.position(pieza1.position().up(1))
		pieza2.position(pieza2.position().up(1))
		pieza3.position(pieza3.position().up(1))
		pieza4.position(pieza4.position().up(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(){
		pieza4.position(pieza4.position().down(1))
		pieza3.position(pieza3.position().down(1))
		pieza2.position(pieza2.position().down(1))
		pieza1.position(pieza1.position().down(1))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}
