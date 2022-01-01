//
//  ArticleTableViewCell.swift
//  RawajTest
//
//  Created by A on 01/01/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var captureLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(_ articleModel: Result, _ row: Int) {
        self.titleLabel.text = articleModel.title
        self.captureLabel.text = articleModel.publishedDate
        self.describtionLabel.text = articleModel.adxKeywords
    }
}
