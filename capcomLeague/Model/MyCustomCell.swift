//
//  MyCustomCell.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 27/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    @IBOutlet weak var imageCharacters: UIImageView!
    
    @IBOutlet weak var labelPlacing: UILabel!
    
    @IBOutlet weak var labelHandle: UILabel!

    @IBOutlet weak var labelPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Clear all content based views and their actions here
        
        imageCharacters.image = nil
        
        labelPlacing.text = ""
        
        labelHandle.text = ""
        
        labelPoints.text = ""
    }
    
 
    

}
