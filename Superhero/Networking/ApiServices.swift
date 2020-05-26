//
//  ApiServices.swift
//  Superhero
//
//  Created by coppel on 23/05/20.
//  Copyright © 2020 com.coppel. All rights reserved.
//

import UIKit
import Alamofire
class ApiServices: NSObject {
    
    func getUrlBase()-> String{
        return "https://superheroapi.com/api/2610415182616544/"
    }
    //MARK: - API Image
    private func getRequestAPICallHeroImage(id: String, success:@escaping([String:AnyObject]) -> ()){
        let getHeroImageUrl: String = getUrlBase() + "\(id)/image"
        Alamofire.request(getHeroImageUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in debugPrint(response)
            if let data = response.result.value{
                if let dataDecode = data as? [String:AnyObject]{
                    success(dataDecode)
                }
            }
        }
    }
    
    func getHero(id: String, success:@escaping(HeroImage?)->()){
        getRequestAPICallHeroImage(id: id){(heroDic) in
            var hero: HeroImage = HeroImage()
            let id: String = (heroDic["id"] as? String) ?? ""
            let name: String = (heroDic["name"] as? String) ?? ""
            let url: String = (heroDic["url"] as? String) ?? ""
            let response: String = (heroDic["response"] as? String) ?? ""
            
            hero.id = id
            hero.name = name
            hero.url = url
            hero.response = response
            
            if(hero.id == ""){
                success(nil)
            }else{
                success(hero)
            }
        }
    }
    //MARK: - API Biography
    private func getRequestAPICallHeroBiography(id: String, success:@escaping([String:AnyObject]) -> ()){
        let getHeroBiographyUrl: String = getUrlBase() + "\(id)/biography"
        Alamofire.request(getHeroBiographyUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in debugPrint(response)
            if let data = response.result.value{
                if let dataDecode = data as? [String:AnyObject]{
                    success(dataDecode)
                }
            }
        }
    }
    
    func getHeroBiography(id: String, success:@escaping(HeroBiography)->()){
        getRequestAPICallHeroBiography(id: id){(heroDic) in
            var hero: HeroBiography = HeroBiography()
            let id: String = (heroDic["id"] as? String) ?? ""
            let name: String = (heroDic["name"] as? String) ?? "-"
            let fullName: String = (heroDic["full-name"] as? String) ?? ""
            let alterEgos: String = (heroDic["alter-egos"] as? String) ?? ""
            let aliases: [String] = (heroDic["aliases"] as? [String]) ?? [""]
            let placeOfBirth: String = (heroDic["place-of-birth"] as? String) ?? ""
            let firstAppearance: String = (heroDic["first-appearance"] as? String) ?? ""
            let publisher: String = (heroDic["publisher"] as? String) ?? ""
            let alignment: String = (heroDic["alignment"] as? String) ?? ""
            let response: String = (heroDic["response"] as? String) ?? ""
            
            hero.id = id
            hero.name = name
            hero.fullName = fullName
            hero.alterEgos = alterEgos
            hero.placeOfBirth = placeOfBirth
            hero.firstAppearance = firstAppearance
            hero.publisher = publisher
            hero.alignment = alignment
            hero.response = response
            hero.aliases = aliases
            success(hero)
        }
    }
    
    //MARK: - API Powerstats
    private func getRequestAPICallHeroPowerstats(id: String, success:@escaping([String:AnyObject]) -> ()){
        let getHeroPowerstatsUrl: String = getUrlBase() + "\(id)/powerstats"
        Alamofire.request(getHeroPowerstatsUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in debugPrint(response)
            if let data = response.result.value{
                if let dataDecode = data as? [String:AnyObject]{
                    success(dataDecode)
                }
            }
        }
    }
    
    func getHeroPowerstats(id: String, success:@escaping(HeroPowerstats)->()){
        getRequestAPICallHeroPowerstats(id: id){(heroDic) in
            var hero: HeroPowerstats = HeroPowerstats()
            let id: String = (heroDic["id"] as? String) ?? ""
            let name: String = (heroDic["name"] as? String) ?? "-"
            let intelligence: String = (heroDic["intelligence"] as? String) ?? ""
            let strength: String = (heroDic["strength"] as? String) ?? ""
            let speed: String = (heroDic["speed"] as? String) ?? ""
            let durability: String = (heroDic["durability"] as? String) ?? ""
            let power: String = (heroDic["power"] as? String) ?? ""
            let combat: String = (heroDic["combat"] as? String) ?? ""
            let response: String = (heroDic["response"] as? String) ?? ""
            
            hero.id = id
            hero.name = name
            hero.intelligence = intelligence
            hero.strength = strength
            hero.speed = speed
            hero.durability = durability
            hero.power = power
            hero.combat = combat
            hero.response = response
            success(hero)
        }
    }
}
