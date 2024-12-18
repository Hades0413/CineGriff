import UIKit
import Alamofire

class ListarPeliculaViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UICollectionViewDelegate {
    
    @IBOutlet weak var cvPelicula: UICollectionView!
    
    @IBOutlet weak var sbBuscarTitulo: UISearchBar!
    
    var lista:[Pelicula]=[]
    var listaFiltrada: [Pelicula] = []
    var buscando: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listado()
        cvPelicula.delegate = self
        cvPelicula.dataSource = self
        sbBuscarTitulo.delegate = self
    }
    
    func listado() {
    AF.request("https://cinegriffapi-production.up.railway.app/api/pelicula/listar").responseDecodable(of: [Pelicula].self) { response in
        switch response.result {
        case .success(let peliculas):
            self.lista = peliculas.sorted { $0.codigoPelicula < $1.codigoPelicula }
            self.cvPelicula.reloadData()
        case .failure(let error):
            print("Error al obtener las películas: \(error.localizedDescription)")
        }
    }
    }

    
    func buscarTitulo(tituloPelicula: String) {
        
        let searchText = tituloPelicula.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if searchText.isEmpty {
            listaFiltrada = lista
        } else {
            listaFiltrada = lista.filter { pelicula in
                return pelicula.tituloPelicula.lowercased().contains(searchText)
            }
        }
        
        self.buscando = true
        self.cvPelicula.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let textoBusqueda = searchBar.text {
            buscarTitulo(tituloPelicula: textoBusqueda)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            listaFiltrada = lista
            buscando = false
        } else {
            buscarTitulo(tituloPelicula: searchText)
        }
        cvPelicula.reloadData()
    }
    
    @IBAction func btnPelicula(_ sender: UIButton) {
        performSegue(withIdentifier: "registrarPelicula", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buscando ? listaFiltrada.count : lista.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fila = collectionView.dequeueReusableCell(withReuseIdentifier: "row", for: indexPath) as! ItemPeliculaCollectionViewCell

        let pelicula = buscando ? listaFiltrada[indexPath.row] : lista[indexPath.row]

        fila.imgPelicula.image = UIImage(named: pelicula.tituloPelicula)
        fila.lblTituloPelicula.text = pelicula.tituloPelicula
        fila.lblFechaEstrenoPelicula.text = pelicula.fechaEstrenoPelicula

        return fila
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 161, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let peliculaSeleccionada: Pelicula
            if buscando {
                peliculaSeleccionada = listaFiltrada[indexPath.row]
            } else {
                peliculaSeleccionada = lista[indexPath.row] 
            }
        performSegue(withIdentifier: "datosPelicula", sender: peliculaSeleccionada)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "datosPelicula" {
            let pantallaDetallePelicula = segue.destination as! DatosPeliculasViewController
            if let pelicula = sender as? Pelicula {
                        pantallaDetallePelicula.pelicula = pelicula
            }
        }
    }
    
    
    @IBAction func btnHome1(_ sender: UIButton) {
        performSegue(withIdentifier: "home1", sender: nil)
    }
    
}
