
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
        tvGoat.rowHeight=500
        //asignar delegado a la tabla
        tvGoat.delegate=self
    }
    
    func datos() {
    lista.append(Goat(codigoEstudiante: 1, 
                       nombreEstudiante: "Jorge Fabrizio", 
                       apellidoEstudiante: "Olano Farfan", 
                       correoEstudiante: "i202214869@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: 2, 
                       nombreEstudiante: "Marcelo Adrian", 
                       apellidoEstudiante: "Liendo Soto", 
                       correoEstudiante: "i202214870@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: 3, 
                       nombreEstudiante: "Claudia Yadira", 
                       apellidoEstudiante: "Sifuentes Zevallos", 
                       correoEstudiante: "i202214871@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: 4, 
                       nombreEstudiante: "Adriana Sofia", 
                       apellidoEstudiante: "Casas Durand", 
                       correoEstudiante: "i202214872@cibertec.edu.pe"))
    
    lista.append(Goat(codigoEstudiante: 5, 
                       nombreEstudiante: "Eduardo Miguel", 
                       apellidoEstudiante: "Jaime Gomero", 
                       correoEstudiante: "i202214869@cibertec.edu.pe"))
}

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let fila = tvGoat.dequeueReusableCell(withIdentifier: "row") as! ItemGoatTableViewCell
    
    fila.lblCodigo.text = "Código: \(lista[indexPath.row].codigoEstudiante)"
    fila.lblNombre.text = "Nombre: \(lista[indexPath.row].nombreEstudiante)"
    fila.lblApellido.text = "Apellido: \(lista[indexPath.row].apellidoEstudiante)"
    fila.lblCorreo.text = "Correo: \(lista[indexPath.row].correoEstudiante)"
    
    return fila
}


}
