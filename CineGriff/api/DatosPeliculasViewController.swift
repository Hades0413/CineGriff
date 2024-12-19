//
//  DatosPeliculasViewController.swift
//  CineGriff
//
//  Created by mals on 17/12/24.
//

import UIKit
import Alamofire

class DatosPeliculasViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var lblCodigoPeli: UILabel!
    
    @IBOutlet weak var imgBannerPeli: UIImageView!
    
    @IBOutlet weak var txtTituloPeli: UITextField!
    
    @IBOutlet weak var txtDescripcionPeli: UITextField!
    
    @IBOutlet weak var txtDuracionPeli: UITextField!
    
    @IBOutlet weak var txtFechaEstrenoPeli: UITextField!
    
    @IBOutlet weak var txtDirectorPeli: UITextField!
    
    @IBOutlet weak var txtClasificacionPeli: UITextField!
    
    @IBOutlet weak var txtGeneroPeli: UITextField!
    
    @IBOutlet weak var pvGeneroPeli: UIPickerView!
    
    var pelicula:Pelicula!
    
    var generos: [Genero] = []
    
    var generoSeleccionado: Genero?
    
    var nombreImagenSeleccionada: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUIDatosPelicula()
        
        
        
        
        pvGeneroPeli.delegate=self
        pvGeneroPeli.dataSource=self
        
        lblCodigoPeli.text=String(pelicula.codigoPelicula)
        imgBannerPeli.image=UIImage(named: pelicula.tituloPelicula)
        txtTituloPeli.text=pelicula.tituloPelicula
        txtDescripcionPeli.text=pelicula.descripcionPelicula
        txtDuracionPeli.text=pelicula.duracionPelicula
        txtDirectorPeli.text=pelicula.directorPelicula
        txtGeneroPeli.text=pelicula.genero.nombreGenero
        txtGeneroPeli.isEnabled=false
        txtFechaEstrenoPeli.text=pelicula.fechaEstrenoPelicula
        txtClasificacionPeli.text=String(pelicula.clasificacionEdad)
        
        cargarGeneros()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return generos.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return generos[row].nombreGenero
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        generoSeleccionado = generos[row]
    }
    
    func cargarGeneros() {
            AF.request("https://cinegriffapi-production.up.railway.app/api/genero/listar").responseDecodable(of: [Genero].self) { response in
                guard let generos = response.value else {
                    print("Error al obtener los géneros")
                    return
                }
                self.generos = generos
                self.pvGeneroPeli.reloadAllComponents()
            }
        }
    
    @IBAction func btnActualizarIMG(_ sender: UIButton) {
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
                imgBannerPeli.image = selectedImage
                if let imageURL = info[.imageURL] as? URL {
                    nombreImagenSeleccionada = imageURL.lastPathComponent
                }
            }
            dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnEliminarPelicula(_ sender: UIButton) {
        let pantalla=UIAlertController(title: "Sistema", message: "Desea eliminar este Pelicula?", preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.eliminarPelicula(cod: self.pelicula.codigoPelicula)
        }))
        pantalla.addAction(UIAlertAction(title: "Cancelar", style: .cancel  ))
        present(pantalla, animated: true)
    }
    
    func eliminarPelicula(cod:Int){
        AF.request("https://cinegriffapi-production.up.railway.app/api/pelicula/"+String(cod),method: .delete).response(completionHandler: { data in
            switch data.result{
            case .success:
                self.ventana1("Pelicula eliminado correctamente")
                case .failure(let error as NSError):
                print(error.localizedDescription)
            }
        })
        
    }
    
    @IBAction func btnActualizarPelicula(_ sender: UIButton) {
        let cod = pelicula.codigoPelicula
        let titulo = txtTituloPeli.text ?? ""
        let descripcion = txtDescripcionPeli.text ?? ""
        let duracion = txtDuracionPeli.text ?? ""
        let director = txtDirectorPeli.text ?? ""
        let fechaEstreno = txtFechaEstrenoPeli.text ?? ""
        let clasificacion = Int(txtClasificacionPeli.text ?? "0") ?? 0
        guard let genero = generoSeleccionado else {
            print("Por favor, complete todos los campos.");
            return
        }
        let img = nombreImagenSeleccionada ?? ""
        
        // Actualizar el objeto película con los nuevos valores
        let obj = Pelicula(
            codigoPelicula: cod,
            tituloPelicula: titulo,
            descripcionPelicula: descripcion,
            duracionPelicula: duracion,
            directorPelicula: director,
            genero: genero,
            fechaEstrenoPelicula: fechaEstreno,
            clasificacionEdad: clasificacion,
            bannerPelicula: img
        )
        
        actualizarPelicula(cod: cod, bean: obj)
    }
    
    func actualizarPelicula(cod: Int, bean: Pelicula) {
            AF.request("https://cinegriffapi-production.up.railway.app/api/pelicula/" + String(cod),
                       method: .put,
                       parameters: bean,
                       encoder: JSONParameterEncoder.default).response { data in
                switch data.result {
                case .success:
                    self.ventana1("Película actualizada correctamente")
                case .failure(let error as NSError):
                    print(error.localizedDescription)
                }
            }
        }
    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volver1", sender: nil)
    }
    
    func ventana1(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "volver1", sender: nil)
        }))
        present(pantalla, animated: true)
    }
    
}
