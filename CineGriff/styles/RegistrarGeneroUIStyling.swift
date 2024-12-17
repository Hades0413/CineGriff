import UIKit

// Extensión para aplicar los estilos específicos del RegistrarGeneroViewController
extension RegistrarGeneroViewController {
    
    // Función para configurar todos los estilos iniciales de la vista
    func setupUIRegistrarGenero() {
        
        // Configuración del campo de texto de género
        setupTextField(txtNombreGenero, placeholder: "Nombre del Género", icon: "star.fill")
     
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
        
        // Emoji específico para el campo de "Género"
        if placeholder == "Nombre del Género" {
            let emojiLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
            emojiLabel.text = "🎬" // Emoji relacionado con cine o género
            emojiLabel.font = UIFont.systemFont(ofSize: 16)
            emojiLabel.textColor = .systemGray
            
            let emojiContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 30))
            emojiContainerView.addSubview(emojiLabel)
            textField.leftView = emojiContainerView
            textField.leftViewMode = .always
        }
    }
    

}
