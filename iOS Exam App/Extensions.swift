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
