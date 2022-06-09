import wollok.game.*
import consola.*

class Juego {
	var property position = null
	var property color
	
	method iniciar(){
		game.addVisual(fondo)
		game.addVisual(pieza)
		game.addVisual(reloj)
		keyboard.down().onPressDo{
			pieza.bajar()
		}
		keyboard.up().onPressDo{
			pieza.subir()
		}
		game.onTick(100, "reloj", {reloj.contar()}) 
	}
	
	method terminar(){

	}
	method image() = "juego" + color + ".png"
	

}

class PiezaFija {
	var property position
	var property figura
	var property color
	
	method image() = "src/assets/img/" + figura + " - " + color + ".png"
}
//No se usa game.boardGround porque no se pueden definir dos fondos diferentes
object fondo{
	method position() = game.origin()
	method image() = "src/assets/img/background.png"
}

object reloj{
	var property contador = 0
	
	method text() = contador.toString()
	method textColor() = "FFFFFF"
	method position() = game.at(0,2)
	
	method contar(){
		contador += 1
		pieza.derecha()
	}
}

object pieza{
	var property figura = "cuadrado"
	var property color = "amarillo"
	var property posicion = game.at(0,6)
	method position() = posicion
	method image() = "src/assets/img/" + figura + " - " + color + ".png"
	
	method derecha(){
		if (posicion.x() == game.width()-2){
			game.addVisual(new PiezaFija(position = posicion, figura = figura, color = color))
			posicion = game.at(0,6)
		}
		posicion = posicion.right(1)
	}
	
	method bajar(){
		if (posicion.y() != 0){
			posicion = posicion.down(1)	
		}
	}
	
	method subir(){
		if (posicion.y() != 10){
			posicion = posicion.up(1)	
		}
	}
}

object posiciones {

}