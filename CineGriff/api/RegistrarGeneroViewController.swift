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
    
    
    func registrarGenero(gen: Genero) {
        AF.request("https://cinegriffapi-production.up.railway.app/api/genero/register", method: .post, parameters: gen, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success(let data):
                // Decodificar la respuesta de la API
                if let jsonResponse = data as? [String: Any], let statusCode = jsonResponse["status"] as? Int {
                    // Verificar el código de estado de la respuesta para decidir el mensaje a mostrar
                    switch statusCode {
                    case 201:
                        // Género registrado con éxito
                        self.ventana("Género guardado con éxito.")
                    case 400:
                        // Error en la validación
                        if let errorMessage = jsonResponse["message"] as? String {
                            self.ventana("Error: \(errorMessage)")
                        }
                    case 409:
                        // El género ya existe
                        if let errorMessage = jsonResponse["message"] as? String {
                            self.ventana("Error: \(errorMessage)")
                        }
                    default:
                        self.ventana("Error desconocido, por favor intente de nuevo.")
                    }
                }
                
            case .failure(let error):
                // Error de red o conexión
                self.ventana("Error al intentar registrar el género: \(error.localizedDescription)")
            }
        }
    }

    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverListarGenero1", sender: nil)
    }
    
    func ventana(_ msg: String) {
        // Crear objeto de alerta
        let pantalla = UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        // Agregar botón dentro de la pantalla
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            self.performSegue(withIdentifier: "volverListarGenero1", sender: nil)
        }))
        // Mostrar "pantalla"
        present(pantalla, animated: true)
    }
    
}
