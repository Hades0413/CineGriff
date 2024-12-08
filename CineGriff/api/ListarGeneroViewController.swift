import UIKit
import Alamofire

class ListarGeneroViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate  {
    
    
    
    @IBOutlet weak var tvGenero: UITableView!
    
    @IBOutlet weak var sbBuscarGenero: UISearchBar!
    
    var lista: [Genero] = []
    var listaFiltrada: [Genero] = []
    var buscando: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        listado()
        
        tvGenero.delegate = self
        tvGenero.dataSource = self
        tvGenero.rowHeight = 130
        sbBuscarGenero.delegate = self
    }
    
    func listado() {
        AF.request("http://localhost:8080/api/genero/listar").responseDecodable(of: [Genero].self) { response in
            
            guard let generos = response.value else {
                print("Error al obtener los géneros")
                return
            }
            self.lista = generos
            self.tvGenero.reloadData()
        }
    }

    func buscarGenero(nombreGenero: String) {
        guard !nombreGenero.isEmpty else {
            self.listaFiltrada = []
            self.tvGenero.reloadData()
            return
        }
        
        let url = "http://localhost:8080/api/genero/nombre/\(nombreGenero)"
        AF.request(url).responseDecodable(of: [Genero].self) { response in
            guard let generos = response.value else {
                print("Error al obtener el nombre del Género")
                return
            }
            self.listaFiltrada = generos
            self.tvGenero.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            buscando = false
            listaFiltrada = []
        } else {
            buscando = true
            buscarGenero(nombreGenero: searchText)
        }
        tvGenero.reloadData()
    }
    
    @IBAction func btnNuevoGenero(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buscando ? listaFiltrada.count : lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fila = tvGenero.dequeueReusableCell(withIdentifier: "row") as! ItemGeneroTableViewCell
        let genero = buscando ? listaFiltrada[indexPath.row] : lista[indexPath.row]
        fila.lblCodigoGenero.text = String(genero.codigoGenero)
        fila.lblNombreGenero.text = genero.nombreGenero
        return fila
    }

    // prepare para la navegación cuando se selecciona un género
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleGenero" {
            let pantallaDetalleGenero = segue.destination as! DetalleGeneroViewController
            pantallaDetalleGenero.genero = lista[tvGenero.indexPathForSelectedRow!.row]
        }
    }
    */

}
