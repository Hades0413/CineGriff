
import UIKit

class GoatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tvGoat: UITableView!
    
    var lista:[Goat]=[]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datos()

        //indicar que la tabla tiene origen de datos
        tvGoat.dataSource = self
        //establecer alto de la celda
        tvGoat.rowHeight=320
        //asignar delegado a la tabla
        tvGoat.delegate=self
    }
    
    func datos() {
    lista.append(Goat(codigoEstudiante: "I202211470",
                       nombreEstudiante: "Jorge Fabrizio",
                       apellidoEstudiante: "Olano Farfan",
                       correoEstudiante: "I202211470@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: "I202212048",
                       nombreEstudiante: "Marcelo Adrian",
                       apellidoEstudiante: "Liendo Soto",
                       correoEstudiante: "i202214870@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: "I202212046",
                       nombreEstudiante: "Claudia Yadira",
                       apellidoEstudiante: "Sifuentes Zevallos",
                       correoEstudiante: "I202212046@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: "I202217453",
                       nombreEstudiante: "Adriana Sofia",
                       apellidoEstudiante: "Casas Durand",
                       correoEstudiante: "i202214872@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: "I202214869",
                       nombreEstudiante: "Eduardo Miguel",
                       apellidoEstudiante: "Jaime Gomero",
                       correoEstudiante: "I202214869@cibertec.edu.pe"))
}

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let fila = tvGoat.dequeueReusableCell(withIdentifier: "row") as! ItemGoatTableViewCell
    
    fila.imgGoat.image=UIImage(named: lista[indexPath.row].nombreEstudiante)
    fila.lblCodigo.text = "Código: \(lista[indexPath.row].codigoEstudiante)"
    fila.lblNombre.text = "Nombre: \(lista[indexPath.row].nombreEstudiante)"
    fila.lblApellido.text = "Apellido: \(lista[indexPath.row].apellidoEstudiante)"
    fila.lblCorreo.text = "Correo: \(lista[indexPath.row].correoEstudiante)"
        
    
    return fila
}

    @IBAction func btnMenuPrincipal(_ sender: UIButton) {
        performSegue(withIdentifier: "home3", sender: nil)
    }

}
