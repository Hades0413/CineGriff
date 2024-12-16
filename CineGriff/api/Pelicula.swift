
import UIKit

struct Pelicula: Codable {

    var codigoPelicula:Int
    var tituloPelicula:String
    var descripcionPelicula:String
    var duracionPelicula:String
    var directorPelicula:String
    var genero: Genero 
    var fechaEstrenoPelicula:String
    var clasificacionEdad:Int

}
