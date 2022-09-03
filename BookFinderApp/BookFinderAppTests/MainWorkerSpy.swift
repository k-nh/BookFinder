//
//  MainWorkerSpy.swift
//  BookFinderAppTests
//
//  Created by 김나희 on 9/3/22.
//

import XCTest
@testable import BookFinderApp

class MainWorkerTests: XCTestCase {
    
    var sut: MainWorker!
    
    override func setUp() {
        super.setUp()
        setupMainWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
        
    func setupMainWorker() {
        sut = MainWorker(service: SearchServiceSpy())
    }
    
    
    func testShouldCallService() {
        // given
        let mainService = SearchServiceSpy()
        sut.service = mainService
        
        // when
        sut.fetchBookData(request: Main.BookData.Request(keyword: "", startIndex: 0)) { _ in
        }

        // then
        XCTAssert(mainService.searchCalled)
    }
    
}

class MainWorkerSpy: MainSceneSearchLogic {
    var fetchBookDataCalled = false

    func fetchBookData(request: Main.BookData.Request, completion: @escaping (Result<GoogleBookData, APIError>) -> Void) {
        self.fetchBookDataCalled = true
        completion(.success(GoogleBookData(kind: nil, totalItems: nil, items: nil)))
    }
}

class SearchServiceSpy: SearchSearvice {
    var searchCalled = false
    
    func search(keyword: String, startIndex: Int, completion: @escaping (Result<GoogleBookData, APIError>) -> Void) {
        self.searchCalled = true
        completion(.success(GoogleBookData(kind: nil, totalItems: nil, items: nil)))
    }
}
