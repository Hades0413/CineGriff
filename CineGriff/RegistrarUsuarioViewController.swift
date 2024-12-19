import UIKit
import Alamofire
import FirebaseAuth
import FirebaseFirestore

class RegistrarUsuarioViewController: UIViewController {

    // Hero
    @IBOutlet weak var LoginBackground: UIImageView!
    @IBOutlet weak var GradientView: UIView!
    @IBOutlet weak var HeroTitle: UILabel!
    
    // LoginForm
    @IBOutlet weak var LoginFormView: UIView!
 
    //Datos Usuario
    @IBOutlet weak var txtUsernameUsuario: UITextField!
    @IBOutlet weak var txtNombreUsuario: UITextField!
    @IBOutlet weak var txtApellidoUsuario: UITextField!
    @IBOutlet weak var txtCorreoUsuario: UITextField!
    @IBOutlet weak var txtContrasenaUsuario: UITextField!
    
    //Botones
    @IBOutlet weak var btnRegistrar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIRegistrarUsuario()
    }
    
    
    func registrarUsuarioAPI(bean:Usuario){
        AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/register",
                       method: .post,
                       parameters: bean,
                       encoder: JSONParameterEncoder.default)
                .response { data in
                    switch data.result {
                    case .success(let info):
                        if let jsonString = String(data: info!, encoding: .utf8) {
                            print("Respuesta JSON: \(jsonString)")  // Imprime la respuesta JSON para verificación
                        }
                        do {
                            // Intentamos decodificar como respuesta de éxito (ResponseMessage)
                            let response = try JSONDecoder().decode(SuccessResponse.self, from: info!)
                            
                            if response.status == 201 {
                                // Si la respuesta es exitosa (status 201), mostramos el mensaje de éxito
                                self.ventana2("Usuario registrado exitosamente con mensaje: \(response.message)")
                            } else {
                                // Si el estado es otro, mostramos el mensaje de error
                                self.ventana("Error: \(response.message)")
                            }
                        } catch {
                            print("Error en el JSON al intentar decodificar como ResponseMessage: \(error)")
                            
                            do {
                                // Intentamos decodificar como respuesta de error (ErrorResponse)
                                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: info!)
                                // Si la respuesta es de error, mostramos el mensaje de error correspondiente
                                self.ventana("Error: \(errorResponse.message)")
                            } catch {
                                // Si no se puede decodificar como ErrorResponse, mostramos un mensaje genérico
                                print("Error en el JSON: \(error)")
                                self.ventana("Hubo un error al registrar el usuario. Intenta nuevamente.")
                            }
                        }
                    case .failure(let error as NSError):
                        // Manejar el error de la solicitud
                        print("Error en la solicitud: \(error)")
                        self.ventana("Hubo un problema al procesar la solicitud.")
                    }
                }
        }
    

    @IBAction func btnRegistrarUsuario(_ sender: UIButton) {
        let username=txtUsernameUsuario.text ?? ""
        let nom=txtNombreUsuario.text ?? ""
        let ape=txtApellidoUsuario.text ?? ""
        let correo=txtCorreoUsuario.text ?? ""
        let contra=txtContrasenaUsuario.text ?? ""
        let obj=Usuario(codigoUsuario: 0, usernameUsuario: username, nombreUsuario: nom, apellidoUsuario: ape, correoUsuario: correo, contrasenaUsuario: contra, isadminUsuario: 0)
        registrarUsuarioAPI(bean: obj)
    }
    
    @IBAction func btnShowLogin(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    func ventana(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(pantalla, animated: true)
    }
    
    func ventana2(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "login", sender: nil)
        }))
        present(pantalla, animated: true)
    }
    
}
