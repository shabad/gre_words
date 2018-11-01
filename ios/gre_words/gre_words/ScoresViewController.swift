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
    var questionNum: Int?
    var nextQuestionSegueSent: Bool = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        SocketIOManager.shared.socket.emit("getScores", ["roomCode": self.roomCode!])
        objectArray.removeAll()
        
        SocketIOManager.shared.socket.on("nextQuestion"){data, ack in
            if (self.nextQuestionSegueSent == false){
                self.nextQuestionSegueSent = true
                self.performSegue(withIdentifier: "nextQuestion", sender: nil)
            }
            
            
            
            
        }
        
        
        
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

    

    @IBAction func nextQuestion(_ sender: UIButton) {
        SocketIOManager.shared.socket.emit("getNextQuestion", self.roomCode!)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "nextQuestion" {
            let controller = segue.destination as! gameViewController
            controller.roomCode = self.roomCode
            controller.playerName = self.playerName
            controller.questionNum = self.questionNum! + 1
            controller.sentScoreSegue = false
            
            
        }
    }
 

}
