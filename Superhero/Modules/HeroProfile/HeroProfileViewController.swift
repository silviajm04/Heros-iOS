//
//  HeroProfileViewController.swift
//  Superhero
//
//  Created by coppel on 24/05/20.
//  Copyright © 2020 com.coppel. All rights reserved.
//

import UIKit

class HeroProfileViewController: UIViewController {
    
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var lblHeroName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblAlterEgos: UILabel!
    @IBOutlet weak var lblPlaceOfBirth: UILabel!
    @IBOutlet weak var lblFirstAppearance: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblAlignment: UILabel!
    @IBOutlet weak var lblIntelligence: UILabel!
    @IBOutlet weak var lblStrength: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblDurability: UILabel!
    @IBOutlet weak var lblPower: UILabel!
    @IBOutlet weak var lblCombat: UILabel!
    
    var itemHeroImage : HeroImage = HeroImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHeroImage(url: itemHeroImage.url)
        lblHeroName.text = itemHeroImage.name
        getHeroBiography()
        getHeroPowerstats()
    }
    
    func getHeroBiography(){
        ApiServices().getHeroBiography(id: itemHeroImage.id) { (hero) in
            self.lblFullName.text = "Nombre completo: " + hero.fullName
            self.lblAlterEgos.text = "Alter egos: " + hero.alterEgos
            self.lblPlaceOfBirth.text = "Lugar de nacimiento: " + hero.placeOfBirth
            self.lblFirstAppearance.text = "Primera impresión: " + hero.firstAppearance
            self.lblPublisher.text = "Editor: " + hero.publisher
            self.lblAlignment.text = "Alineación: " + hero.alignment
        }
    }
    
    func getHeroPowerstats(){
        ApiServices().getHeroPowerstats(id: itemHeroImage.id){ (hero) in
            self.lblIntelligence.text = "Inteligencia: " + hero.intelligence
            self.lblStrength.text = "Fuerza: " + hero.strength
            self.lblSpeed.text = "Velocidad: " + hero.speed
            self.lblDurability.text = "Durabilidad: " + hero.durability
            self.lblPower.text = "Poder: " + hero.power
            self.lblCombat.text = "Combate: " + hero.combat
        }
    }
    
    func getHeroImage(url: String){
        imageViewHero.layer.borderWidth = 1
        imageViewHero.layer.masksToBounds = false
        imageViewHero.layer.borderColor = UIColor.gray.cgColor
        imageViewHero.layer.cornerRadius = imageViewHero.frame.height/2
        imageViewHero.clipsToBounds = true
        imageViewHero.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
    }
}
