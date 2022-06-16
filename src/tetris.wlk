import wollok.game.*
import consola.*

const posicionInicialPieza = game.at(-2,6)		//Posicion desde la cual cae la pieza

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
		game.addVisual(columna1)
		game.addVisual(columna2)
		game.addVisual(columna3)
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

class ColumnaLlena {
	var llena = false	
	var x;
	method text() = x.toString()+"-llena: " + llena.toString()
	method textColor() = "FFFFFF"
	method position() = game.at(x,11)
	
	method esta_llena() {
		llena = self.generador_columna().all{posicion => game.getObjectsIn(posicion).size() == 1}
		return llena
	}
	
	method generador_columna() {	
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

//Piezas que acompañan a la principal (Para las colisiones)
const piezaInvisible1 = new PiezaInvisible (position = game.at(-1, -1))
const piezaInvisible2 = new PiezaInvisible (position = game.at(-2, -2))
const piezaInvisible3 = new PiezaInvisible (position = game.at(-3, -3))

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


object piezaPrincipal{
	var property figura = cuadrado
	var property position = posicionInicialPieza
	var property ultimoMovimiento = "derecha"
	method image() = "src/assets/img/" + figura + ".png"
	
	method derecha(){
		if (ultimoMovimiento == "derecha"){
			figura.moverDerecha()
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

object colisiones{
	method hayColision(visual1, visual2, visual3, visual4){
		if ((game.colliders(visual1) == [])
			and 
			(game.colliders(visual2) == [])
			and
			(game.colliders(visual3) == [])
			and (game.colliders(visual4) == [])
		){
			piezaPrincipal.ultimoMovimiento("derecha")
		}
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
		colisiones.hayColision(piezaPrincipal, piezaInvisible1, piezaInvisible2, piezaInvisible3)
	}
	
	method bajar(){
		piezaPrincipal.position(piezaPrincipal.position().down(1))
		piezaInvisible1.position(piezaInvisible1.position().down(1))
		piezaInvisible2.position(piezaInvisible2.position().down(1))
		piezaInvisible3.position(piezaInvisible3.position().down(1))
		colisiones.hayColision(piezaPrincipal, piezaInvisible1, piezaInvisible2, piezaInvisible3)
	}
	
	method chocar(){
		if (piezaPrincipal.ultimoMovimiento() == "derecha"){
			game.addVisual(new PiezaFija(position = piezaPrincipal.position().left(1), figura = piezaPrincipal.figura()))
			game.addVisual(new PiezaInvisible(position = piezaInvisible1.position().left(1)))
			game.addVisual(new PiezaInvisible(position = piezaInvisible2.position().left(1)))
			game.addVisual(new PiezaInvisible(position = piezaInvisible3.position().left(1)))
			self.iniciarPieza()
		}
		if (piezaPrincipal.ultimoMovimiento() == "bajar"){
			piezaPrincipal.subir()
			piezaPrincipal.ultimoMovimiento("derecha")
		}
		if (piezaPrincipal.ultimoMovimiento() == "subir"){
			piezaPrincipal.bajar()
			piezaPrincipal.ultimoMovimiento("derecha")
		}
		
		const POSIBLES_COLUMNAS_LLENAS = 
		[columna1,
		columna2,
		columna3]
		POSIBLES_COLUMNAS_LLENAS.forEach{columna => columna.esta_llena()}
		
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

