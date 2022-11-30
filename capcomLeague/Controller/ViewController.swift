//
//  ViewController.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 27/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

import Foundation

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
        }
    }
    
    @IBOutlet weak var addPlayer: UIButton!{
        
        didSet{
            
            let gradient = gradientClass.getGradientLayer(bounds: addPlayer.bounds, startX: 0.00, endX: 1.00, startY: 0.50, endY: 0.50)
            
            addPlayer.setTitleColor(gradientClass.gradientColor(bounds: addPlayer.bounds, gradientLayer: gradient), for: .normal)
            
            
            addPlayer.addTarget(self, action: #selector(clickAddPlayer), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var ladelAdd: UILabel! {
        
        didSet{
            
              let gradient = gradientClass.getGradientLayer(bounds: ladelAdd.bounds, startX: 0.50, endX: 0.50, startY: 0.00, endY: 1.00)
            
              ladelAdd.textColor = gradientClass.gradientColor(bounds: ladelAdd.bounds, gradientLayer: gradient)
        }
    }
    
    let manager = ManegerUserDefaults()
    
    let gradientClass = Gradient()
    
    let testList = TestListForLoad()
    
    let customAlert = MyCustomAlert()
    
    var playerList = [Player]()
    
    var _playerList = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPlayerList()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" {
            
            let index = leagueTable.indexPathForSelectedRow!
            
            let row = index.row
            
            manager.saveData(player: (playerList[row]))
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    private func initPlayerList(){
        
        _playerList = testList.listForLoad!
        
        playerList = testList.playersOrdered(players: _playerList)
        
    }
    
    @objc func clickAddPlayer(){
 
        customAlert.initCustomAlert(view: self, player: _playerList){ (bisPlayerList) in
            
            self._playerList = bisPlayerList
            
            self.playerList = self.testList.playersOrdered(players: self._playerList) 
            
            self.leagueTable.reloadData()
            
            
        }

    }
    
    
}


extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playerList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyCustomCell = leagueTable.dequeueReusableCell(withIdentifier: "ranking_cell",for:indexPath)
                                as! MyCustomCell
    
        cell.labelPlacing?.text = String(playerList.index(after: indexPath.row))
        
        cell.labelHandle?.text = playerList[indexPath.row].name
        
        cell.labelPoints?.text = String(playerList[indexPath.row].points)
        
        cell.imageProfile.downloaded(from: playerList[indexPath.row].imageCharacters(name: playerList[indexPath.row].characters.lowercased()))
    
        return cell
        
    }

    
    }


extension ViewController: UITableViewDelegate{
    
    
    
}

