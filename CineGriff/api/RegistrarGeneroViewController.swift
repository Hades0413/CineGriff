import UIKit
import Alamofire
class RegistrarGeneroViewController: UIViewController {
    
    
    @IBOutlet weak var txtNombreGenero: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Aplicar los estilossssssss
        setupUIRegistrarGenero()
    }
    
    @IBAction func btnGrabarGenero(_ sender: UIButton) {
        let cod = 0
        let nom = String(txtNombreGenero.text ?? "0")
        let obj = Genero(codigoGenero: cod, nombreGenero: nom)
        registrarGenero(gen: obj)
    }
    
    
func registrarGenero(gen: Genero) {
    AF.request("https://cinegriffapi-production.up.railway.app/api/genero/register",
               method: .post,
               parameters: gen,
               encoder: JSONParameterEncoder.default)
        .response { response in
            if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                print("Respuesta de la API: \(jsonString)")
            } else {
                print("No se recibió respuesta o los datos están vacíos.")
            }

            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 201:
                    // Procesar la respuesta de éxito
                    if let data = response.data {
                        self.decodeSuccessResponse(data: data)
                    } else {
                        print("Error: no se recibieron datos de respuesta con código 201.")
                        self.ventana("Error: no se recibieron datos de respuesta.")
                    }

                case 400, 409:
                    // Procesar errores
                    if let data = response.data {
                        self.decodeErrorResponse(data: data)
                    } else {
                        print("Error: no se recibieron datos de error con código \(statusCode).")
                        self.ventana("Error: no se recibieron datos de error.")
                    }

                default:
                    self.ventana("Error desconocido: \(statusCode)")
                }
            } else {
                self.ventana("No se recibió un código de estado válido.")
            }
        }
}


        
        // Decodificación para respuesta de éxito (201)
        func decodeSuccessResponse(data: Data?) {
    guard let data = data else {
        self.ventana("No se recibió respuesta válida.")
        return
    }

    do {
        let successResponse = try JSONDecoder().decode(SuccessResponse.self, from: data)
        self.ventana("Género registrado con éxito: \(successResponse.status)")
    } catch let error {
        print("Error al procesar la respuesta de éxito: \(error.localizedDescription)")
        self.ventana("Error al procesar la respuesta de éxito.")
    }
}

func decodeErrorResponse(data: Data?) {
    guard let data = data else {
        self.ventana("No se recibió respuesta válida.")
        return
    }

    do {
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
        
        if errorResponse.code == 409 {
            self.ventana("Error: \(errorResponse.message)")
        } else {
            self.ventana("Error desconocido: \(errorResponse.message)")
        }
    } catch let error {
        // Imprimir el error de decodificación para depuración
        print("Error al procesar la respuesta de error: \(error.localizedDescription)")
        self.ventana("Error al procesar la respuesta de error.")
    }
}

        


    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverListarGenero1", sender: nil)
    }
    
    func ventana(_ msg: String) {
            // Crear objeto de alerta y mostrarlo en el hilo principal
            DispatchQueue.main.async {
                let pantalla = UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
                pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    self.performSegue(withIdentifier: "volverListarGenero1", sender: nil)
                }))
                self.present(pantalla, animated: true)
            }
        }
    
}
