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
        
        //styles -> RegistrarUsuarioUIStyling
        setupUIRegistrarUsuario()
    }
    
    func crearUsuario(codigoUsuario:String,usernameUsuario:String,nombreUsuario:String,apellidoUsuario:String){
        
        let BD=Firestore.firestore()
        BD.collection("usuario").document(codigoUsuario).setData([
            "usernameUsuario": usernameUsuario,
            "nombreUsuario": nombreUsuario,
            "apellidoUsuario": apellidoUsuario,

        ]){
            data in
            if let info=data{
                self.ventana("Error en el registro de Usuario")
            } else{
                self.ventana("Usuario registrado exitosamente")
            }
        }
        
    }
    
    func registrarUsuarioFB(username:String,nombre:String,apellido:String,correo:String,contra:String){
        Auth.auth().createUser(withEmail: correo, password: contra){ data,error in
            if let info=data{
                let codigo=info.user.uid
                self.ventana("Usuario registrado correctamente")
                self.crearUsuario(codigoUsuario: codigo, usernameUsuario: username, nombreUsuario: nombre, apellidoUsuario: apellido)
            } else{
                self.ventana("Error en el registro de Usuario")
            }
        }
    }
    
    func registrarUsuarioAPI(bean:Usuario){
            AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/register",method: .post, parameters: bean, encoder: JSONParameterEncoder.default).response(completionHandler: { data in
                switch data.result{
                    case .success(let info):
                    do{
                        let obj =
                        try JSONDecoder().decode(Usuario.self, from: info!)
                        self.ventana("Gènero guardado con Codigo: \(obj.codigoUsuario)")
                    }catch{
                        print("Error en el JSON")
                    }
                    case .failure(let error as NSError):
                        print(error)
                }
                
            })
        }
    

    @IBAction func btnRegistrarUsuario(_ sender: UIButton) {
        let username=txtUsernameUsuario.text ?? ""
        let nom=txtNombreUsuario.text ?? ""
        let ape=txtApellidoUsuario.text ?? ""
        let correo=txtCorreoUsuario.text ?? ""
        let contra=txtContrasenaUsuario.text ?? ""
        let obj=Usuario(codigoUsuario: 0, usernameUsuario: username, nombreUsuario: nom, apellidoUsuario: ape, correoUsuario: correo, contrasenaUsuario: contra, isadminUsuario: 0)
        registrarUsuarioFB(username: username, nombre: nom, apellido: ape, correo: correo, contra: contra)
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
    
    
}
