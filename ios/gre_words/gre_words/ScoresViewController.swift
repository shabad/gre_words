//
//  ScoresViewController.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/28/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    

    @IBOutlet weak var scoreTable: UITableView!
    
    struct Objects {
        
        var playerName : String!
        var score : Int!
    }
    
    var objectArray = [Objects]()
    
    var playerName: String?
    var roomCode: String?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        SocketIOManager.shared.socket.emit("getScores", ["roomCode": self.roomCode!])
        
        
        SocketIOManager.shared.socket.on("gameScores"){data, ack in
            
            if let arr = data as? [[String: Any]] {
                print(arr[0])
                for (key, value) in arr[0] {
                    print("\(key) -> \(value)")
                    self.objectArray.append(Objects(playerName: key, score: (value as! Int)))
                }
                }
            
            self.scoreTable.reloadData()

                
            }
            
        
        }
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scoreTable.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = objectArray[indexPath.row].playerName
        cell.detailTextLabel?.text = String(objectArray[indexPath.row].score)
        
        return cell
    }
        // Do any additional setup after loading the view.

    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
