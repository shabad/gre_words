//
//  HostViewController.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/18/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import UIKit
import SocketIO

class HostViewController: UIViewController {
    
    var nickname : String?
    
    var members: [String] = []
    
    @IBOutlet weak var roomCode: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketIOManager.shared.socket.emit("connectHostUser", self.nickname ?? "no name")
        
        
        if let nickname = self.nickname {
            members.append(nickname)
            for element in members {
                print("Member: " + element)
            }
        }
        
        SocketIOManager.shared.socket.on("roomcode") {data, ack in
            if let rCode = data[0] as? String {
                self.roomCode.text = rCode
                
            }
            
        }
        


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      
        
    }

    
    
    
    @IBAction func launch_game(_ sender: UIButton) {
       
       
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
