import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let nsString = NSString(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: nsString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                imageCache.setObject(image, forKey: nsString)
                self.image = image
            }
            
        }.resume()
    }
}

class HeaderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "Title"
        font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textColor = .black
        
    }
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    
    func showAlert(title: String?, message: String?, action: String?, handler: ((UIAlertAction)->())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: action, style: .cancel, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
    
}
