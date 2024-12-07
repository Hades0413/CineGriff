//
//  ListarGeneroViewController.swift
//  CineGriff
//
//  Created by mals on 6/12/24.
//

import UIKit

class ListarGeneroViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate  {
    
    
    
    @IBOutlet weak var tvGenero: UITableView!
    
    @IBOutlet weak var sbBuscarGenero: UISearchBar!
    
    var lista: [Genero] = [
            Genero(codigo_Genero: 1, nombre_Genero: "Acción"),
            Genero(codigo_Genero: 2, nombre_Genero: "Comedia"),
            Genero(codigo_Genero: 3, nombre_Genero: "Drama"),
            Genero(codigo_Genero: 4, nombre_Genero: "Terror"),
            Genero(codigo_Genero: 5, nombre_Genero: "Ciencia Ficción")
        ]
        var listaFiltrada: [Genero] = []
        var buscando: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvGenero.dataSource = self
        tvGenero.delegate = self
        tvGenero.rowHeight = 130
        
        sbBuscarGenero.delegate = self
    }
    
    func listarGenero(){}
    
    func buscarGenero(nombre_Genero: String)->[Genero]{
        return lista.filter { $0.nombre_Genero.lowercased().contains(nombre_Genero.lowercased()) }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                buscando = false
                listaFiltrada = []
            } else {
                buscando = true
                listaFiltrada = buscarGenero(nombre_Genero: searchText)
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
        
        fila.lblCodigoGenero.text = String(genero.codigo_Genero)
        fila.lblNombreGenero.text = genero.nombre_Genero
        return fila
    }

}
