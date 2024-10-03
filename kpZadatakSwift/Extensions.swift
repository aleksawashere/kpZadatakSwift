//
//  Extensions.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import UIKit


//MARK: - UIStoryboard
extension UIStoryboard {
    
    /// Returns instance of main storyboard
    static let main = UIStoryboard(name: "Main", bundle: nil)
    
    /// Instantiate view contoller from storyboard
    /// - Parameter identifier: Unique view controller identifer from storyboard
    func instantiate<T: UIViewController>(_ identifier: String) -> T {
        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}

//MARK: - String

extension String {
    
    func textToAttributedString() -> NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        // Return attributed string
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            
        } catch {
            print("Error converting to ns string: \(error)")
            return nil
        }
    }
    
    func convertText() -> String {
        return textToAttributedString()?.string ?? ""
    }
}

//MARK: - UIImageView

extension UIImageView {
    
    func prepareImageFromServerSide(urlString: String) {
        
        self.image = AppConstants.AppTheme.backgroundImage
        
        guard let url = URL(string: AppConstants.baseUrl + urlString) else {
            return
        }
        let loader = LoaderView.create(for: self)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                loader.dismiss()
                if let data = data {
                    if let image = UIImage(data: data) {
                        self.image = image
                    }
                }
            }
        }.resume()
    }
}

//MARK: - UIImage

extension UIImage {
    
    //Seting alpha on Image
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}

