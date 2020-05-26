//
//  HeroImageCollectionViewCell.swift
//  Superhero
//
//  Created by coppel on 25/05/20.
//  Copyright © 2020 com.coppel. All rights reserved.
//

import UIKit

class HeroImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    func configureData(hero: HeroImage){
        lblName.text = hero.name
        getHeroImage(url: hero.url)
    }
    
    func getHeroImage(url: String){
        self.backgroundColor = .green
          imageViewHero.layer.borderWidth = 1
          imageViewHero.layer.masksToBounds = false
          imageViewHero.layer.borderColor = UIColor.black.cgColor
          imageViewHero.layer.cornerRadius = imageViewHero.frame.height/2
          imageViewHero.clipsToBounds = true
          imageViewHero.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
      }
}
