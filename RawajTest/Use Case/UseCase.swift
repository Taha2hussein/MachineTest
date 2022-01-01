//
//  UseCase.swift
//  BeyondTask
//
//  Created by A on 29/12/2021.
//

import UIKit
protocol FetchArticles {
    func fetchArticle()
}

protocol pushViewController {
    func showNextView<T>(soucre: T?)
}
