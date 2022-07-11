//
//  OpenMarketTests.swift
//  OpenMarketTests
//
//  Created by bard, groot on 2022/07/11.
//

import XCTest
@testable import OpenMarket
class OpenMarketTests: XCTestCase {
    var mockData: NSDataAsset?
    var jsonDecoder: JSONDecoder?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockData = NSDataAsset(name: "MockData")
        jsonDecoder = JSONDecoder()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockData = nil
        jsonDecoder = nil
    }
    
    func test_목데이터디코딩이_잘되는지() {
        // given
        guard let data = mockData?.data
        else { return }
        guard let openMaketData = try? jsonDecoder?.decode(OpenMarketPage.self, from: data)
        else { return }
        
        // when
        let result = "Test Product"
        
        // then
        XCTAssertEqual(result, openMaketData.pages[0].name)
    }
    
    func test_목데이터디코딩이_잘못된값을가져오지는않는지() {
        // given
        guard let data = mockData?.data
        else { return }
        guard let openMaketData = try? jsonDecoder?.decode(OpenMarketPage.self, from: data)
        else { return }
        
        // when
        let result = 0
        
        // then
        XCTAssertNotEqual(result, openMaketData.pages[0].id) 
    }
}
