import wollok.game.*
import consola.*

const posicionInicialPieza = game.at(-2,6)										//Posicion desde la cual cae la pieza
const formas = [cuadrado, i, lDerecha, lIzquierda, nDerecha, nIzquierda, t]		//Colección de las figuras
const columnas_en_juego = [
	columna1, columna2, columna3,columna4,
	columna5,columna6, columna7, columna8,
	columna9, columna10,columna11, columna12,
	columna13, columna14,columna15, columna16
]		
const sonido_break = game.sound("break.mp3")
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
		game.onTick(500, "reloj", {reloj.contar()})
		game.onCollideDo(pieza1, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza2, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza3, {pieza => piezaActual.chocar()})
		game.onCollideDo(pieza4, {pieza => piezaActual.chocar()})
		piezaActual.cambiarPieza()
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
	
	method obtener_columnas() = columnas_en_juego

}

class PiezaInvisible {
	var property pieza = false
	var property position
}

class Pieza {
	var property pieza = true
	var property position
	var property image = "src/assets/img/cuadrado.png"
	
	method cambiarColor(_pieza){
		image = "src/assets/img/" + _pieza + ".png"
	}
	
	method caer() {
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
	var property contador = 0
	var property pieza = false
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
		return null
	}
	
	method llena_completa() {
		return llena
	}
	
	method obtenerTodasLasPosiciones() {
		return columna
	}
	
	method volver_vacia() {
		llena = false
	}

}

object columna1 inherits ColumnaLlena(x=16) {}
object columna2 inherits ColumnaLlena(x=15) {}
object columna3 inherits ColumnaLlena(x=14) {}
object columna4 inherits ColumnaLlena(x=13) {}
object columna5 inherits ColumnaLlena(x=12) {}
object columna6 inherits ColumnaLlena(x=11) {}
object columna7 inherits ColumnaLlena(x=10) {}
object columna8 inherits ColumnaLlena(x=9) {}
object columna9 inherits ColumnaLlena(x=8) {}
object columna10 inherits ColumnaLlena(x=7) {}
object columna11 inherits ColumnaLlena(x=6) {}
object columna12 inherits ColumnaLlena(x=5) {}
object columna13 inherits ColumnaLlena(x=4) {}
object columna14 inherits ColumnaLlena(x=3) {}
object columna15 inherits ColumnaLlena(x=2) {}
object columna16 inherits ColumnaLlena(x=1) {}

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
		figura.rotarDerecha()
	}
	
	method cambiarPieza(){
		numeroFigura = 0.randomUpTo(6)
		figura = formas.get(numeroFigura)
		pieza1.cambiarColor(figura)
		pieza2.cambiarColor(figura)
		pieza3.cambiarColor(figura)
		pieza4.cambiarColor(figura)
		rotacion = 0
		figura.iniciarPieza()
	}
}

object colisiones{
	method hayColision(visual1, visual2, visual3, visual4){
		if ((game.colliders(visual1) == []) and (game.colliders(visual2) == []) and (game.colliders(visual3) == []) and (game.colliders(visual4) == [])){
			piezaActual.ultimoMovimiento("derecha")
		}
	}
	
	method hayColisionSuperiorInferior(){
		if ((pieza1.position().y() >= 10) or (pieza2.position().y() >= 10) or (pieza3.position().y() >= 10) or (pieza4.position().y() >= 10)){
			movimientosFiguras.bajar(pieza1.position().y().max(pieza2.position().y()).max(pieza3.position().y()).max(pieza4.position().y()) - 9)
		}else if ((pieza1.position().y() <= 1) or (pieza2.position().y() <= 1) or (pieza3.position().y() <= 1) or (pieza4.position().y() <= 1)){
			movimientosFiguras.subir(1 - pieza1.position().y().min(pieza2.position().y()).min(pieza3.position().y()).min(pieza4.position().y()))
		}
	}
	
