//
//  DetailsViewModel.swift
//  RawajTest
//
//  Created by A on 01/01/2022.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

class DetailsViewModel {
    
    private weak var view: DetailsViewController?
    private var router: DetailsConfiguration?
    var articles: Result?
    var titleObserver = BehaviorRelay<String>(value: "")
    var describtionObserver = BehaviorRelay<String>(value: "")
    var articleImageObserver = BehaviorRelay<String>(value: "")
    
    func bind(view: DetailsViewController, router: DetailsConfiguration) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}

extension DetailsViewModel {
    func intializeData() {
        if let article = articles {
            self.titleObserver.accept(article.title ?? "")
        self.describtionObserver.accept(article.adxKeywords ?? "")
            if (article.media?.count ?? 0) > 0 {
        self.articleImageObserver.accept(article.media?[0].mediaMetadata?[0].url ?? "")
            }
        }
    }
}
