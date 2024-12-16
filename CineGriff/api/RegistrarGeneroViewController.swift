import UIKit
import Alamofire
class RegistrarGeneroViewController: UIViewController {
    
    
    @IBOutlet weak var txtNombreGenero: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnGrabarGenero(_ sender: UIButton) {
        let cod = 0
        let nom = String(txtNombreGenero.text ?? "0")
        let obj = Genero(codigoGenero: cod, nombreGenero: nom)
        registrarGenero(gen: obj)
    }
    
    func registrarGenero(gen:Genero){
        AF.request("https://cinegriffapi-production.up.railway.app/api/genero/register",method: .post, parameters: gen, encoder: JSONParameterEncoder.default).response(completionHandler: { data in
            switch data.result{
                case .success(let info):
                do{
                    let obj =
                    try JSONDecoder().decode(Genero.self, from: info!)
                    self.ventana("Gènero guardado con Codigo: \(obj.codigoGenero)")
                }catch{
                    print("Error en el JSON")
                }
                case .failure(let error as NSError):
                    print(error)
            }
            
        })
    }
    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverListarGenero1", sender: nil)
    }
    
    func ventana(_ msg:String){
        //crear objeto pantalla
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        //adiciona boton dentro de la pantalla
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "volverListarGenero1", sender: nil)
        }))
        //mostrar "pantalla"
        present(pantalla, animated: true)
    }
    
}
