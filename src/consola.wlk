import wollok.game.* 
import tetris.*

object consola {

	const juegos = [
		new Juego()
	]
	
	var menu 
	
	//Resolución = 850x600
	method initialize(){
		game.height(12)
		game.width(17)
		game.title("Consola de juegos")
	}
	
	method iniciar(){
		menu = new MenuIconos(posicionInicial = game.center().left(2))	
		game.addVisual(menu)
		juegos.forEach{juego=>menu.agregarItem(juego)}
		menu.dibujar()
		keyboard.enter().onPressDo{self.juegoIniciar(menu.itemSeleccionado())}
		
	}
	
	method juegoIniciar(juego){
		game.clear()
		keyboard.q().onPressDo{self.juegoTerminar(juego)}
		juego.iniciar()
	}
	method juegoTerminar(juego){
		juego.terminar()
		game.clear()
		self.iniciar()
	}
}

class MenuIconos{
	var seleccionado = 1
	const ancho = 3
	const espaciado = 2
	const items = new Dictionary() 
	var posicionInicial
	
	method initialize(){
		keyboard.up().onPressDo{self.arriba()}
		keyboard.down().onPressDo{self.abajo()}
		keyboard.right().onPressDo{self.derecha()}
		keyboard.left().onPressDo{self.izquierda()}
	}
	
	method agregarItem(item){
		items.put(items.size()+1, item)
	}

	method dibujar(){
		items.forEach{indice,visual => 
			visual.position(self.posicionDe(indice))
			game.addVisual(visual)
		}
	}
	
	method horizontal(indice) = (indice-1)% ancho * espaciado
	method vertical(indice) = (indice-1).div(ancho) * espaciado
	
	method posicionDe(indice) =
		posicionInicial
			.up(self.vertical(indice))
			.right(self.horizontal(indice))

	method itemSeleccionado() = items.get(seleccionado)
	method image() = "cursor.png"
	method position() = self.posicionDe(seleccionado)

	method abajo(){
		if(seleccionado > ancho) seleccionado = seleccionado - ancho	
	}
	method arriba(){
		if(seleccionado + ancho <= items.size()) seleccionado = seleccionado + ancho	
	}
	method derecha(){
		seleccionado = (seleccionado + 1).min(items.size())
	}
	method izquierda(){
		seleccionado = (seleccionado - 1).max(1)
	}
}