	method figuraChocar(){
		if (piezaActual.ultimoMovimiento() == "derecha"){
			game.addVisual(new Pieza(position = pieza1.position().left(1), image = "src/assets/img/" + piezaActual.figura() + ".png"))
			game.addVisual(new Pieza(position = pieza2.position().left(1), image = "src/assets/img/" + piezaActual.figura() + ".png"))
			game.addVisual(new Pieza(position = pieza3.position().left(1), image = "src/assets/img/" + piezaActual.figura() + ".png"))
			game.addVisual(new Pieza(position = pieza4.position().left(1), image = "src/assets/img/" + piezaActual.figura() + ".png"))
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
		
		columnas_en_juego.forEach{column => column.estaLlena()}
		const columnas_llenas = columnas_en_juego.filter{column => column.llena_completa() == not false}
		
		var minima_columna
		
		if (columnas_llenas.size() >= 1){
			minima_columna = columnas_llenas.min{columna => columna.x()}.position().x()
		} else {
			minima_columna = 0
		}

		const llenas = columnas_llenas.map{column => column.obtenerTodasLasPosiciones()}
		llenas.forEach{posiciones => posiciones.forEach{par_ordenado => self.romper(par_ordenado)}}
		columnas_llenas.forEach{columna => columna.volver_vacia()}
		
		if (minima_columna > 0) { 
			self.mover(minima_columna)
		}
		
	}
	
	
	method romper(par_ordenado) {
		game.removeVisual(game.getObjectsIn(par_ordenado).first())	
	}
	
	method mover(minimo){
		const piezas = game.allVisuals().filter{visual => visual.pieza() == not false}
		/*const piezas_para_bajar = piezas.filter{pieza => pieza.position().x()<minimo}
		piezas_para_bajar.forEach{pieza => pieza.position().left(1)}*/
		piezas.forEach{pieza => pieza.caer()}
	}
}


//----------FIGURAS----------//
//A la hora de definir los movimientos de cada pieza hay que tener en cuenta las posiciones relativas a las otras piezas
//para no mover una pieza encima de otra y disparar una colisión.

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
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
	
	method bajar(n){
		pieza4.position(pieza4.position().down(n))
		pieza3.position(pieza3.position().down(n))
		pieza2.position(pieza2.position().down(n))
		pieza1.position(pieza1.position().down(n))
		colisiones.hayColision(pieza1, pieza2, pieza3, pieza4)
	}
}

object cuadrado{																			// 1 - 2
	method iniciarPieza(){																	// 3 - 4
		pieza1.position(posicionInicialPieza.left(1).up(1))
		pieza2.position(posicionInicialPieza.up(1))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	method rotarDerecha(){
		//No hacemos nada ya que no tiene sentido rotar el cuadrado
	}
}

object i{																					//1 - 2 - 3 - 4
	method iniciarPieza(){
		pieza1.position(posicionInicialPieza.left(3))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	method rotarDerecha(){
		if (piezaActual.rotacion() == 0){
			pieza1.position(pieza1.position().right(2).up(2))
			pieza2.position(pieza2.position().right(1).up(1))
			pieza4.position(pieza4.position().left(1).down(1))
			piezaActual.rotacion(1)
		}else if (piezaActual.rotacion() == 1){
			pieza1.position(pieza1.position().left(2).down(2))
			pieza2.position(pieza2.position().left(1).down(1))
			pieza4.position(pieza4.position().right(1).up(1))
			piezaActual.rotacion(0)
		}
		colisiones.hayColisionSuperiorInferior()
	}
}

object lDerecha{																			//		  1
	method iniciarPieza(){																	//2 - 3 - 4
		pieza1.position(posicionInicialPieza.up(1))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	method rotarDerecha(){
		if (piezaActual.rotacion() == 0){
			pieza1.position(pieza1.position().left(1))
			pieza3.position(pieza3.position().down(1))
			pieza2.position(pieza2.position().right(1))
			pieza4.position(pieza4.position().down(1))
			piezaActual.rotacion(1)
		}else if (piezaActual.rotacion() == 1){
			pieza1.position(pieza1.position().left(1).down(1))
			pieza3.position(pieza3.position().right(1).up(1))
			pieza4.position(pieza4.position().left(2))
			piezaActual.rotacion(2)
		}else if (piezaActual.rotacion() == 2){
			pieza1.position(pieza1.position().up(1))
			pieza2.position(pieza2.position().up(1))
			pieza3.position(pieza3.position().left(1))
			pieza4.position(pieza4.position().right(1))
			piezaActual.rotacion(3)
		}else if (piezaActual.rotacion() == 3){
			pieza1.position(pieza1.position().right(2))
			pieza2.position(pieza2.position().left(1).down(1))
			pieza4.position(pieza4.position().right(1).up(1))
			piezaActual.rotacion(0)
		}
		colisiones.hayColisionSuperiorInferior()
	}
}

object lIzquierda{																			//1
	method iniciarPieza(){																	//2 - 3 - 4
		pieza1.position(posicionInicialPieza.left(2).up(1))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	method rotarDerecha(){
		if (piezaActual.rotacion() == 0){
			pieza1.position(pieza1.position().right(1))
			pieza2.position(pieza2.position().right(2).up(1))
			pieza4.position(pieza4.position().left(1).down(1))
			piezaActual.rotacion(1)
		}else if (piezaActual.rotacion() == 1){
			pieza1.position(pieza1.position().left(1).down(1))
			pieza3.position(pieza3.position().right(1))
			pieza2.position(pieza2.position().left(1).down(1))
			pieza4.position(pieza4.position().right(1))
			piezaActual.rotacion(2)
		}else if (piezaActual.rotacion() == 2){
			pieza1.position(pieza1.position().right(1).up(1))
			pieza3.position(pieza3.position().left(2).down(1))
			pieza4.position(pieza4.position().left(1))
			piezaActual.rotacion(3)
		}else if (piezaActual.rotacion() == 3){
			pieza1.position(pieza1.position().left(1))
			pieza2.position(pieza2.position().left(1))
			pieza3.position(pieza3.position().right(1).up(1))
			pieza4.position(pieza4.position().right(1).up(1))
			piezaActual.rotacion(0)
		}
		colisiones.hayColisionSuperiorInferior()
	}
}

object nDerecha{																			//	  1
	method iniciarPieza(){																	//2 - 3
		pieza1.position(posicionInicialPieza.up(1))											//4
		pieza2.position(posicionInicialPieza.left(1))
		pieza3.position(posicionInicialPieza)
		pieza4.position(posicionInicialPieza.left(1).down(1))
	}
	
