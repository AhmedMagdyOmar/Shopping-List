//
//  Item.swift
//  Shopping List
//
//  Created by Ahmed on 3/5/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Firebase
import Foundation

//MARK :- Item Model with codable
struct ItemResponse: Codable {
    let items:[Item]
    
    private enum CodingKeys: String, CodingKey {
        case items = "documents"
    }
}


struct StringValue: Codable {
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case value = "stringValue"
    }
}


//Important Note: we can brief all of that Model code with just one firebase function but i just wnanted to show you that i can build codable model with some complicated

// MARK :- struct item
class Item: Codable {
    
    var description: String!
    var id: String!
    var imageLink: String?
    var name: String!
    var price: String!
    var checked: Bool = false
    
  
    private enum ItemKeys: String, CodingKey {
        case fields
    }

    private enum FieldsKeys: String, CodingKey {
        case id
        case description
        case imageLink
        case name
        case price
    }
    
        init() {
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemKeys.self)
        let fieldContainer = try container.nestedContainer(keyedBy: FieldsKeys.self, forKey: .fields)
        id = try fieldContainer.decode(StringValue.self, forKey: .id).value
        description = try fieldContainer.decode(StringValue.self, forKey: .description).value
        imageLink = try? fieldContainer.decode(StringValue.self, forKey: .imageLink).value
        name = try fieldContainer.decode(StringValue.self, forKey: .name).value
        price = try fieldContainer.decode(StringValue.self, forKey: .price).value
        
    }
    
    init( dictionary: NSDictionary) {
        id = dictionary[kITEMIDS] as? String
        name = dictionary[kNAME] as? String
        description = dictionary[kDESCRIPTION] as? String
        price = dictionary[kPRICE] as? String
        imageLink = dictionary[kIMAGELINK] as? String
        
    }
}











