//
//  DetailsViewController.swift
//  RawajTest
//
//  Created by A on 01/01/2022.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
class DetailsViewController: BaseViewController {

    @IBOutlet weak var articleDescribtion: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleDetailsViewModel = DetailsViewModel()
    private var router = DetailsConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewControllerRouter()
        bindToTitleLabel()
        bindToDescribtionLabel()
        bindToArticleImage()
        
    }
    
    func setup() {
        articleDetailsViewModel.intializeData()
    }
}

extension DetailsViewController {
    func bindViewControllerRouter() {
        articleDetailsViewModel.bind(view: self, router: router)
    }
}

extension DetailsViewController {
    func bindToTitleLabel() {
        articleDetailsViewModel.titleObserver
            .bind(to: articleTitle.rx.text)
        .disposed(by: self.disposeBag)

    }
    
    func bindToDescribtionLabel() {
        articleDetailsViewModel.describtionObserver
            .bind(to: articleDescribtion.rx.text)
        .disposed(by: self.disposeBag)
    }
    
    func bindToArticleImage() {
        articleDetailsViewModel.articleImageObserver.subscribe {[weak self] imageURL in
            self?.setImage(image: imageURL)
        }.disposed(by: self.disposeBag)

    }
    
    func setImage(image: String) {
        if let url = URL(string: image) {
        self.articleImageView.load(url: url)
        }
    }
}
