import UIKit

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
    }
    
    @IBAction func btnLogin(_ sender: Any) {
    }
    
    @IBAction func btnShowRegistrar(_ sender: Any) {
        performSegue(withIdentifier: "registrarUsuario", sender: self)
        
    }
    
}

