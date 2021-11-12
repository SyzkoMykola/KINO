//
//  OverviewTableViewCell.swift
//  Kino
//
//  Created by Alina Bilonozhko on 04.05.2021.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithValuesOfReviews(_ review: Review) {
        updateUI(nickName: review.author, content: review.content)
    }
    
    // Update the UI Views
    private func updateUI(nickName: String, content: String) {
        overviewLabel.text = nickName
        nickNameLabel.text = content
        overviewLabel.desingMyCell()
        
    
    }

}
