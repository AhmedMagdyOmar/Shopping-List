//
//  Constants.swift
//  Shopping List
//
//  Created by Ahmed on 3/5/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Firebase


// MARK: - Root References

public let STORAGE_REF = Storage.storage()
public let FIREBASE_REF = Firestore.firestore()

// MARK: - Storage References
public let kFileRefrence = "gs://shopping-list-738d3.appspot.com"



//Firebase Headers

public let kITEMS = "Items"
public let kBASKET = "Basket"



// MARK: - Item
public let kITEMIDS = "id"
public let kNAME = "name"
public let kDESCRIPTION = "description"
public let kPRICE = "price"
public let kIMAGELINK = "imageLink"
public let kchecked = "checked"
