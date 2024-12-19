import UIKit

extension DatosPeliculasViewController {
    
    // Función que aplica el estilo a todos los elementos de la vista
    func setupUIDatosPelicula() {
        // Configurar estilos para las etiquetas
        setupLabel(lblCodigoPeli)
        
        // Configurar campos de texto
        setupTextField(txtTituloPeli, placeholder: "Título de la película", emoji: "🎬")
        setupTextField(txtDescripcionPeli, placeholder: "Descripción", emoji: "📝")
        setupTextField(txtDuracionPeli, placeholder: "Duración (minutos)", emoji: "⏱️")
        setupTextField(txtFechaEstrenoPeli, placeholder: "Fecha de estreno", emoji: "📅")
        setupTextField(txtDirectorPeli, placeholder: "Director", emoji: "🎥")
        setupTextField(txtClasificacionPeli, placeholder: "Clasificación", emoji: "⭐️")
        setupTextField(txtGeneroPeli, placeholder: "Género", emoji: "🎭", isEditable: false)
        
        // Configurar el PickerView
        setupPickerView(pvGeneroPeli)
        
        // Estilo para la imagen del banner de la película
        setupImageView(imgBannerPeli)
    }
    
    // Estilo para UILabel
    private func setupLabel(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
    }
    
    // Estilo para UITextField
    private func setupTextField(_ textField: UITextField, placeholder: String, emoji: String, isEditable: Bool = true) {
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: "DarkBlue") // Azul oscuro como fondo
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = .systemBlue
        textField.isEnabled = isEditable
        
        // Configuración del placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        
        // Emoji en el lado izquierdo
        let emojiLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 16)
        emojiLabel.textColor = .systemGray
        
        let emojiContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 30))
        emojiContainerView.addSubview(emojiLabel)
        textField.leftView = emojiContainerView
        textField.leftViewMode = .always
    }
    
    // Estilo para UIPickerView
    private func setupPickerView(_ pickerView: UIPickerView) {
        pickerView.layer.cornerRadius = 12
        pickerView.layer.borderWidth = 1
        pickerView.layer.borderColor = UIColor.systemGray4.cgColor
        pickerView.tintColor = .systemBlue
    }
    
    // Estilo para UIImageView
    private func setupImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.clipsToBounds = true
    }
}
