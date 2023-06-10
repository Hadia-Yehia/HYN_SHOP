//
//  ReviewTableViewCell.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var reviewContent: UILabel!
    @IBOutlet weak var reviewRating: JStarRatingView!
    
    @IBOutlet weak var reviewName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(review : ReviewItem){
        reviewContent.text = review.content
        reviewName.text = review.name
        reviewRating.rating = review.rating
    }
    
}
