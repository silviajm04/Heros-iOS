//
//  ListHerosViewController.swift
//  Superhero
//
//  Created by coppel on 23/05/20.
//  Copyright © 2020 com.coppel. All rights reserved.
//

import UIKit

class ListHerosViewController: UIViewController {
    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableViewListHeros: UITableView!
    @IBOutlet weak var collectionViewListHeros: UICollectionView!
    
    var arrayHeros: [HeroImage] = []
    var arrayHerosCollection: [HeroImage] = []
    var arrayHerosFilter: [HeroImage] = []
    var arrayHerosCollectionFilter: [HeroImage] = []
    var startDownloadTableView = 1
    var continueDownloadTableView = 10
    var itemsDownLoadingTableView = 0
    var startDownloadCollectionView = 1
    var continueDownloadCollectionView = 5
    var itemsDownLoadingCollectionView = 0
    var searchActive = false
    var isDownloadingCollectionView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getItemsHeros()
        configTableViewListHeros()
        getItemsHerosCollectionView()
        configCollectionViewListHeros()
        configTextFieldSearch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       if segue.identifier == "toHeroDeatil"{
            guard let heroBiographyVC = segue.destination as? HeroProfileViewController else { return }
            guard let itemHero = sender as? HeroImage else { return }
            heroBiographyVC.itemHeroImage = itemHero
       }
    }
    
    //MARK: - IBActions
    @IBAction func btnSearchBar(_ sender: Any) {
        guard textFieldSearch.text != "" else {return}
        searchActive = true
        self.arrayHerosFilter = arrayHeros.filter { item in
            return item.name.lowercased().contains(textFieldSearch.text!.lowercased())
        }
        tableViewListHeros.reloadData()
        
        self.arrayHerosCollectionFilter = arrayHerosCollection.filter { item in
            return item.name.lowercased().contains(textFieldSearch.text!.lowercased())
        }
        collectionViewListHeros.reloadData()
        
    }
    //MARK: - Utils
    func configTextFieldSearch(){
        textFieldSearch.delegate = self
    }
    
    func configTableViewListHeros(){
        tableViewListHeros.delegate = self
        tableViewListHeros.dataSource = self
    }
    
    func configCollectionViewListHeros(){
          collectionViewListHeros.delegate = self
          collectionViewListHeros.dataSource = self
    }
    
    func getItemsHeros(){
        for id in startDownloadTableView...continueDownloadTableView {
            ApiServices().getHero(id: String(id)) {(hero) in
                self.itemsDownLoadingTableView = self.itemsDownLoadingTableView + 1
                if let hero = hero{
                    self.arrayHeros.append(hero)
                    self.tableViewListHeros.reloadData()
                }
            }
        }
        startDownloadTableView = continueDownloadTableView + 1
        continueDownloadTableView += 10
    }
    
    func getItemsHerosCollectionView(){
        for id in startDownloadCollectionView...continueDownloadCollectionView  {
            ApiServices().getHero(id: String(id)) {(hero) in
                self.itemsDownLoadingCollectionView = self.itemsDownLoadingCollectionView + 1
                if let hero = hero{
                    self.arrayHerosCollection.append(hero)
                    self.collectionViewListHeros.reloadData()
                }
            }
        }
        startDownloadCollectionView = continueDownloadCollectionView + 1
        continueDownloadCollectionView += 5
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListHerosViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let tmpHeros: HeroImage = arrayHeros[indexPath.row]
        self.performSegue(withIdentifier: "toHeroDeatil", sender: tmpHeros)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
           return arrayHerosFilter.count
        }else{
            return arrayHeros.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewListHeros.dequeueReusableCell(withIdentifier: "heroCell") as? HerolUITableViewCell else { return UITableViewCell() }
            let hero: HeroImage
            if(searchActive){
                hero = arrayHerosFilter[indexPath.row]
            }else{
                hero = arrayHeros[indexPath.row]
            }
            cell.configureCell(dataHero: hero)
            return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if itemsDownLoadingTableView == startDownloadTableView - 1{
                getItemsHeros()
            }
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ListHerosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tmpHero: HeroImage = arrayHerosCollection[indexPath.row]
        self.performSegue(withIdentifier: "toHeroDeatil", sender: tmpHero)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if ((indexPath.row + 1 == arrayHerosCollection.count - 1)) {
            if itemsDownLoadingCollectionView == startDownloadCollectionView - 1 {
                getItemsHerosCollectionView()
            }
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height : 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive){
            return arrayHerosCollectionFilter.count
        }else{
            return arrayHerosCollection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewListHeros.dequeueReusableCell(withReuseIdentifier: "heroImageCollectionViewCell", for: indexPath) as? HeroImageCollectionViewCell else { return UICollectionViewCell()  }
            let hero: HeroImage
            if(searchActive){
                hero = arrayHerosCollectionFilter[indexPath.row]
            }else{
                hero = arrayHerosCollection[indexPath.row]
            }
            cell.configureData(hero: hero)
            return cell
    }
    
}

//MARK: - UITextFieldDelegate
extension ListHerosViewController: UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        startDownloadTableView = 1
        continueDownloadTableView = 10
        itemsDownLoadingTableView = 0
        startDownloadCollectionView = 1
        continueDownloadCollectionView = 5
        itemsDownLoadingCollectionView = 0
        arrayHeros = []
        arrayHerosCollection = []
        arrayHerosFilter = []
        arrayHerosCollectionFilter = []
        searchActive = false
        getItemsHeros()
        getItemsHerosCollectionView()
        return true
    }
}
   

