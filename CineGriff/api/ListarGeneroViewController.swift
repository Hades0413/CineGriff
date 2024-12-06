//
//  ListarGeneroViewController.swift
//  CineGriff
//
//  Created by mals on 6/12/24.
//

import UIKit

class ListarGeneroViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    
    
    @IBOutlet weak var tvGenero: UITableView!
    
    @IBOutlet weak var sbBuscarGenero: UISearchBar!
    
    var lista:[Genero]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvGenero.dataSource = self
        tvGenero.delegate = self
        tvGenero.rowHeight = 130
    }
    
    func listarGenero(){}
    
    func buscarGenero(nombre_Genero: String)->[Genero]{
        
    }
    
    @IBAction func btnNuevoGenero(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
