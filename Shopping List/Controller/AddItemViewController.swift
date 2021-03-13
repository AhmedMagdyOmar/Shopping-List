//
//  AddItemViewController.swift
//  Shopping List
//
//  Created by Ahmed on 3/5/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    //MARK: Vars
    var itemImage: UIImage?
    var activityIndicator: NVActivityIndicatorView?
    var gallery: GalleryController!
    var delegate:AddItemDelegte?
    
    
    //MARK: Constant
    let hud = JGProgressHUD(style: .dark)
    
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initView()
    }
    
    
    //MARK: - Class Methods.
    
    private func initView() {
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballPulse, color: #colorLiteral(red: 0.9998469949, green: 0.4941213727, blue: 0.4734867811, alpha: 1), padding: nil)
    }
    
    
    //MARK: IBAction
    
    @IBAction func doneBarButtonItemPressed(_ sender: Any) {
        dismissKeayboard()

        if fieldsAreCompleted() {
            saveToFirebase()
        } else {
            self.hud.textLabel.text = "All fields are required!"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 1.0)

        }
    }

    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        showImageGallery()
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeayboard()
    }
    
}



//MARK:- Helpers
extension AddItemViewController {
    
    private func showImageGallery() {
        self.gallery = GalleryController()
        self.gallery.delegate = self
        
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 1
        
        self.present(self.gallery, animated: true, completion: nil)
    }
    
    
    private func fieldsAreCompleted() -> Bool {
        return (titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "" )
    }
    
    private func dismissKeayboard() {
        self.view.endEditing(true)
    }
    
    private func popTheView() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK:- Gallery Controller Delegate
extension AddItemViewController: GalleryControllerDelegate {
    
    //MARK: Activity Indicator
    private func showLoadingIndicator() {
        
        if  activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    
    private func hideLoadingIndicator() {
        
        if  activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    
    //MARK: Gallery controller functions
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
        Image.resolve(images: images) { (resolvedImages) in
            self.itemImage = resolvedImages[0]  // to convert image to UIImage
        }
    }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


//MARK:- Networking
extension AddItemViewController {

    //MARK: Save Item
    private func saveToFirebase() {
        showLoadingIndicator()
        
        //create new item
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.description = descriptionTextView.text
        item.price = String(priceTextField.text!)
        
        // if there are pic -> uploade it with item
        if itemImage != nil {
            uploadImage(image: itemImage, itemId: item.id) { (imageLink) in
                item.imageLink = imageLink
                self.delegate?.addNewItem(item: item)
                saveItemToFirestore(item)
                self.hideLoadingIndicator()
                self.popTheView()
            }

         // if there are no pic -> uploade item without it
         } else {
            saveItemToFirestore(item)
            self.delegate?.addNewItem(item: item)
            self.hideLoadingIndicator()
            popTheView()
        }
    }
}


