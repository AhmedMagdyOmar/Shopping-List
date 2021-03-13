//
//  ApiRequest.swift
//  Shopping List
//
//  Created by Ahmed on 3/7/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation
import Firebase

struct ApiRequest {
    
  static let shared = ApiRequest()
  let baseURL = "https://firestore.googleapis.com/v1/projects/shopping-list-738d3/databases/(default)/documents/Items/"
    
  //Mark:- Get Data
  func requstData(completion: @escaping( [Item]) -> ()) {

    guard let url = URL(string: baseURL) else {return}
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in

            if let err = err {
                print("Failed to fetch Posts", err)
                return
            }
        
            guard let data = data else {
                let err = NSError(domain: "error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data not found"])
                print("Failed to fetch Posts", err)
                return
            }
        
       
            do {
        
                let itemslist = try JSONDecoder().decode(ItemResponse.self, from: data)
                    completion(itemslist.items)
                
            }catch {
                print("the erros is \(String(describing: err?.localizedDescription))")
            }
    
        }.resume()
    }
}



// MARK: - Save added item to firebase
func saveItemToFirestore(_ item: Item) {
    let values = [kITEMIDS: item.id,
                  kNAME: item.name,
                  kDESCRIPTION: item.description,
                  kPRICE: item.price,
                  kIMAGELINK: item.imageLink as Any] as [String: Any]
    
    FIREBASE_REF.collection(kITEMS).document(item.id).setData(values)
}


// MARK: - Delete item from firebase
func deleteItemFromFirestore(_ itemId: String) {
    FIREBASE_REF.collection(kITEMS).document(itemId).delete() { err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Document successfully removed!")
        }
    }
}



// MARK: - Save item to basket
func saveItemsToBasket(_ item: Item) {
    let values = [kITEMIDS: item.id,
                  kNAME: item.name,
                  kDESCRIPTION: item.description,
                  kPRICE: item.price,
                  kIMAGELINK: item.imageLink as Any] as [String: Any]
    
    FIREBASE_REF.collection(kBASKET).document(item.id).setData(values)
    
}


// MARK: - Delete item from Basket
func deleteItemFromBasket(_ itemId: String) {
    FIREBASE_REF.collection(kBASKET).document(itemId).delete() { err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Document successfully removed!")
        }
    }
}


// MARK: - download basket items
func downloadBasketItems(completion: @escaping( [Item]) -> ()) {
    
  var BasketIemsList: [Item] = []
  FIREBASE_REF.collection(kBASKET).getDocuments { (snapshot, err) in
    
    if let err = err {
        print("Error getting documents: \(err)")
        return
    }
    guard let snapshot = snapshot else { return }
        
    for itemDict in snapshot.documents {
        BasketIemsList.append(Item(dictionary: itemDict.data() as NSDictionary))
    }
        
    completion(BasketIemsList)
    }
}


