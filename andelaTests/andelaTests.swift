//
//  andelaTests.swift
//  andelaTests
//
//  Created by Chris Karani on 12/18/19.
//  Copyright © 2019 Chris Karani. All rights reserved.
//

import XCTest
@testable import andela

class andelaTests: XCTestCase {
    
    var entriesViewController : EntriesCollectionViewController!
    
    func testUrlResource() {
        let url = URL(string: "https://api.publicapis.org/entries")!
        let resource = CodableResource<Entry>(url: url)
        XCTAssertEqual(url, resource.url)
    }
    
    func testResourceParseData() {
        let testData = """
        {
        "API":"Cat Facts",
        "Description":"Daily cat facts",
        "Auth":"",
        "HTTPS":true,
        "Cors":"no",
        "Link":"https://alexwohlbruck.github.io/cat-facts/",
        "Category":"Animals"
        }
        """.data(using: .utf8)
        let url = URL(string: "https://api.publicapis.org/entries")!
        let resource = CodableResource<Entry>(url: url)
        let entry = resource.parse(testData!)!
        XCTAssertEqual(entry.api, "Cat Facts")
        XCTAssertEqual(entry.description, "Daily cat facts")
        XCTAssertEqual(entry.auth, "")
        XCTAssertEqual(entry.https, true)
        XCTAssertEqual(entry.cors, "no")
        XCTAssertEqual(entry.link, "https://alexwohlbruck.github.io/cat-facts/")
        XCTAssertEqual(entry.category, "Animals")
        
    }
    
    func testDataTaskRequest() throws {
        let url = URL(string: "https://api.publicapis.org/entries")!

        TinyHTTPStubURLProtocol.urls[url] = StubbedResponse(response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: exampleData!)

        let endpoint = CodableResource<EntriesContainer>.init(url: url)
        let expectation = self.expectation(description: "Stubbed network call")

        URLSession.shared.load(endpoint) { result in
            switch result {
            case let .success(payload):
                let entries = payload.entries
                XCTAssertEqual(payload.count, 681)
                XCTAssertEqual(entries[2].api, "Dogs")
                XCTAssertEqual(entries[1].description, "Pictures of cats from Tumblr")
                XCTAssertEqual(entries[0].https, true)
                
                expectation.fulfill()
            case let .failure(error):
                XCTFail(String(describing: error))
            }
        }

        wait(for: [expectation], timeout: 5)
    }


    override func setUp() {
        super.setUp()
         URLProtocol.registerClass(TinyHTTPStubURLProtocol.self)
        
        let collectionViewlayout = UICollectionViewFlowLayout()
        collectionViewlayout.minimumLineSpacing = 0
        collectionViewlayout.minimumInteritemSpacing = 0
        entriesViewController = EntriesCollectionViewController(collectionViewLayout: collectionViewlayout)
        
        entriesViewController.loadView()
        entriesViewController.viewDidLoad()
    }
    
    func testHasACollectionView() {
        XCTAssertNotNil(entriesViewController.collectionView)
    }
    
    func testCollectionViewHasDelegate() {
        XCTAssertNotNil(entriesViewController.collectionView.delegate)
    }
    
    func testCollectionViewConfromsToCollectionViewDelegateProtocol() {
        XCTAssertTrue(entriesViewController.conforms(to: UICollectionViewDelegate.self))
    }
    
    func testCollectionViewHasDataSource() {
        XCTAssertNotNil(entriesViewController.collectionView.dataSource)
    }
    
    func testCollectionViewConformsToCollectionViewDataSourceProtocol() {
        XCTAssertTrue(entriesViewController.conforms(to: UICollectionViewDataSource.self))
    }

    override func tearDown() {
        super.tearDown()
        URLProtocol.unregisterClass(TinyHTTPStubURLProtocol.self)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
