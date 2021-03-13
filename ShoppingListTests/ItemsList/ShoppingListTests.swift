//
//  ShoppingListTests.swift
//  ShoppingListTests
//
//  Created by Ahmed on 3/11/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import XCTest
@testable import Shopping_List

class Shopping_ListTests: XCTestCase {
    
    
    // SUT .
    let sut = ItemsTableViewController()
    
    override func setUp() {
        super.setUp()
        
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    
    func testitemListIsEmpty() {
        
        let itemList = sut.itemList
        
        XCTAssertEqual(itemList.count, 0)
        
    }
    
    func testAddNewEmptyItem() {
        
        let itemList = sut.itemList
        let newItem = sut.addNewItem(item: Item())
        
        XCTAssertEqual(itemList.count, 0)
    }
    

    
//        let data = json.data(using: .utf8)
//        let itemslist = try! JSONDecoder().decode(ItemResponse.self, from: data!)
//        XCTAssertEqual("Yassin", itemslist.items[0].name, "Not Equal")
//    }
//
//
//    func testSaveItemToFirestore() {
//        let values = ["id": "7777",
//                      "name": "Ahmed",
//                      "Description": "Khye",
//                      "price": "70",
//                      "imageLink": "www.khyer.com" as Any] as [String: Any]
//
//        FIREBASE_REF.collection(kITEMS).document("7777").setData(values)
//    }
//    func testNumberOfItemsEqualOne() {
//        guard let itemsData = mockup?.getList() else {return}
//        XCTAssertEqual(1, itemsData.count, "Not Equal One")
//    }
//
//    func testAddItem() {
//        var itemData = mockup?.getList()
//        itemData?.append(Items(name: "Ahmed", id: 2, price: 500))
//        XCTAssertEqual(2, itemData?.count, "Item Not Added")
//
//    }
//
//    func testDropItem() {
//        var itemData = mockup?.getList()
//        itemData?.append(Items(name: "Ahmed", id: 2, price: 500))
//        itemData?.remove(at: 1)
//        XCTAssertFalse(itemData?.count == 2)
//    }
    

    
}
