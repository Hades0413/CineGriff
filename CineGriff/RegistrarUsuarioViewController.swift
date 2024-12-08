import UIKit

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

    
    

    @IBAction func btnRegistrarUsuario(_ sender: UIButton) {
    }
    
    @IBAction func btnShowLogin(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    
}
