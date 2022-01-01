//
//  ArticleViewController.swift
//  RawajTest
//
//  Created by A on 01/01/2022.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift
class ArticleViewController: BaseViewController {
    var articleViewMode = ArticleViewModel()
    private var router = ArticleConfiguration()
    
    @IBOutlet weak var articleTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setHeaderLabel()
        estimateTableViewHeigh()
        bindViewControllerRouter()
        bindTableViewToViewModel()
        bindLoader()
        bindTableViewApperence()
        fetchArticles()
        selectArticle()
    }
    
    func fetchArticles() {
        articleViewMode.fetchArticle()
    }
    
    func setHeaderLabel() {
        self.navigationItem.title = Title.articleTitle.rawValue
    }
}

extension ArticleViewController {
    func bindViewControllerRouter() {
        articleViewMode.bind(view: self, router: router)
    }
}

extension ArticleViewController {
    func bindTableViewToViewModel() {
        self.articleViewMode.articlesObservables
            .bind(to: self.articleTableview
                    .rx
                    .items(cellIdentifier: String(describing: "ArticleTableViewCell"),
                           cellType: ArticleTableViewCell.self)) { row, model, cell in
                cell.config(model, row)
            }.disposed(by: self.disposeBag)
    }
    
    func bindLoader() {
        articleViewMode.state.isLoading.subscribe(onNext: {[weak self] (isLoading) in
            if isLoading {
                self?.showLoading()
                
            } else {
                self?.hideLoading()
            }
        }).disposed(by: self.disposeBag)
    }
    
    func bindTableViewApperence() {
        articleViewMode.state.isProductTableViewHide.subscribe(onNext: {[weak self] (isHide) in
            if isHide {
                self?.articleTableview.isHidden = true
                
            } else {
                self?.articleTableview.isHidden = false
            }
        }).disposed(by: self.disposeBag)
    }
}

extension ArticleViewController {
    func setUp() {
        articleTableview.register(UINib(nibName: TableView.articleCell.rawValue, bundle: nil),
                                  forCellReuseIdentifier: TableView.articleCell.rawValue)
    }
    
    func estimateTableViewHeigh() {
        self.articleTableview.rowHeight = UITableView.automaticDimension
        self.articleTableview.estimatedRowHeight = 44.0
    }
}

extension ArticleViewController {
    func selectArticle() {
        Observable.zip(articleTableview
                        .rx
                        .itemSelected,
                       articleTableview.rx.modelSelected(Result.self)).bind { [weak self] _, articl in
            self?.articleViewMode.showNextView(soucre: articl)
        }
                        .disposed(by: self.disposeBag)
    }
}
