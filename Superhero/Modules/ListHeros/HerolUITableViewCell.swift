//
//  HerolUITableViewCell.swift
//  Superhero
//
//  Created by coppel on 24/05/20.
//  Copyright © 2020 com.coppel. All rights reserved.
//

import UIKit
import SDWebImage

class HerolUITableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var lblHeroName: UILabel!
    
    func configureCell(dataHero: HeroImage){
        selectionStyle = .none
        getHeroImage(url: dataHero.url)
        lblHeroName.text = dataHero.name == "" ? "-" : dataHero.name
    }
    
    func getHeroImage(url: String){
        imageViewHero.layer.borderWidth = 1
        imageViewHero.layer.masksToBounds = false
        imageViewHero.layer.borderColor = UIColor.black.cgColor
        imageViewHero.layer.cornerRadius = imageViewHero.frame.height/2
        imageViewHero.clipsToBounds = true
        
        imageViewHero.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
    }
}
