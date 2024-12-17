import UIKit
import Alamofire
class RegistrarPeliculaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var txtTitulo: UITextField!
    
    @IBOutlet weak var txtDescripcion: UITextField!
    
    @IBOutlet weak var txtDuracion: UITextField!
    
    @IBOutlet weak var txtDirector: UITextField!
    
    @IBOutlet weak var txtClasificacion: UITextField!
    
    @IBOutlet weak var dpFechaEstreno: UIDatePicker!
    
    @IBOutlet weak var pvGenero: UIPickerView!
    
    @IBOutlet weak var imgBannerPelicula: UIImageView!
    
    
    var generos: [Genero] = []
    var generoSeleccionado: Genero?
    
    var nombreImagenSeleccionada: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIRegistrarPelicula()
        
        pvGenero.delegate=self
        pvGenero.dataSource=self
        
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
                self.pvGenero.reloadAllComponents()
            }
        }
    
    func registrarPelicula(bean:Pelicula){
        AF.request("https://cinegriffapi-production.up.railway.app/api/pelicula/register",method: .post, parameters: bean, encoder: JSONParameterEncoder.default).response(completionHandler: { data in
            switch data.result{
                case .success(let info):
                do{
                    let obj =
                    try JSONDecoder().decode(Pelicula.self, from: info!)
                    self.ventana("Pelicula guardada con Codigo: \(obj.codigoPelicula)")
                }catch{
                    print("Error en el JSON")
                }
                case .failure(let error as NSError):
                print("Error al registrar la película: \(error)")
            }
        })
    }
    
    
    
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }


    @IBAction func btnRegistrarPelicula(_ sender: UIButton) {
        let cod = 0
        let tit = String(txtTitulo.text ?? "0")
        let des = String(txtDescripcion.text ?? "0")
        let dur = String(txtDuracion.text ?? "0")
        let dir = String(txtDirector.text ?? "0")
        let cla = Int(txtClasificacion.text ?? "0") ?? 0
        let fec = formatDateToString(dpFechaEstreno.date)
        let img = nombreImagenSeleccionada ?? ""
            guard let gen = generoSeleccionado else {
                print("Por favor, complete todos los campos.");
                return
            }
            
            let obj = Pelicula(
                codigoPelicula: cod,
                tituloPelicula: tit,
                descripcionPelicula: des,
                duracionPelicula: dur,
                directorPelicula: dir,
                genero: gen,
                fechaEstrenoPelicula: fec,
                clasificacionEdad: cla,
                bannerPelicula: img
            )
            
            registrarPelicula(bean: obj)
    }
    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverListarPelicula1", sender: nil)
    }
    
    
    @IBAction func btnSubirIMG(_ sender: UIButton) {
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
                imgBannerPelicula.image = selectedImage
                
                // Intentamos obtener la URL del archivo de la imagen
                if let imageURL = info[.imageURL] as? URL {
                    // Extraemos el nombre de la imagen desde la URL
                    nombreImagenSeleccionada = imageURL.lastPathComponent
                }
            }
            dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnActualizarPelicula(_ sender: UIButton) {
    }
    
    @IBAction func btnEliminarPelicula(_ sender: UIButton) {
    }
    
    
    func ventana(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "volverListarPelicula1", sender: nil)
        }))
        present(pantalla, animated: true)
    }
    
}
