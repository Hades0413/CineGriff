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
    
    func login(correoUsuario:String,contrasenaUsuario:String){
        Auth.auth().signIn(withEmail: correoUsuario, password: contrasenaUsuario){ data,error in
            if let info=data{
                self.ventana2("Inicio de Sesion exitoso")
            } else{
                self.ventana("Correo y/o Contraseña incorrectos")
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

