//
//  extension+UIImageView.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import UIKit

class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}
extension UIImageView {
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit)  {
        contentMode = mode
        guard let url = URL(string: link) else {
            return
        }
        let urlToString = url.absoluteString as NSString
        
        if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
        } else  {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = nil
                    }
                    return
                }
                DispatchQueue.main.async() { [weak self] in
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    self?.image = image
                }
            }.resume()
        }
    }
    
}
