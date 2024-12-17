
import UIKit

class ControladorGoat: PMetodos {
    
    func findAll() -> [GoatEntity] {
        
        var lista : [GoatEntity]!
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        let contextoBD = delegate.persistentContainer.viewContext
        
        let registros = GoatEntity.fetchRequest()
        
        do {
            try lista = contextoBD.fetch(registros)
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        
        return lista
    }
}
