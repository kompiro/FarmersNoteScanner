//
//  AtomXMLTest.swift
//  FarmersNoteScanner
//
//  Created by Hiroki Kondo on 2014/10/20.
//  Copyright (c) 2014年 Farms. All rights reserved.
//

import Cocoa
import XCTest
import FarmersNoteScanner

class AtomXMLTest: XCTestCase {
    
    let sut = AtomXML()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGenerateNoContent() {
        var generated = sut.generate()
        XCTAssert("" == generated)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
