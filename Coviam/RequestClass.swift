import UIKit
import Foundation

class RequestClass: NSObject {
    
    class  func getData(urlString:String, completionHandler:@escaping ((_ data:NSDictionary?, _ error:Error?)-> Void)){
          let query = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: query!)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil{
                guard let unwrappedData = data else {
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! [String:Any]
                    if let array = json["data"] as? NSDictionary{
                        completionHandler(array, nil)
                    }
                    print(json)
                } catch let error as NSError {
                    completionHandler(nil, error)
                }
            }
            else{
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIImageView.ContentMode) {
        if let cachedImage = imageCache.object(forKey: link as NSString) {
            self.image = cachedImage
            /* check for the cached image for url, if YES then return the cached image */
        }
        let url = URL(string: link)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    if let newImage = UIImage(data: data){
                        imageCache.setObject(newImage, forKey:  url.absoluteString as NSString, cost: 1)
                        self.image = newImage
                        self.contentMode = contentMode
                        self.layoutIfNeeded()
                    }
                }
            }
        }
        task.resume()
    }
}
