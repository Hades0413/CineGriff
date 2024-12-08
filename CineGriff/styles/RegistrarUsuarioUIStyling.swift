import UIKit

// Extensión para aplicar los estilos específicos del RegistrarUsuarioViewController
extension RegistrarUsuarioViewController {
    
    // Función para configurar todos los estilos iniciales de la vista
    func setupUIRegistrarUsuario() {
        // Fondo de la imagen
        setupBackgroundImage()
        
        // Degradado
        setupGradientBackground()
        
        // Configuración de los campos de texto
        setupTextField(txtUsernameUsuario, placeholder: "Nombre de usuario", icon: "at")
        setupTextField(txtNombreUsuario, placeholder: "Nombre", icon: "person")
        setupTextField(txtApellidoUsuario, placeholder: "Apellido", icon: "person")
        setupTextField(txtCorreoUsuario, placeholder: "Correo electrónico", icon: "envelope")
        setupTextField(txtContrasenaUsuario, placeholder: "Contraseña", icon: "lock")
        txtContrasenaUsuario.isSecureTextEntry = true
               
        // Bordes del formulario
        applyBorderRadiusToLoginFormView()
    }

    // Estilo para el fondo de la imagen
    private func setupBackgroundImage() {
        LoginBackground.image = UIImage(named: "login_background")
        LoginBackground.contentMode = .scaleAspectFill
    }
    
    // Estilo para el fondo degradado
    private func setupGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = GradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.9).cgColor]
        gradient.locations = [0.0, 1.0]
        GradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    // Estilo para los campos de texto
    private func setupTextField(_ textField: UITextField, placeholder: String, icon: String) {
        textField.borderStyle = .none
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = .systemBlue
        
        // Placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        
        // Icono en el lado izquierdo
        let iconView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = .systemGray
        iconView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
    }
    
    // Estilo para aplicar el border radius al formulario
    private func applyBorderRadiusToLoginFormView() {
        LoginFormView.layer.cornerRadius = 20
        LoginFormView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        LoginFormView.layer.masksToBounds = true
        
        // Sombra para el formulario
        LoginFormView.layer.shadowColor = UIColor.black.cgColor
        LoginFormView.layer.shadowOpacity = 0.1
        LoginFormView.layer.shadowOffset = CGSize(width: 0, height: 5)
        LoginFormView.layer.shadowRadius = 10
    }
}
