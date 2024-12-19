import UIKit

class MenuPrincipalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnListarGenero(_ sender: UIButton) {
        performSegue(withIdentifier: "listarGenero", sender: nil)
    }
    
    @IBAction func btnListarPelicula(_ sender: UIButton) {
        performSegue(withIdentifier: "listarPelicula", sender: nil)
    }
    
    @IBAction func btnListarGoats(_ sender: UIButton) {
        performSegue(withIdentifier: "listarGoats", sender: nil)
    }
    @IBAction func btnVolverLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "volverLogin", sender: nil)
    }
    
    
}
