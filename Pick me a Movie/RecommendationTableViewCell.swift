//
//  RecommendationTableViewCell.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 03/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
