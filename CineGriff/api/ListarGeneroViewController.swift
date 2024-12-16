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
    AF.request("https://cinegriffapi-production.up.railway.app/api/genero/listar").responseDecodable(of: [Genero].self) { response in
        
        guard let generos = response.value else {
            print("Error al obtener los géneros")
            return
        }
        
        self.lista = generos.sorted { $0.codigoGenero < $1.codigoGenero }
        
        self.tvGenero.reloadData()
        }
    }

    func buscarGenero(nombreGenero: String) {
        
        let searchText = nombreGenero.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if searchText.isEmpty {
            listaFiltrada = lista
        } else {
            listaFiltrada = lista.filter { genero in
                return genero.nombreGenero.lowercased().contains(searchText)
            }
        }
        
        self.buscando = true
        self.tvGenero.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let textoBusqueda = searchBar.text {
            buscarGenero(nombreGenero: textoBusqueda)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            listaFiltrada = lista
            buscando = false
        } else {
            buscarGenero(nombreGenero: searchText)
        }
        tvGenero.reloadData()
    }
    
    @IBAction func btnNuevoGenero(_ sender: UIButton) {
        performSegue(withIdentifier: "registrarGenero", sender: nil)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalleGenero", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleGenero" {
            let pantallaDetalleGenero = segue.destination as! DetalleGeneroViewController
            pantallaDetalleGenero.genero = lista[tvGenero.indexPathForSelectedRow!.row]
        }
    }

}
