//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Adrian Koo on 18/06/20.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingImageView: UIImageView!
    @IBOutlet var typeLabel: UILabel!{
        didSet{
            typeLabel.layer.cornerRadius = 5.0
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var heartImageView: UIImageView!{
        didSet{
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            heartImageView.tintColor = .white
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
