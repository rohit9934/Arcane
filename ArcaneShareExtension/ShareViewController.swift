//
//  AddProductsViewController.swift
//  Products Share Extension
//
//  Created by Rohit Sharma on 17/04/23.
//

import UIKit
import LinkPresentation
@objc(ShareViewController)
class ShareViewController: UIViewController, UITextFieldDelegate {
    var productURL: String = ""
    
//    @IBOutlet weak var saveButton: UIBarButtonItem!
//    @IBOutlet weak var itemLabel: UILabel!
//    @IBOutlet weak var itemImageView: UIImageView!
//    @IBOutlet weak var cancelButton: UIBarButtonItem!
//    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var itemLabel: UILabel!
    var links = [String]()
    var pleaseWait: UIAlertController?
    var savedImage = UIImage()
    let imageStorage = UserDefaultsImageStorageService(key: "images")
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItemDetails()
        priceTextField.delegate = self
        itemImageView.layer.cornerRadius = 25
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.layer.borderColor = #colorLiteral(red: 1, green: 0.2043005824, blue: 0.08064959198, alpha: 1)
        itemImageView.layer.borderWidth = 5
        self.saveButton.isEnabled = false
        if self.productURL != "" {
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //   pleaseWait = self.loader()
    }
    
    /// We need to set links in here from UserDefaults, if link is in UserDefault, tell us and update
    func userDefaultPreparations() {
        let defaults = UserDefaults(suiteName: "group.shareLinks")
        if let links = defaults?.array(forKey: "links") as? [String]{
            self.links = links
        }else {return}
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        userDefaultPreparations()
        let defaults = UserDefaults(suiteName: "group.Rohit.app")
        if self.links.contains(productURL) {
            print("Already Added man")
            return
        }
        imageStorage.insertImage(image: self.savedImage)
        self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
    }
    
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
    }

}


extension ShareViewController {
    func fetchItemDetails() {
        if let item = extensionContext?.inputItems.first as? NSExtensionItem, let attachments = item.attachments {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.image") {
                        attachment.loadItem(forTypeIdentifier: "public.image", options: nil, completionHandler: { (data, error) in
                            if let url = data as? URL, let imageData = try? Data(contentsOf: url),
                                           let image = UIImage(data: imageData)  {
                                // Do stuff with your URL now.
                                DispatchQueue.main.async {
                                    self.itemImageView.image = image
                                    self.savedImage = image
                                    self.saveButton.isEnabled = true
                                }
                        
                            }
                        })
                    }
                }
            }
        }
}

extension ShareViewController {
    func loader() -> UIAlertController {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.large
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            return alert
        }
        
        func stopLoader(loader : UIAlertController) {
            DispatchQueue.main.async {
                loader.dismiss(animated: true, completion: nil)
            }
        }
}

class ShowProduct {
    static func fetchPreview(productURL: String,price: String = "0", completion: @escaping ((UIImage) -> Void)) {
        guard let url = URL(string: productURL) else {
            return
        }
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { metaData, error in
            guard let data = metaData, error == nil else {
                return
            }
            let _ = data.imageProvider?.loadObject(ofClass: UIImage.self, completionHandler: { image, err in
                completion(image as! UIImage)
                                    })
        }
    }
}
