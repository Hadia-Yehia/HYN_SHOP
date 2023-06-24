//
//  ReviewsViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 15/06/2023.
//

import Foundation
class ReviewsViewModel{
    let reviewArray = [ReviewItem(name: "Hadia Yehia", content: "I had a wonderful experience and I would highly recommend this business to others.", rating: 3.5),ReviewItem(name: "Nada Elshafy", content: "I bought a bag from here. The quality is remarkable. It's well worth the money for their high-quality products, I highly recommended!", rating: 4.5),ReviewItem(name: "Yousra Mamdouh", content: "I had a wonderful experience and I would highly recommend this business to others.", rating: 5),ReviewItem(name: "Sara Eltlt", content: "I bought a bag from here. The quality is remarkable. It's well worth the money for their high-quality products, I highly recommended!", rating: 4),ReviewItem(name: "Farida Bahi", content: "I had a wonderful experience and I would highly recommend this business to others.", rating: 3.5),ReviewItem(name: "Nada Youssef", content: "I bought a bag from here. The quality is remarkable. It's well worth the money for their high-quality products, I highly recommended!", rating: 4.5),ReviewItem(name: "Mariem Adly", content: "I had a wonderful experience and I would highly recommend this business to others.", rating: 3.5),ReviewItem(name: "Menna Ihab", content: "I bought a bag from here. The quality is remarkable. It's well worth the money for their high-quality products, I highly recommended!", rating: 4)]
    func getTableCount()->Int{
        return reviewArray.count
    }
    func getObjectForCell(index:Int)->ReviewItem{
        let revCell = ReviewItem(name: reviewArray[index].name, content: reviewArray[index].content, rating: reviewArray[index].rating)
        return revCell
    }
    
}
