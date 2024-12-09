//
//  ListarPeliculaViewController.swift
//  CineGriff
//
//  Created by mals on 8/12/24.
//

import UIKit
import Alamofire

class ListarPeliculaViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var cvPelicula: UICollectionView!
    
    @IBOutlet weak var sbBuscarTitulo: UISearchBar!
    
    var lista:[Pelicula]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func btnPelicula(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lista.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fila=collectionView.dequeueReusableCell(withReuseIdentifier: "row", for: indexPath) as! ItemPeliculaCollectionViewCell
        let pelicula = lista[indexPath.row]
        
        fila.lblTituloPelicula.text = pelicula.tituloPelicula
        fila.lblFechaEstrenoPelicula.text = ""
        //fila.imgPelicula.image = pelicula.imagenPelicula ?? UIImage(named: "placeholder")
        
        return fila
    }
    
}
