import wollok.game.*
import figuras.*
import consola.*

const posicionInicialPieza = game.at(-2,6)										//Posicion desde la cual cae la pieza
const formas = [cuadrado, i, lDerecha, lIzquierda, nDerecha, nIzquierda, t]		//Colección de las figuras
const columnasEnJuego = [	columna1, columna2, columna3, columna4,
							columna5, columna6, columna7, columna8,
							columna9, columna10, columna11, columna12,
							columna13, columna14, columna15, columna16
]

class Juego {
	var property position = null
	
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
		game.addVisual(maxScore)

		keyboard.down().onPressDo{
			piezaActual.bajar()
		}
		keyboard.up().onPressDo{
			piezaActual.subir()
		}
		keyboard.right().onPressDo{
			piezaActual.derecha()
		}
		keyboard.z().onPressDo{
			piezaActual.rotarDerecha()
		}
		keyboard.r().onPressDo{
			piezaActual.cambiarPieza()
			self.reiniciar()
		}
		keyboard.q().onPressDo{
			consola.juegoTerminar(self)
		}
		game.onTick(500, "reloj", {reloj.contar()})
		game.onCollideDo(pieza1, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza2, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza3, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza4, {pieza => piezaActual.chocar()})
		piezaActual.cambiarPieza()
		piezaActual.figura().iniciarPieza()
	}
	
	method terminar(){
		
	}
	
	method reiniciar(){
		game.clear()
		self.iniciar()
		reloj.contador(0)
	}
	
	method image() = "src/assets/img/tetrisLogo.png"

}

class PiezaInvisible {
	var property pieza = false
	var property position
}

class Pieza {
	var property pieza = true
	var property position
	var property image = "src/assets/img/piezaInicial.png"
	
	method moverDerecha() {
		position = position.right(1)
	}
}

//No se usa game.boardGround() porque no se pueden definir dos fondos diferentes
object fondo{
	var property pieza = false
	method position() = game.origin().left(1) //La posicion del fondo es (-1,0) para que el objeto que lo contiene no colisione con nada
	method image() = "src/assets/img/background.png"
}

object reloj{
	var property pieza = false
	var property contador = 0
	
	method text() = "Puntaje: " + contador.toString()
	method textColor() = "FFFFFF"
	method position() = game.at(1,11)
	
	method contar(){
		contador += 1
		piezaActual.derecha()
	}
}

object maxScore{
	var property pieza = false
	var property maxScore = 0
	method text() = "Max Score: " + maxScore.toString()
	method textColor() = "FFFFFF"
	method position() = game.at(5,11)
}

object gameover{
	var property pieza = false
	method image() = "src/assets/img/gameover.png"
	method position() = game.at(4,2)
	
	method mostrar(){
	    game.removeTickEvent("reloj")
		game.addVisual(self)
		if (reloj.contador() > maxScore.maxScore()){
			maxScore.maxScore(reloj.contador())			
		}
	}
	
	method hayGameOver(){
		return (pieza1.position().x()<0) or (pieza2.position().x()<0) or (pieza3.position().x()<0) or (pieza4.position().x()<0)
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
	var property pieza = false
	var property x
	const columna = [
			game.at(x,1),
			game.at(x,2),
			game.at(x,3),
			game.at(x,4),
			game.at(x,5),
			game.at(x,6),
			game.at(x,7),
			game.at(x,8),
			game.at(x,9),
			game.at(x,10)
	]
	method text() = llena.toString()
	method textColor() = "FFFFFF"
	method position() = game.at(x,11)

	
	method estaLlena() {
		llena = columna.all{posicion => game.getObjectsIn(posicion).size() == 1}
	}
	
	method llenaCompleta() {
		return llena
	}
	
	method obtenerTodasLasPosiciones() {
		return columna
	}
	
	method vaciar() {
		llena = false
	}

}

const columna1 = new ColumnaLlena(x=16)
const columna2 = new ColumnaLlena(x=15)
const columna3 = new ColumnaLlena(x=14)
const columna4 = new ColumnaLlena(x=13)
const columna5 = new ColumnaLlena(x=12)
const columna6 = new ColumnaLlena(x=11)
const columna7 = new ColumnaLlena(x=10)
const columna8 = new ColumnaLlena(x=9)
const columna9 = new ColumnaLlena(x=8)
const columna10 = new ColumnaLlena(x=7)
const columna11 = new ColumnaLlena(x=6)
const columna12 = new ColumnaLlena(x=5)
const columna13 = new ColumnaLlena(x=4)
const columna14 = new ColumnaLlena(x=3)
const columna15 = new ColumnaLlena(x=2)
const columna16 = new ColumnaLlena(x=1)

object piezaActual{
	var property pieza = true
	var numeroFigura
	var property figura
	var property ultimoMovimiento = "derecha"
	var property rotacion = 0
	
