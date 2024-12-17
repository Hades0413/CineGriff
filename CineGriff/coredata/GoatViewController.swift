
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
    
    func datos(){
        lista.append(Goat(codigoEstudiante: 1, nombreEstudiante: "Eduardo Miguel", apellidoEstudiante: "Jaime Gomero", correoEstudiante: "i202214869@cibertec.edu.pe"))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count //cantidad de elementos que hay dentro del arreglo de lista
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //crear objeto de la clase ItemTableViewCell
        let fila = tvGoat.dequeueReusableCell(withIdentifier: "row") as! ItemGoatTableViewCell
        
        fila.lblCodigo.text = String(lista[indexPath.row].codigoEstudiante)
        fila.lblNombre.text = lista[indexPath.row].nombreEstudiante
        fila.lblApellido.text = lista[indexPath.row].apellidoEstudiante
        fila.lblCorreo.text = lista[indexPath.row].correoEstudiante
        
        return fila
    }

}
