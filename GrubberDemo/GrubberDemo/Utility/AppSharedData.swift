
import UIKit

class AppSharedData: NSObject {
    
    /*
     @discussion    Declearing singleton Objects.
     */
    static let storyBoard = UIStoryboard(name: "Main", bundle:nil)
    static var userdefault = UserDefaults.standard
    
    static var database_Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func showAlert(message:String, viewController:UIViewController){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}





