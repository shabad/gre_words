//
//  JoinViewController.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/18/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    var nickname : String?
    
 
    @IBOutlet weak var roomCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onJoin(sender: UIButton){
        
        SocketIOManager.shared.socket.emit("connectPlayerUser", ["nickname": self.nickname, "roomCode": self.roomCode.text])
        
            self.performSegue(withIdentifier: "waitingRoomSegue", sender: nil)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "waitingRoomSegue" {
            let controller = segue.destination as! WaitingRoomViewController
            controller.roomCode = self.roomCode.text
            controller.playerName = self.nickname
            
            
        }
        
    }
 

}
