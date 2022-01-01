//
//  DetailsConfiguration.swift
//  RawajTest
//
//  Created by A on 01/01/2022.
//
import UIKit
class DetailsConfiguration {
    var viewController: UIViewController {
        return createViewController()
    }
    private var source: Result?
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
      
        let view = UIStoryboard.init(name: Storyboards.articleDetails.rawValue, bundle: nil)
        
        let viewController = view.instantiateViewController(withIdentifier: ViewController.articleDetails.rawValue)
           as? DetailsViewController
        
        viewController?.articleDetailsViewModel.articles = source
        return viewController!
    }
    
    init() {
        
    }
    
    init<T>(source: T?) {
        self.source = source as? Result
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
}
