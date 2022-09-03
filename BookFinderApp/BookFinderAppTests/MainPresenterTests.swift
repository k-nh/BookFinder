//
//  MainPresenterTests.swift
//  BookFinderAppTests
//
//  Created by 김나희 on 9/3/22.
//

import XCTest
@testable import BookFinderApp

class MainPresenterTests: XCTestCase {
    var sut: MainPresenter!

    override func setUp() {
        super.setUp()
        setupPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func setupPresenter() {
        sut = MainPresenter()
    }
    
    func testShouldFormatResponseFromInteractor() {
        // given
        let mainDisplayLogicSpy = MainDisplayLogicSpy()
        sut.viewController = mainDisplayLogicSpy
        
        let dummyList: GoogleBookData = {
            return GoogleBookData(kind: nil,
                                  totalItems: nil,
                                  items: [
                                  Item(
                                    kind: nil,
                                    id: nil,
                                    etag: nil,
                                    selfLink: nil,
                                    volumeInfo: VolumeInfo(title: "검색을 위한 딥러닝", authors: ["토마소 테오필리 (Tommaso Teofili)"], publisher: nil, volumeInfoDescription: "딥러닝 기술을 활용해서 한층 더 진화된 검색 엔진을 완성한다! 신경망을 이용한 인공지능 검색 시스템의 원리와 활용! 딥러닝을 활용하면 검색어가 부정확하거나, 색인이 심하게 꼬여 있거나, 메타데이터가 거의 없는 상태에서도 이미지 검색과 같은 가장 까다로운 검색까지 처리할 수 있다. 또한, DL4J나 텐서플로와 같은 최신 도구를 사용하면 데이터 과학이나 자연어 처리에 대한 배경지식이 깊지 않아도 강력한 딥러닝 기술을 응용할 수 있다. 독자는 이 책을 통해 신경망을 사용하여 검색 결과를 향상시키는 방법을 배울 수 있다. 이 책에서는 색인 처리 및 순위지정과 같은 기본 검색 기술이 딥러닝과 어떤 관련성이 있는지를 검토하는 것부터 시작한다. 그런 다음, 아파치 루씬과 DL4J를 사용하는 검색 기능을 딥러닝 기술로 보강해 보는 심층 예제를 다루고, 더 나아가서 이미지 검색, 사용자 질의 내용 번역, 학습하는 동안 개선되는 검색 엔진 설계와 같은 고급 주제를 살펴본다. 이 책의 주요 내용 ■ 동의어를 생성해 쿼리 보충하기 ■ 정확하고 연관성 높은 결과가 먼저 나오게 순위지정하기 ■ 여러 외국어를 사용해서 검색하기 ■ 이미지 내용을 가지고 이미지 검색하기 ■ 추천 기능을 제공해 검색 돕기", industryIdentifiers: nil, readingModes: nil, pageCount: nil, printType: nil, categories: nil, maturityRating: nil, allowAnonLogging: nil, contentVersion: nil, panelizationSummary: nil, comicsContent: nil, imageLinks: ImageLinks(smallThumbnail: nil, thumbnail: "http://books.google.com/books/content?id=HeFUEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"), language: nil, previewLink: nil, infoLink: "https://play.google.com/store/books/details?id=HeFUEAAAQBAJ&source=gbs_api", canonicalVolumeLink: nil, seriesInfo: nil, publishedDate: "2021-12-20"),
                                    saleInfo: nil,
                                    accessInfo: nil,
                                    searchInfo: nil)
                                  ])
        }()
        
        // when
        let response = Main.BookData.Response(books: dummyList)
        sut.presentData(response: response)
        
        // then
        let returnedData = Main.BookData.ViewModelSuccess(displayedBooks: response.books.toDomain())
        let expectedData = [
            Book(title: "검색을 위한 딥러닝",
                 authors: ["토마소 테오필리 (Tommaso Teofili)"],
                 description: "딥러닝 기술을 활용해서 한층 더 진화된 검색 엔진을 완성한다! 신경망을 이용한 인공지능 검색 시스템의 원리와 활용! 딥러닝을 활용하면 검색어가 부정확하거나, 색인이 심하게 꼬여 있거나, 메타데이터가 거의 없는 상태에서도 이미지 검색과 같은 가장 까다로운 검색까지 처리할 수 있다. 또한, DL4J나 텐서플로와 같은 최신 도구를 사용하면 데이터 과학이나 자연어 처리에 대한 배경지식이 깊지 않아도 강력한 딥러닝 기술을 응용할 수 있다. 독자는 이 책을 통해 신경망을 사용하여 검색 결과를 향상시키는 방법을 배울 수 있다. 이 책에서는 색인 처리 및 순위지정과 같은 기본 검색 기술이 딥러닝과 어떤 관련성이 있는지를 검토하는 것부터 시작한다. 그런 다음, 아파치 루씬과 DL4J를 사용하는 검색 기능을 딥러닝 기술로 보강해 보는 심층 예제를 다루고, 더 나아가서 이미지 검색, 사용자 질의 내용 번역, 학습하는 동안 개선되는 검색 엔진 설계와 같은 고급 주제를 살펴본다. 이 책의 주요 내용 ■ 동의어를 생성해 쿼리 보충하기 ■ 정확하고 연관성 높은 결과가 먼저 나오게 순위지정하기 ■ 여러 외국어를 사용해서 검색하기 ■ 이미지 내용을 가지고 이미지 검색하기 ■ 추천 기능을 제공해 검색 돕기",
                 thumbnailURL: "http://books.google.com/books/content?id=HeFUEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
                 infoLink: "https://play.google.com/store/books/details?id=HeFUEAAAQBAJ&source=gbs_api",
                 publishedDate: "2021-12-20")
        ]
        
        XCTAssertEqual(returnedData.displayedBooks.books?[0].title, expectedData[0].title)
        XCTAssertEqual(returnedData.displayedBooks.books?[0].description, expectedData[0].description)
        XCTAssertEqual(returnedData.displayedBooks.books?[0].authors, expectedData[0].authors)
        XCTAssertEqual(returnedData.displayedBooks.books?[0].thumbnailURL, expectedData[0].thumbnailURL)
        XCTAssertEqual(returnedData.displayedBooks.books?[0].infoLink, expectedData[0].infoLink)
        XCTAssertEqual(returnedData.displayedBooks.books?[0].publishedDate, expectedData[0].publishedDate)

    }
    
    func testShouldCallPresenter() throws {
        // given
        let mainDisplayLogicSpy = MainDisplayLogicSpy()
        sut.viewController = mainDisplayLogicSpy
        
        // when
        let response = Main.BookData.Response(books: GoogleBookData(kind: nil, totalItems: nil, items: nil))
        sut.presentData(response: response)
        
        // then
        XCTAssert(mainDisplayLogicSpy.displayCalled)
    }
}

class MainPresentationLogicSpy: MainPresentationLogic {
    var presentMovementCalled = false
    var presentMovementResponse: Main.BookData.Response?
    
    func presentData(response: Main.BookData.Response) {
        presentMovementCalled = true
        presentMovementResponse = response
    }

    func presentError(errorMessage: String) {
        presentMovementCalled = true
    }
}
