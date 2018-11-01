//
//  gameViewController.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/25/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
    
    var roomCode: String?
    var playerName: String?
    var questionNum: Int = 1
  
    
    var correct_answer: String?
    var isHost: Bool?
    var sentScoreSegue: Bool = false
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var gameQuestion: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var ans: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLabel.text = roomCode
        
//        if(isHost == true){
            SocketIOManager.shared.socket.emit("getQuestion", ["roomCode": self.roomCode!, "question_number": self.questionNum])
//        }
        self.navigationItem.title = "Question " + String(self.questionNum) ;
        
        
        SocketIOManager.shared.socket.on("gameQuestion"){data, ack in

            if let arr = data as? [[String: Any]] {
                if let txt = arr[0]["question"] as? String {
                     self.gameQuestion.text = txt
                }
                if let txt = arr[0]["answer"] as? String {
                    self.correct_answer = txt
                    self.ans.text = txt
                }
                if let txt = arr[0]["option1"] as? String {
                    self.option1.setTitle(txt, for: .normal)
                }
                
                if let txt = arr[0]["option2"] as? String {
                    self.option2.setTitle(txt, for: .normal)
                }
                
                if let txt = arr[0]["option3"] as? String {
                    self.option3.setTitle(txt, for: .normal)
                }
                
                if let txt = arr[0]["option4"] as? String {
                    self.option4.setTitle(txt, for: .normal)
                }
                
            }
            
  
        }
        
   
        SocketIOManager.shared.socket.on("scoreScreen"){data, ack in
            if(self.sentScoreSegue == false){
                self.sentScoreSegue = true
                self.performSegue(withIdentifier: "scoreScreenSegue", sender: nil)
                
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func selectOption(sender: UIButton) {
        
        if sender.title(for: .normal) == self.correct_answer{
            SocketIOManager.shared.socket.emit("correct_answer", ["roomCode": self.roomCode!, "question_number": self.questionNum, "name": self.playerName!])
        }
        else{
            SocketIOManager.shared.socket.emit("wrong_answer", ["roomCode": self.roomCode!, "question_number": self.questionNum, "name": self.playerName!])
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "scoreScreenSegue" {
            let controller = segue.destination as! ScoresViewController
            controller.roomCode = self.roomCode
            controller.playerName = self.playerName
            controller.questionNum = self.questionNum
            controller.nextQuestionSegueSent = false
            
            
        }
    }
 

}