	method rotarDerecha(){
		if (piezaActual.rotacion() == 0){
			pieza1.position(pieza1.position().left(2).down(1))
			pieza4.position(pieza4.position().right(1))
			pieza3.position(pieza3.position().left(1).down(1))
			piezaActual.rotacion(1)
		}else if (piezaActual.rotacion() == 1){
			pieza1.position(pieza1.position().right(2).up(1))
			pieza4.position(pieza4.position().left(1))
			pieza3.position(pieza3.position().right(1).up(1))
			piezaActual.rotacion(0)
		}
		colisiones.hayColisionSuperiorInferior()
	}
}

object nIzquierda{																			//1
	method iniciarPieza(){																	//2 - 3
		pieza1.position(posicionInicialPieza.left(1).up(1))									//	  4
		pieza2.position(posicionInicialPieza.left(1))
		pieza3.position(posicionInicialPieza)
		pieza4.position(posicionInicialPieza.down(1))
	}
	
	method rotarDerecha(){
		if (piezaActual.rotacion() == 0){
			pieza3.position(pieza3.position().left(1).down(1))
			pieza1.position(pieza1.position().right(1).down(1))
			pieza2.position(pieza2.position().right(2))
			piezaActual.rotacion(1)
		}else if (piezaActual.rotacion() == 1){
			pieza3.position(pieza3.position().right(1).up(1))
			pieza1.position(pieza1.position().left(1).up(1))
			pieza2.position(pieza2.position().left(2))
			piezaActual.rotacion(0)
		}
		colisiones.hayColisionSuperiorInferior()
	}
}

object t{																					//	  1
	method iniciarPieza(){																	//2 - 3 - 4
		pieza1.position(posicionInicialPieza.left(1).up(1))
		pieza2.position(posicionInicialPieza.left(2))
		pieza3.position(posicionInicialPieza.left(1))
		pieza4.position(posicionInicialPieza)
	}
	
	method rotarDerecha(){
		if (piezaActual.rotacion() == 0){
			pieza2.position(pieza2.position().right(1))
			pieza3.position(pieza3.position().right(1))
			pieza4.position(pieza4.position().left(1).down(1))
			piezaActual.rotacion(1)
		}else if (piezaActual.rotacion() == 1){
			pieza1.position(pieza1.position().left(1).down(1))
			piezaActual.rotacion(2)
		}else if (piezaActual.rotacion() == 2){
			pieza1.position(pieza1.position().right(1).up(1))
			pieza2.position(pieza2.position().left(1))
			pieza3.position(pieza3.position().left(1))
			piezaActual.rotacion(3)
		}else if (piezaActual.rotacion() == 3){
			pieza4.position(pieza4.position().right(1).up(1))
			piezaActual.rotacion(0)
		}
		colisiones.hayColisionSuperiorInferior()
	}
}
