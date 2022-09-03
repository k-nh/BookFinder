//
//  MainViewControllerTests.swift
//  BookFinderAppTests
//
//  Created by 김나희 on 9/1/22.
//

import XCTest
@testable import BookFinderApp

class MainViewControllerTests: XCTestCase {
    var sut: MainViewController!
    var spyInteractor: MainBusinessLogicSpy!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMainViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    func setupMainViewController() {
        sut = MainViewController(nibName: nil, bundle: nil)
    }
    
    // MARK: Test
    func testNumberOfRowsInTableViewShouldBeEqualToDummyListCount() {
        // given
        let dummyList = [
            Book(title: "타이틀",
                 authors: ["저자"],
                 description: "설명",
                 thumbnailURL: "http://books.google.com/books/content?id=DDv3ugAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
                 infoLink: "http://books.google.co.kr/books?id=DDv3ugAACAAJ&dq=%EA%B2%80%EC%83%89&hl=&source=gbs_api",
                 publishedDate: "2022")
        ]
        sut.totalItemCount = dummyList.count
        sut.displayedBooks = dummyList
        
        // when
        loadView()
        let numberOfRowsInSection = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // then
        XCTAssertEqual(numberOfRowsInSection, dummyList.count)
    }
    
    func testShouldConfigureTableViewCells() {
        // given
        let dummyList = [
            Book(title: "타이틀",
                 authors: ["저자"],
                 description: "설명",
                 thumbnailURL: "http://books.google.com/books/content?id=DDv3ugAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
                 infoLink: "http://books.google.co.kr/books?id=DDv3ugAACAAJ&dq=%EA%B2%80%EC%83%89&hl=&source=gbs_api",
                 publishedDate: "2022")
        ]
        sut.totalItemCount = dummyList.count
        sut.displayedBooks = dummyList
        
        // when
        loadView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath) as? BookTableViewCell
        
        // then
        XCTAssertEqual(cell?.titleLabel.text, "타이틀")
        XCTAssertEqual(cell?.authorLabel.text, "저자")
        XCTAssertEqual(cell?.descriptionLabel.text, "설명")
        XCTAssertEqual(cell?.publishedDateLabel.text, "2022")
    }

}

class MainDisplayLogicSpy: MainDisplayLogic {
    var displayCalled = false
    var displaySuccessViewModel: Main.BookData.ViewModelSuccess?
    var displayFailureViewModel: Main.BookData.ViewModelFailure?

    func displayBookData(viewModel: Main.BookData.ViewModelSuccess) {
        displayCalled = true
        displaySuccessViewModel = viewModel
    }
    
    func displayError(viewModel: Main.BookData.ViewModelFailure) {
        displayCalled = true
        displayFailureViewModel = viewModel
    }
}

