import UIKit
import Alamofire

class DetalleGeneroViewController: UIViewController {

    @IBOutlet weak var txtCodigoGenero: UITextField!
    
    @IBOutlet weak var txtNombreGenero: UITextField!
    
    var genero:Genero!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCodigoGenero.text=String(genero.codigoGenero)
        txtCodigoGenero.isEnabled=false
        
        txtNombreGenero.text=genero.nombreGenero
        
    }
    
    @IBAction func btnActualizarGenero(_ sender: UIButton) {
        let cod = genero.codigoGenero
        let nom = txtNombreGenero.text ?? "0"
        genero.nombreGenero=nom
        actualizarGenero(cod: cod, bean: genero)
    }
    
    func actualizarGenero(cod:Int,bean:Genero){
        AF.request("https://cinegriffapi-production.up.railway.app/api/genero/"+String(cod),method: .put, parameters: bean, encoder: JSONParameterEncoder.default).response(completionHandler: { data in
            switch data.result{
            case .success:
                self.ventana1("Género actualizado correctamente")
                case .failure(let error as NSError):
                print(error.localizedDescription)
            }
        })
    }
    
    @IBAction func btnEliminarGenero(_ sender: UIButton) {
        let pantalla=UIAlertController(title: "Sistema", message: "Desea eliminar este Género?", preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.eliminarGenero(cod: self.genero.codigoGenero)
        }))
        pantalla.addAction(UIAlertAction(title: "Cancelar", style: .cancel  ))
        present(pantalla, animated: true)
    }
    
    func eliminarGenero(cod:Int){
        AF.request("https://cinegriffapi-production.up.railway.app/api/genero/"+String(cod),method: .delete).response(completionHandler: { data in
            switch data.result{
            case .success:
                self.ventana1("Género eliminado correctamente")
                case .failure(let error as NSError):
                print(error.localizedDescription)
            }
        })
        
    }
    
    @IBAction func btnVolver2(_ sender: UIButton) {
        performSegue(withIdentifier: "volverListarGenero2", sender: nil)
    }
    
    func ventana1(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "volverListarGenero2", sender: nil)
        }))
        present(pantalla, animated: true)
    }
    
}
