//
//  ArticleViewModel.swift
//  RawajTest
//
//  Created by A on 01/01/2022.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

class ArticleViewModel {
    var state = State()
    private weak var view: ArticleViewController?
    private var router: ArticleConfiguration?
    var articles = PublishSubject<[Result]>()
    var articlesObservables: PublishSubject<[Result]> {
        return articles
    }
     
    func bind(view: ArticleViewController, router: ArticleConfiguration) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}

extension ArticleViewModel: FetchArticles {
    func fetchArticle() {
        state.isLoading.accept(true)
        let parameters = NetowrkParameters().articles
        NetWorkManager.instance.API(method: .get, url: article, parameters: parameters)
        {[weak self] (err,_,response: ArticleModel?) in
            guard let self = self else { return }
            self.state.isLoading.accept(false)
            if let error = err {
                print(error.localizedDescription)
            } else {
                guard let articleModel = response else { return }
                if articleModel.results?.count ?? 0 > 0 {
                    self.articles.onNext(articleModel.results ?? [])
                    self.state.isProductTableViewHide.accept(false)
                } else {
                    self.state.isProductTableViewHide.accept(true)
                }
            }
        }
    }
}
extension ArticleViewModel: pushViewController {
    func showNextView<T>(soucre: T?) {
        router?.navigateToDetailsView(source: soucre)
    }
}