	method derecha(){
		if (ultimoMovimiento == "derecha"){
			movimientosFiguras.moverDerecha(1)
		}
	}
	
	method bajar(){
		if (pieza4.position().y() != 1){	//La pieza 4 siempre está abajo
			ultimoMovimiento = "bajar"
			movimientosFiguras.bajar(1)
		}
	}
	
	method subir(){ 
		if (pieza1.position().y() != 10){	//La pieza 1 siempre está arriba
			ultimoMovimiento = "subir"
			movimientosFiguras.subir(1)
		}
	}
	
	method chocar(){
		colisiones.figuraChocar()
	}
	
	method rotarDerecha(){
		figura.rotarDerechaDesde(rotacion)
	}
	
	method cambiarPieza(){
		numeroFigura = 0.randomUpTo(6)
		figura = formas.get(numeroFigura)
		rotacion = 0
		figura.iniciarPieza()
	}
}

object colisiones{
	method cambiarUltimoMovimiento(visual1, visual2, visual3, visual4){
		if ((game.colliders(visual1) == []) and (game.colliders(visual2) == []) and (game.colliders(visual3) == []) and (game.colliders(visual4) == [])){
			piezaActual.ultimoMovimiento("derecha")
		}
	}
	
	method seTraspasoLimiteSuperior(){
		return (pieza1.position().y() >= 10) or (pieza2.position().y() >= 10) or (pieza3.position().y() >= 10) or (pieza4.position().y() >= 10)
	}
	
	method seTraspasoLimiteInferior(){
		return (pieza1.position().y() <= 1) or (pieza2.position().y() <= 1) or (pieza3.position().y() <= 1) or (pieza4.position().y() <= 1)
	}
	
	method hayColisionSuperiorInferior(){
		if (self.seTraspasoLimiteSuperior()){
			movimientosFiguras.bajar(pieza1.position().y().max(pieza2.position().y()).max(pieza3.position().y()).max(pieza4.position().y()) - 9)
		}else if (self.seTraspasoLimiteInferior()){
			movimientosFiguras.subir(1 - pieza1.position().y().min(pieza2.position().y()).min(pieza3.position().y()).min(pieza4.position().y()))
		}
	}
	
	method figuraChocar(){
		if (piezaActual.ultimoMovimiento() == "derecha"){
			if (gameover.hayGameOver()){
				gameover.mostrar()
			}
			else{
			piezaActual.figura().crearFiguraFija()
			piezaActual.cambiarPieza()
			}
		}
		if (piezaActual.ultimoMovimiento() == "bajar"){
			piezaActual.subir()
			piezaActual.ultimoMovimiento("derecha")
		}
		if (piezaActual.ultimoMovimiento() == "subir"){
			piezaActual.bajar()
			piezaActual.ultimoMovimiento("derecha")
		}
		
		columnasEnJuego.forEach{column => column.estaLlena()}
		const columnasLlenas = columnasEnJuego.filter{column => column.llenaCompleta() == not false}
		const veces = columnasLlenas.size()
		var minimaColumna
		if (columnasLlenas.size() >= 1){
			minimaColumna = columnasLlenas.min{columna => columna.x()}.position().x()
		} else {
			minimaColumna = 0
		}

		const llenas = columnasLlenas.map{column => column.obtenerTodasLasPosiciones()}
		llenas.forEach{posiciones => posiciones.forEach{parOrdenado => self.romper(parOrdenado)}}
		columnasLlenas.forEach{columna => columna.vaciar()}
		
		if (minimaColumna > 0) { 
			veces.times({a =>  self.mover(minimaColumna + a - 1)})
		}
	}
	
	method romper(parOrdenado) {
		game.removeVisual(game.getObjectsIn(parOrdenado).first())	
	}
	
	method mover(minima){
		const piezas = game.allVisuals().filter{visual => visual.pieza()}
		piezas.filter{pieza => pieza.position().x() <= minima}.forEach{pieza => pieza.moverDerecha()}
	}
}


