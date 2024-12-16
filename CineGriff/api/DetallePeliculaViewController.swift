import UIKit

class DetallePeliculaViewController: UIViewController {
    
    
    @IBOutlet weak var imgDetallePelicula: UIImageView!
    
    @IBOutlet weak var lblDetalleTitulo: UILabel!
    
    @IBOutlet weak var lblDetalleDescripcion: UILabel!
    
    @IBOutlet weak var lblDetalleDuracion: UILabel!
    
    @IBOutlet weak var lblDetalleDirector: UILabel!
    
    @IBOutlet weak var lblDetalleGenero: UILabel!
    
    @IBOutlet weak var lblDetalleFechaEstreno: UILabel!
    
    @IBOutlet weak var lblDetalleClasificacion: UILabel!
    
    var pelicula:Pelicula!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgDetallePelicula.image=UIImage(named: pelicula.tituloPelicula)
        lblDetalleTitulo.text=pelicula.tituloPelicula
        lblDetalleDescripcion.text=pelicula.descripcionPelicula
        lblDetalleDuracion.text=pelicula.duracionPelicula
        lblDetalleDirector.text=pelicula.directorPelicula
        lblDetalleGenero.text=pelicula.genero.nombreGenero
        lblDetalleFechaEstreno.text=pelicula.fechaEstrenoPelicula
        lblDetalleClasificacion.text=String(pelicula.clasificacionEdad)

    }
    

    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverListarPelicula2", sender: nil)
    }
    

}
