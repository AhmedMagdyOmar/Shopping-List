//
//  Downloader.swift
//  Shopping List
//
//  Created by Ahmed on 3/5/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit

public func uploadImage(image: UIImage?, itemId: String, completion: @escaping (_ imageLink: String) -> Void) {
    
    if Reachabilty.HasConnection() {
                
            let fileName = "itemImage/" + itemId + "/" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.5)
            
            saveImageInFirebase(imageData: imageData!, fileName: fileName) { (imageLink) in
                
                if let imageLink = imageLink {
                    completion(imageLink)
                    }
                }
            } else {
              print("No Internet Connection")
        }
   }



func saveImageInFirebase(imageData: Data, fileName: String, completion: @escaping(_ imageLink: String?) -> Void) {
    
    var task: StorageUploadTask!
    let storageRef = STORAGE_REF.reference(forURL: kFileRefrence).child(fileName)
    
    task = storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
        task.removeAllObservers()
        
        if error != nil {
            print("Error Uploading Image", error!.localizedDescription)
            completion(nil)
            return
        }
        
        storageRef.downloadURL(completion: { (url, error) in
            guard let downloadUrl = url else {
                print("DEBUG: Profile image url is nil")
                completion(nil)
                return
            }
            completion(downloadUrl.absoluteString)
        })
    })
}


func dowwnloadImages(imageUrl: String, completion: @escaping (_ imagee: UIImage?) -> Void) {
    
    // check if images exist in cach
    let cach = NSCache<NSString, UIImage>()
    let cachKey = NSString(string: imageUrl)
    if let image = cach.object(forKey: cachKey) {
        completion(image)
        return
   }
    
    // download image if it isn't in cach
        let url = NSURL(string: imageUrl)
        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
    
        downloadQueue.async {
            guard let data = NSData(contentsOf: url! as URL) else {return}
            guard let image = UIImage(data: data as Data) else {return}
            cach.setObject(image, forKey: cachKey)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
         }

