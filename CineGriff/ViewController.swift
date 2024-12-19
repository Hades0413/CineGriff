import UIKit
import FirebaseAuth
import Alamofire
import FirebaseFirestore
import GoogleSignIn
import FirebaseFirestoreInternal
import Firebase
import Foundation


class ViewController: UIViewController {

    //Hero
    @IBOutlet weak var GradientView: UIView!
    @IBOutlet weak var HeroTitle: UILabel!
    @IBOutlet weak var LoginBackground: UIImageView!
    
    //LoginForm
    @IBOutlet weak var LoginFormView: UIView!
    
    
    //Datos Usuario
    @IBOutlet weak var txtCorreoUsuario: UITextField!
    @IBOutlet weak var txtContrasenaUsuario: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUILogin()
        txtContrasenaUsuario.isSecureTextEntry = true
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let correo=txtCorreoUsuario.text ?? ""
        let contra=txtContrasenaUsuario.text ?? ""
        login(correoUsuario: correo, contrasenaUsuario: contra)
    }
    
    
func login(correoUsuario: String, contrasenaUsuario: String) {
    Auth.auth().signIn(withEmail: correoUsuario, password: contrasenaUsuario) { data, error in
        if let info = data {
            self.ventana2("Inicio de sesión exitoso")
            self.verificarUsuarioEnAPI(uid: info.user.uid, correoUsuario: correoUsuario)
        } else {
            self.loginConAPI(correoUsuario: correoUsuario, contrasenaUsuario: contrasenaUsuario)
        }
    }
}

func loginConAPI(correoUsuario: String, contrasenaUsuario: String) {
    let parameters: [String: Any] = [
        "correoUsuario": correoUsuario,
        "usernameUsuario": correoUsuario.isValidEmail() ? nil : correoUsuario,
        "contrasenaUsuario": contrasenaUsuario
    ]
    
    AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/login", 
               method: .post, 
               parameters: parameters, 
               encoding: JSONEncoding.default)
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        
                        if loginResponse.status == 200 {
                            self.ventana2("Login exitoso con la API")
                            self.performSegue(withIdentifier: "menuPrincipal", sender: nil)
                        } else {
                            self.ventana("Login fallido en la API: \(loginResponse.message)")
                        }
                    } catch {
                        print("Error al decodificar la respuesta de la API: \(error)")
                        self.ventana("Error al procesar la respuesta de la API.")
                    }
                }
            case .failure(let error):
                print("Error al hacer login con la API: \(error.localizedDescription)")
                self.ventana("Error al hacer login con la API.")
            }
        }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "^[A-Za-z0-9+_.-]+@(.+)$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

    
    // Verifica si el usuario ya existe en la API y Firestore, si no, lo crea.
    func verificarUsuarioEnAPI(uid: String, correoUsuario: String) {
        // Consultar la API para obtener el último usuario
        AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/listar")
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let usuarios = try JSONDecoder().decode([Usuario].self, from: data)
                            if let ultimoUsuario = usuarios.last {
                                let nuevoCodigoUsuario = ultimoUsuario.codigoUsuario + 1
                                self.registrarUsuarioEnAPI(uid: uid, correoUsuario: correoUsuario, codigoUsuario: nuevoCodigoUsuario)
                                self.registrarUsuarioEnFirestore(uid: uid, correoUsuario: correoUsuario, codigoUsuario: nuevoCodigoUsuario)
                            }
                        } catch {
                            print("Error al decodificar la respuesta de la API")
                        }
                    }
                case .failure(let error):
                    print("Error al consultar la API: \(error)")
                }
            }
    }

    // Registra al usuario en la API
    func registrarUsuarioEnAPI(uid: String, correoUsuario: String, codigoUsuario: Int, nombreUsuario: String, apellidoUsuario: String) {
    let usuario = Usuario(codigoUsuario: codigoUsuario, usernameUsuario: uid, nombreUsuario: nombreUsuario, apellidoUsuario: apellidoUsuario, correoUsuario: correoUsuario, contrasenaUsuario: "", isadminUsuario: 0)
    
    AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/register",
               method: .post,
               parameters: usuario,
               encoder: JSONParameterEncoder.default)
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let obj = try JSONDecoder().decode(Usuario.self, from: data)
                        print("Usuario guardado en API con Código: \(obj.codigoUsuario)")
                    } catch {
                        print("Error en la respuesta JSON")
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
}



    // Registra al usuario en Firestore
    func registrarUsuarioEnFirestore(uid: String, correoUsuario: String, codigoUsuario: Int, nombreUsuario: String, apellidoUsuario: String) {
    let BD = Firestore.firestore()
    BD.collection("usuario").document(uid).setData([
        "usernameUsuario": nombreUsuario,
        "nombreUsuario": nombreUsuario,
        "apellidoUsuario": apellidoUsuario,
        "correoUsuario": correoUsuario,
        "codigoUsuario": codigoUsuario,
        "isadminUsuario": 0
    ]) { error in
        if let error = error {
            print("Error en el registro en Firestore: \(error.localizedDescription)")
        } else {
            print("Usuario registrado en Firestore")
        }
    }
}


    
    @IBAction func btnGoogle(_ sender: UIButton) {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                    
                let config = GIDConfiguration(clientID: clientID)
                GIDSignIn.sharedInstance.configuration = config
                
                GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
                    if let error = error {
                        print("Error al iniciar sesión con Google: \(error.localizedDescription)")
                        self.ventana("Error: No se pudo iniciar sesión con Google.")
                        return
                    }
                    
                    guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                        return
                    }
                    
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                   accessToken: user.accessToken.tokenString)
                    
                    Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                        if let error = error {
                            print("Error al autenticar con Firebase: \(error.localizedDescription)")
                            self?.ventana("Error: No se pudo autenticar con Firebase.")
                            return
                        }
                        
                       
                        print("Inicio de sesión exitoso con Google")
                        self?.obtenerDatosUsuario(authResult?.user)
                    }
                }
            }

