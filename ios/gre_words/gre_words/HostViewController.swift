//
//  HostViewController.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/18/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import UIKit
import SocketIO

class HostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var nickname : String?
    
    var members_list: [String] = []
    
    @IBOutlet weak var roomCode: UILabel!
    @IBOutlet weak var membersTable: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membersTable.dequeueReusableCell(withIdentifier: "playerNameCell", for: indexPath)
        cell.textLabel?.text = members_list[indexPath.row]
        return cell
    }
    
    

    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketIOManager.shared.socket.emit("connectHostUser", self.nickname ?? "no name")
        
        
        
        SocketIOManager.shared.socket.on("roomcode") {data, ack in
            if let rCode = data[0] as? String {
                self.roomCode.text = rCode
                
            }
            
        }
        
        
        
        
        SocketIOManager.shared.socket.on("room_members_new"){data, ack in
            if let members = data[0] as? [String]{
                self.members_list = members
                self.membersTable.reloadData()
            }
        }
        
        
        SocketIOManager.shared.socket.on("gameStart") {data, ack in
                self.performSegue(withIdentifier: "startGameSegue", sender: nil)
            
        }
        


        // Do any additional setup after loading the view.
    }
    
    
    
    
    
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      
        
    }

    
    
    
    
    @IBAction func launch_game(_ sender: UIButton) {
            SocketIOManager.shared.socket.emit("launchGame", self.roomCode.text!)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "startGameSegue" {
            let controller = segue.destination as! gameViewController
            
            
        }
        
        
    }
 

}
