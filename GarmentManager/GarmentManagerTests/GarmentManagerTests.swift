//
//  GarmentManagerTests.swift
//  GarmentManagerTests
//
//  Created by Khateeb H. on 12/1/21.
//

import XCTest
@testable import GarmentManager

var dataManager: DataManager!
class CoreDataManagerTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        dataManager = DataManager.shared
    }
    
    override class func tearDown() {
        super.tearDown()
        dataManager = nil
    }

    func testAddNewGarment() {
        dataManager.saveNewGarment(id: UUID(), title: "T Shirt", createdDate: Date()) { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let garment):
                XCTAssertNotNil(garment)
                XCTAssertTrue(garment.title == "T Shirt")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
