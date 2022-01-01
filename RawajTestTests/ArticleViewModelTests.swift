//
//  ArticleViewModelTest.swift
//  RawajTestTests
//
//  Created by A on 01/01/2022.
//

import XCTest
import RxSwift
import RxTest
import RxCocoa
import RxRelay
import RxBlocking

@testable import RawajTest

class ArticleViewModelTest: XCTestCase {
    var viewModel: ArticleViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        print("ss")
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.viewModel = ArticleViewModel()
    }

    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }

    func testFetchArticles() {
        // create scheduler
        let articles = scheduler.createObserver([Result].self)

        // giving a service mocking articles
        let expectedArticles: [Result] = DataGenerator.finishFetchData().results ?? []
        viewModel.articles.onNext(expectedArticles)

        scheduler.start()
        print(expectedArticles.count)
        // succcess case
        XCTAssertEqual(articles.events, [])
        XCTAssertGreaterThan(expectedArticles.count, 1)
        // failed case
        XCTAssertEqual(articles.events, [.next(10, expectedArticles), .next(30, expectedArticles)])

    }
}

class DataGenerator {

    static func finishFetchData() -> ArticleModel {
        let fileName = "sample"
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
            let articlesFromFile = (try? decoder.decode(ArticleModel.self, from: data)) ?? nil
            return articlesFromFile ?? ArticleModel()
        }
        return  ArticleModel()
    }
}
