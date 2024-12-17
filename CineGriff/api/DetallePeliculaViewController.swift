import UIKit
import Alamofire

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

/* agregar botón actualizar y colocar esto
    @IBAction func btnActualizarPelicula(_ sender: UIButton) {
        let cod = pelicula.codigoPelicula
        let titulo = txtDetalleTitulo.text ?? ""
        let descripcion = txtDetalleDescripcion.text ?? ""
        let duracion = txtDetalleDuracion.text ?? ""
        let director = txtDetalleDirector.text ?? ""
        let genero = txtDetalleGenero.text ?? ""
        let fechaEstreno = txtDetalleFechaEstreno.text ?? ""
        let clasificacion = Int(txtDetalleClasificacion.text ?? "0") ?? 0
        
        // Actualizar el objeto película con los nuevos valores
        pelicula.tituloPelicula = titulo
        pelicula.descripcionPelicula = descripcion
        pelicula.duracionPelicula = duracion
        pelicula.directorPelicula = director
        pelicula.genero.nombreGenero = genero
        pelicula.fechaEstrenoPelicula = fechaEstreno
        pelicula.clasificacionEdad = clasificacion
        
        // Llamar al método para actualizar
        actualizarPelicula(cod: cod, bean: pelicula)
    }
   */ 

func actualizarPelicula(cod: Int, bean: Pelicula) {
        AF.request("https://cinegriffapi-production.up.railway.app/api/pelicula/" + String(cod),
                   method: .put,
                   parameters: bean,
                   encoder: JSONParameterEncoder.default).response { data in
            switch data.result {
            case .success:
                self.ventana1("Película actualizada correctamente")
            case .failure(let error as NSError):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func btnEliminarPelicula(_ sender: UIButton) {
        let pantalla=UIAlertController(title: "Sistema", message: "Desea eliminar este Pelicula?", preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.eliminarPelicula(cod: self.pelicula.codigoPelicula)
        }))
        pantalla.addAction(UIAlertAction(title: "Cancelar", style: .cancel  ))
        present(pantalla, animated: true)
    }
    
    func eliminarPelicula(cod:Int){
        AF.request("https://cinegriffapi-production.up.railway.app/api/pelicula/"+String(cod),method: .delete).response(completionHandler: { data in
            switch data.result{
            case .success:
                self.ventana1("Pelicula eliminado correctamente")
                case .failure(let error as NSError):
                print(error.localizedDescription)
            }
        })
        
    }
    
    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverListarPelicula2", sender: nil)
    }
    
    func ventana1(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "volverListarPelicula2", sender: nil)
        }))
        present(pantalla, animated: true)
    }
    

}
