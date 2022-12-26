//
//  ViewController.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 27/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController{
    
    @IBOutlet var mainView: UIView!{
    
        didSet{
            
            mainView.backgroundColor = UIColor(patternImage: UIImage(named:"cover_street_fighter")!)
        }
        
    }
    
    @IBOutlet weak var leagueTable: UITableView!{
        
        didSet {
            
            leagueTable.delegate = self
            
            leagueTable.backgroundColor = UIColor.clear
            
            leagueTable.layer.borderWidth = 1.5
            
            leagueTable.layer.borderColor = UIColor.white.cgColor
            
            leagueTable.layer.cornerRadius = 10.0
            
            leagueTable.layer.masksToBounds = true
        }
        
    }
    
    @IBOutlet weak var addPlayer: UIButton!{
        
        didSet{
            
            let gradient = customGradient.getGradientLayer(bounds: addPlayer.bounds, startX: 0.00, endX: 1.00, startY: 0.50, endY: 0.50)
            
            addPlayer.setTitleColor(customGradient.gradientColor(bounds: addPlayer.bounds, gradientLayer: gradient), for: .normal)
            
            
            addPlayer.addTarget(self, action: #selector(clickAddPlayer), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var ladelAdd: UILabel! {
        
        didSet{
            
              let gradient = customGradient.getGradientLayer(bounds: ladelAdd.bounds, startX: 0.50, endX: 0.50, startY: 0.00, endY: 1.00)
            
              ladelAdd.textColor = customGradient.gradientColor(bounds: ladelAdd.bounds, gradientLayer: gradient)
        }
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!{
        
        didSet{
            
            searchBar.delegate = self
            
            searchBar.layer.borderColor = UIColor.white.cgColor
            
            searchBar.layer.borderWidth = 1.0
            
            searchBar.layer.cornerRadius = 10
            
            searchBar.layer.masksToBounds = true
            
        }
        
    }
    
    var playersList: [Player] = []
    
    var _playersList: [Player] = []
    
    var filterData: [String]? = []
    
    var namePlayersList: [String] = []
    
    let manager = ManagerUserDafaults()
    
    let alert = UIAlertController()
    
    let customGradient = CustomGradient()
    
    let methods = AttributesMethods()
    
    let dao = Dao()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == KeyChain.KEY_SEGUE.rawValue {
            
            let index = leagueTable.indexPathForSelectedRow!
            
            let row = index.row
            
            let selectPlayer = playersList[row]
            
            let playerDetail = PlayerDetail(name: selectPlayer.name!, country: selectPlayer.country!,characters: selectPlayer.characters!,points: Int(selectPlayer.points),profile: selectPlayer.profile ?? "")
            
            manager.saveData(player: playerDetail, key: KeyChain.KEY_MANAGER_DETAIL.rawValue)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        initView()
        
        self.leagueTable.reloadData()
        
    }
    
    func initView(){
        
        let tempPlayerList = dao.reloadData(players: &_playersList)
        
        playersList = methods.playersOrdered(players: tempPlayerList)
        
        playersList.forEach{ player in
            
            namePlayersList.append(player.name!)
            
            
        }
        
    }
    
    @objc func clickAddPlayer() {
 
            alert.saveDataAlert(view: self, players: _playersList) { (list) in
            
            self._playersList = list
            
            self.playersList = self.methods.playersOrdered(players: self._playersList)
            
            self.initView()
            
            self.leagueTable.reloadData()
            
        }
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playersList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let players = playersList[indexPath.row]
        
        let cell: MyCustomCell = leagueTable.dequeueReusableCell(withIdentifier: KeyChain.KEY_CELL.rawValue,for:indexPath) as! MyCustomCell
    
        cell.labelPlacing?.text = String(playersList.index(after: indexPath.row))
        
        cell.labelHandle?.text = players.name
        
        cell.labelPoints?.text = String(players.points)
        
        cell.imageCharacters.image = UIImage(named: methods.imageCharacters(name: players.characters!.lowercased()))
    
        return cell
        
    }

    
}


extension ViewController: UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            
            filterData = namePlayersList.filter{ (item) -> Bool in
                
                return item.range(of: searchText, options: .caseInsensitive , range: nil, locale: nil) != nil
                
            }
            
            guard let playerFound = filterData?.first else{
                
                return
            }
            
            let searchPlayer = dao.searchData(player: playerFound, player: &_playersList)
            
            _playersList = searchPlayer
            
            playersList = methods.playersOrdered(players: _playersList)
            
            leagueTable.reloadData()
            
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    
}

