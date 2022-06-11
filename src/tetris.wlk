import wollok.game.*
import consola.*

const posicionInicialPieza = game.at(0,6)

class Juego {
	var property position = null
	var property color
	
	method iniciar(){
		game.addVisual(fondo)
		game.addVisual(piezaPrincipal)
		game.addVisual(piezaInvisible1)
		game.addVisual(piezaInvisible2)
		game.addVisual(piezaInvisible3)
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
		keyboard.down().onPressDo{
			piezaPrincipal.bajar()
		}
		keyboard.up().onPressDo{
			piezaPrincipal.subir()
		}
		keyboard.r().onPressDo{
			self.reiniciar()
		}
		game.onTick(100, "reloj", {reloj.contar()})
		game.onCollideDo(piezaPrincipal, {pieza => piezaPrincipal.chocar()})
		game.onCollideDo(piezaInvisible1, {pieza => piezaPrincipal.chocar()})
		game.onCollideDo(piezaInvisible2, {pieza => piezaPrincipal.chocar()})
		game.onCollideDo(piezaInvisible3, {pieza => piezaPrincipal.chocar()})
		piezaPrincipal.figura().iniciarPieza()
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
		piezaPrincipal.derecha()
	}
}

//Piezas que acompañan a la principal (Para las colisiones)
const piezaInvisible1 = new PiezaInvisible (position = game.at(-1, -1))
const piezaInvisible2 = new PiezaInvisible (position = game.at(-2, -2))
const piezaInvisible3 = new PiezaInvisible (position = game.at(-3, -3))

//Barrera del Piso
const barrera1 = new PiezaInvisible (position = game.at(17, 1))
const barrera2 = new PiezaInvisible (position = game.at(17, 2))
const barrera3 = new PiezaInvisible (position = game.at(17, 3))
const barrera4 = new PiezaInvisible (position = game.at(17, 4))
const barrera5 = new PiezaInvisible (position = game.at(17, 5))
const barrera6 = new PiezaInvisible (position = game.at(17, 6))
const barrera7 = new PiezaInvisible (position = game.at(17, 7))
const barrera8 = new PiezaInvisible (position = game.at(17, 8))
const barrera9 = new PiezaInvisible (position = game.at(17, 9))
const barrera10 = new PiezaInvisible (position = game.at(17, 10))


object piezaPrincipal{
	var property figura = cuadrado
	var property position = posicionInicialPieza
	var property ultimoMovimiento
	method image() = "src/assets/img/" + figura + ".png"
	
	method derecha(){
		if (position.x() != 17){
			figura.moverDerecha()
		}
		else{
			self.chocar()
		}
		
	}
	
	method bajar(){
		if (position.y() != 1){
			ultimoMovimiento = "bajar"
			figura.bajar()
		}
	}
	
	method subir(){
		if (position.y() != 9){
			ultimoMovimiento = "subir"
			figura.subir()
		}
	}
	
	method chocar(){
		figura.chocar()
	}
}

//A la hora de definir los movimientos de cada pieza hay que tener en cuenta las posiciones relativas a las otras piezas
//para no mover una pieza encima de otra y disparar una colisión.
object cuadrado{
	method iniciarPieza(){																	// 3 - 2
		piezaInvisible1.position(posicionInicialPieza.right(1))								// P - 1
		piezaInvisible2.position(posicionInicialPieza.up(1).right(1))
		piezaInvisible3.position(posicionInicialPieza.up(1))
		piezaPrincipal.position(posicionInicialPieza)
	}
	
	method moverDerecha(){
		piezaInvisible1.position(piezaInvisible1.position().right(1))
		piezaInvisible2.position(piezaInvisible2.position().right(1))
		piezaInvisible3.position(piezaInvisible3.position().right(1))
		piezaPrincipal.position(piezaPrincipal.position().right(1))
	}
	
	method subir(){
		piezaInvisible2.position(piezaInvisible2.position().up(1))
		piezaInvisible3.position(piezaInvisible3.position().up(1))
		piezaInvisible1.position(piezaInvisible1.position().up(1))
		piezaPrincipal.position(piezaPrincipal.position().up(1))
	}
	
	method bajar(){
		piezaPrincipal.position(piezaPrincipal.position().down(1))
		piezaInvisible1.position(piezaInvisible1.position().down(1))
		piezaInvisible2.position(piezaInvisible2.position().down(1))
		piezaInvisible3.position(piezaInvisible3.position().down(1))
	}
	
	method chocar(){
		if (piezaPrincipal.ultimoMovimiento() == null){
			game.addVisual(new PiezaFija(position = piezaPrincipal.position().left(1), figura = piezaPrincipal.figura()))
			game.addVisual(new PiezaInvisible(position = piezaInvisible1.position().left(1)))
			game.addVisual(new PiezaInvisible(position = piezaInvisible2.position().left(1)))
			game.addVisual(new PiezaInvisible(position = piezaInvisible3.position().left(1)))
			self.iniciarPieza()
		}
		if (piezaPrincipal.ultimoMovimiento() == "bajar"){
			piezaPrincipal.subir()
			piezaPrincipal.ultimoMovimiento(null)
		}
		if (piezaPrincipal.ultimoMovimiento() == "subir"){
			piezaPrincipal.bajar()
			piezaPrincipal.ultimoMovimiento(null)
		}
	}
}