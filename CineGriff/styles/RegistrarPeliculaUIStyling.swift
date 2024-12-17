import UIKit

// Extensión para aplicar los estilos específicos del RegistrarPeliculaViewController
extension RegistrarPeliculaViewController {
    
    // Función para configurar todos los estilos iniciales de la vista
    func setupUIRegistrarPelicula() {
        // Configuración de los campos de texto
        setupTextField(txtTitulo, placeholder: "Título de la película", icon: "film")
        setupTextField(txtDescripcion, placeholder: "Descripción", icon: "text.bubble")
        setupTextField(txtDuracion, placeholder: "Duración (minutos)", icon: "clock")
        setupTextField(txtDirector, placeholder: "Director", icon: "person.fill")
        setupTextField(txtClasificacion, placeholder: "Clasificación (edad)", icon: "star")
        
        // Configuración del picker de Género
        setupPickerView(pvGenero)
        
        // Configuración del DatePicker para la fecha de estreno
        setupDatePicker(dpFechaEstreno)
        
        // Configuración de la imagen del banner de la película
        setupImageView(imgBannerPelicula)
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
        
        // Emoji específico si el campo es para título
        if placeholder == "Título de la película" {
            let emojiLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
            emojiLabel.text = "🎬" // Emoji relacionado con el cine
            emojiLabel.font = UIFont.systemFont(ofSize: 16)
            emojiLabel.textColor = .systemGray
            
            let emojiContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 30))
            emojiContainerView.addSubview(emojiLabel)
            textField.leftView = emojiContainerView
            textField.leftViewMode = .always
        }
    }
    
    // Estilo para el UIPickerView de Género
    private func setupPickerView(_ pickerView: UIPickerView) {
        // Estilos generales del pickerView
        pickerView.layer.cornerRadius = 12
        pickerView.layer.borderWidth = 1
        pickerView.layer.borderColor = UIColor.systemGray4.cgColor
        pickerView.tintColor = .systemBlue
    }
    
    // Estilo para el UIDatePicker
    private func setupDatePicker(_ datePicker: UIDatePicker) {
        // Estilo general del DatePicker
        datePicker.layer.cornerRadius = 12
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = UIColor.systemGray4.cgColor
        datePicker.tintColor = .systemBlue
    }
    
    // Estilo para la imagen del banner de la película
    private func setupImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.clipsToBounds = true
    }
}
