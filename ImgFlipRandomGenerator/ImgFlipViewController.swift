//
//  ImgFlipViewController.swift
//  ImgFlipRandomGenerator
//
//  Created by Chang Choi on 11/17/16.
//  Copyright © 2016 solechang. All rights reserved.
//

import UIKit

class ImgFlipViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var generatedImageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator.hidesWhenStopped = true
        self.userTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    


    @IBAction func submitButtonPressed(_ sender: AnyObject) {
        
        
    }
    
    func getHomePlayers () {
        
        
        let request: BaseRequest = RandomGenerateMemeRequest()
        
        request.completionBlock = { (response, error) in
            
            
            if (error != nil)
            {
                
                print(error!.localizedDescription)
                // TODO: Error handling
            }
            else
            {
                if let json = response {
                    
                    let team = Player()
                    team.playerName = self.game!.home_name
                    team.id = self.game!.home_id
                    team.teamId = self.game!.home_id
                    team.position = "Team"
                    
                    //team.profileImage = (self.game?.away_name)!
                    //self.playersArray.append(team)
                    
                    self.players.append(team)
                    self.homePlayers.append(team)
                    
                    for (_, v) in json   {
                        let value = v.arrayValue
                        
                        for (_,p) in value.enumerated() {
                            let player = Player()
                            
                            player.playerName = p["name"].stringValue
                            player.jersey_number = p["jersey_number"].stringValue
                            player.id = p["id"].stringValue
                            player.position = p["position"].stringValue
                            player.depth = p["depth"].stringValue
                            player.status = p["status"].stringValue
                            player.teamId = self.game!.home_id
                            //player.profileImage = (self.game?.away_id)!
                            
                            //self.playersArray.append(player)
                            //self.playersWithoutFilter.append(player)
                            
                            if (!self.playerIdsSeen.contains(player.id))
                            {
                                self.players.append(player)
                                self.homePlayers.append(player)
                                
                                self.playerIdsSeen.append(player.id)
                            }
                            
                        }
                        
                    }
                    
                    /*
                     if (self.searchFlag == true) {
                     
                     let searchPredicate = NSPredicate(format: "playerName CONTAINS[c] %@", self.playerNameTextField.text!)
                     
                     self.playersArray = (self.playersArray as NSArray).filtered(using: searchPredicate) as! [Player]
                     
                     }
                     */
                    
                    //self.playersArray.sort { $0.playerName < $1.playerName }
                    self.players.sort { $0.playerName < $1.playerName }
                    self.filteredPlayers = self.players
                    
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        request.runRequest()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