func obtenerDatosUsuario(_ user: User?) {
    guard let user = user else { return }
    
    let uid = user.uid
    let displayName = user.displayName ?? "Usuario"
    let correo = user.email ?? ""
    
    // Dividir el displayName para obtener nombre y apellido
    let nombreApellido = displayName.split(separator: " ")
    let nombre = nombreApellido.first ?? "Nombre"
    let apellido = nombreApellido.count > 1 ? nombreApellido.last ?? "Apellido" : ""
    
    // Primero, verifica si el usuario ya existe en Firestore
    let BD = Firestore.firestore()
    BD.collection("usuario").document(uid).getDocument { document, error in
        if let error = error {
            print("Error al consultar Firestore: \(error.localizedDescription)")
            return
        }

        if let document = document, document.exists {
            // El usuario ya existe en Firestore
            print("Usuario ya registrado en Firestore: \(displayName), \(correo)")
            self.performSegue(withIdentifier: "menuPrincipal", sender: displayName)
        } else {
            // El usuario no existe en Firestore, obtenemos el último código de usuario
            self.obtenerUltimoCodigoDeUsuario { ultimoCodigo in
                let nuevoCodigoUsuario = ultimoCodigo + 1
                
                // Registrar al usuario en la API
                self.registrarUsuarioEnAPI(uid: uid, correoUsuario: correo, codigoUsuario: nuevoCodigoUsuario, nombreUsuario: nombre, apellidoUsuario: apellido)
                
                // Registrar al usuario en Firestore
                self.registrarUsuarioEnFirestore(uid: uid, correoUsuario: correo, codigoUsuario: nuevoCodigoUsuario, nombreUsuario: nombre, apellidoUsuario: apellido)
                
                // Realizar segue al menú principal
                self.performSegue(withIdentifier: "menuPrincipal", sender: displayName)
            }
        }
    }
}


func obtenerUltimoCodigoDeUsuario(completion: @escaping (Int) -> Void) {
    AF.request("https://cinegriffapi-production.up.railway.app/api/usuario/listar")
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        // Decodificar la respuesta JSON para obtener los usuarios
                        let usuarios = try JSONDecoder().decode([Usuario].self, from: data)
                        
                        // Obtener el último código de usuario
                        if let ultimoUsuario = usuarios.last {
                            completion(ultimoUsuario.codigoUsuario)
                        } else {
                            completion(0) // Si no hay usuarios, el primer código será 1
                        }
                    } catch {
                        print("Error al decodificar la respuesta de la API")
                        completion(0) // En caso de error, comenzamos desde 1
                    }
                }
            case .failure(let error):
                print("Error al consultar la API: \(error)")
                completion(0) // En caso de error en la API, comenzamos desde 1
            }
        }
}


    @IBAction func btnShowRegistrar(_ sender: Any) {
        performSegue(withIdentifier: "registrarUsuario", sender: self)
    }
    
    func ventana(_ msg:String){
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(pantalla, animated: true)
    }
    
    func ventana2(_ msg:String){
        //crear objeto pantalla
        let pantalla=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        //adiciona boton dentro de la pantalla
        pantalla.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {
            action in
            self.performSegue(withIdentifier: "menuPrincipal", sender: nil)
        }))
        //mostrar "pantalla"
        present(pantalla, animated: true)
    }
    
}

