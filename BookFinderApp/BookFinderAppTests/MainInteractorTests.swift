//
//  MainInteractorTests.swift
//  BookFinderAppTests
//
//  Created by 김나희 on 9/3/22.
//

import XCTest
@testable import BookFinderApp

class MainInteractorTests: XCTestCase {
    var sut: MainInteractor!
    
    override func setUp() {
        super.setUp()
        setupMainInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupMainInteractor() {
        sut = MainInteractor()
    }
    
    func testShouldCallWorkerAndPresenter() throws {
        // given
        let mainWorkerSpy = MainWorkerSpy()
        sut.worker = mainWorkerSpy
        
        let mainPresentationLogicSpy = MainPresentationLogicSpy()
        sut.presenter = mainPresentationLogicSpy
        
        // when
        let request = Main.BookData.Request(keyword: "", startIndex: 0)
        sut.worker?.fetchBookData(request: request) { _ in }
        sut.presenter?.presentData(response: Main.BookData.Response.init(books: GoogleBookData(kind: nil, totalItems: nil, items: nil)))
        
        // then
        XCTAssert(mainWorkerSpy.fetchBookDataCalled)
        XCTAssert(mainPresentationLogicSpy.presentMovementCalled)
    }
}

class MainBusinessLogicSpy: MainBusinessLogic {
    var fetchBookDataCalled = false
    var fetchBookDataRequest: Main.BookData.Request!

    func fetchBookData(request: Main.BookData.Request) {
        fetchBookDataCalled = true
        fetchBookDataRequest = request
    }
}
