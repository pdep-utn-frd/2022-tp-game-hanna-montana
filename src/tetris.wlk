import wollok.game.*
import consola.*

class Juego {
	var property position = null
	var property color
	
	method iniciar(){
		game.addVisual(fondo)
		game.addVisual(pieza)
		game.addVisual(reloj)
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
		pieza.bajar()
	}
}

object pieza{
	var property figura = "cuadrado"
	var property color = "amarillo"
	var property posicion = game.at(8,game.height()+1)
	method position() = posicion
	method image() = "src/assets/img/" + figura + " - " + color + ".png"
	
	method bajar(){
		if (posicion.y() == 0){
			//Añadimos un nuevo objeto, problema que no podemos agregar los objetos que necesitamos en tiempo de ejecución (Creo)
			const pieza2 = new PiezaFija(position = posicion, figura = figura, color = color)
			game.addVisual(pieza2)
			posicion = game.at(posicion.x(), game.height() + 1)
		}
		posicion = posicion.down(1)
	}
}