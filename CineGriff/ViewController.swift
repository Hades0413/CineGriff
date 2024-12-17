import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    //Hero
    @IBOutlet weak var GradientView: UIView!
    @IBOutlet weak var HeroTitle: UILabel!
    @IBOutlet weak var LoginBackground: UIImageView!
    
    //LoginForm
    @IBOutlet weak var LoginFormView: UIView!
    
    
    //Datos Usuario
    @IBOutlet weak var txtCorreoUsuario: UITextField!
    @IBOutlet weak var txtContrasenaUsuario: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUILogin()
        txtContrasenaUsuario.isSecureTextEntry = true
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let correo=txtCorreoUsuario.text ?? ""
        let contra=txtContrasenaUsuario.text ?? ""
        login(correoUsuario: correo, contrasenaUsuario: contra)
    }
    
    func login(correoUsuario: String, contrasenaUsuario: String) {
        Auth.auth().signIn(withEmail: correoUsuario, password: contrasenaUsuario) { data, error in
            if let info = data {
                self.ventana2("Inicio de sesión exitoso")
                self.verificarUsuarioEnAPI(uid: info.user.uid, correoUsuario: correoUsuario)
            } else {
                self.ventana("Correo y/o Contraseña incorrectos")
            }
        }
    }
    
    // Verifica si el usuario ya existe en la API y Firestore, si no, lo crea.
    func verificarUsuarioEnAPI(uid: String, correoUsuario: String) {
        // Consultar la API para obtener el último usuario
        AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/listar")
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let usuarios = try JSONDecoder().decode([Usuario].self, from: data)
                            if let ultimoUsuario = usuarios.last {
                                let nuevoCodigoUsuario = ultimoUsuario.codigoUsuario + 1
                                self.registrarUsuarioEnAPI(uid: uid, correoUsuario: correoUsuario, codigoUsuario: nuevoCodigoUsuario)
                                self.registrarUsuarioEnFirestore(uid: uid, correoUsuario: correoUsuario, codigoUsuario: nuevoCodigoUsuario)
                            }
                        } catch {
                            print("Error al decodificar la respuesta de la API")
                        }
                    }
                case .failure(let error):
                    print("Error al consultar la API: \(error)")
                }
            }
    }

    // Registra al usuario en la API
    func registrarUsuarioEnAPI(uid: String, correoUsuario: String, codigoUsuario: Int) {
        let usuario = Usuario(codigoUsuario: codigoUsuario, usernameUsuario: uid, nombreUsuario: "", apellidoUsuario: "", correoUsuario: correoUsuario, contrasenaUsuario: "", isadminUsuario: 0)
        
        AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/register",
                   method: .post,
                   parameters: usuario,
                   encoder: JSONParameterEncoder.default)
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let obj = try JSONDecoder().decode(Usuario.self, from: data)
                            print("Usuario guardado en API con Código: \(obj.codigoUsuario)")
                        } catch {
                            print("Error en la respuesta JSON")
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }

    // Registra al usuario en Firestore
    func registrarUsuarioEnFirestore(uid: String, correoUsuario: String, codigoUsuario: Int) {
        let BD = Firestore.firestore()
        BD.collection("usuario").document(uid).setData([
            "usernameUsuario": uid,
            "nombreUsuario": "",
            "apellidoUsuario": "",
            "correoUsuario": correoUsuario,
            "codigoUsuario": codigoUsuario,
            "isadminUsuario": 0
        ]) { error in
            if let error = error {
                print("Error en el registro en Firestore: \(error.localizedDescription)")
            } else {
                print("Usuario registrado en Firestore")
            }
        }
    }


    @IBAction func btnShowRegistrar(_ sender: Any) {
        performSegue(withIdentifier: "registrarUsuario", sender: self)
        
    }
    
    func ventana(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(pantalla, animated: true)
    }
    
    func ventana2(_ msg:String){
        //crear objeto pantalla
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        //adiciona boton dentro de la pantalla
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "menuPrincipal", sender: nil)
        }))
        //mostrar "pantalla"
        present(pantalla, animated: true)
    }
    
}

