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
    
    @IBOutlet weak var gameQuestion: UILabel!


    @IBOutlet weak var ans: UILabel!
    
 
// Current Answer Field
    
    @IBOutlet weak var current_answer: UILabel!
    
    // KeyPad Buttons
    
    @IBOutlet weak var key1: UIButton!
    @IBOutlet weak var key2: UIButton!
    @IBOutlet weak var key3: UIButton!
    @IBOutlet weak var key4: UIButton!
    @IBOutlet weak var key5: UIButton!
    @IBOutlet weak var key6: UIButton!
    @IBOutlet weak var key7: UIButton!
    @IBOutlet weak var key8: UIButton!
    @IBOutlet weak var key9: UIButton!
    @IBOutlet weak var key10: UIButton!
    @IBOutlet weak var key11: UIButton!
    @IBOutlet weak var key12: UIButton!
    @IBOutlet weak var key13: UIButton!
    @IBOutlet weak var key14: UIButton!
    @IBOutlet weak var key15: UIButton!
    @IBOutlet weak var key16: UIButton!
    
    
    
    var keypad = [UIButton]()
    
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    
    var characters = Array<Character>()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Add all buttons
        
        self.keypad.append(self.key1)
        self.keypad.append(self.key2)
        self.keypad.append(self.key3)
        self.keypad.append(self.key4)
        self.keypad.append(self.key5)
        self.keypad.append(self.key6)
        self.keypad.append(self.key7)
        self.keypad.append(self.key8)
        self.keypad.append(self.key9)
        self.keypad.append(self.key10)
        self.keypad.append(self.key11)
        self.keypad.append(self.key12)
        self.keypad.append(self.key13)
        self.keypad.append(self.key14)
        self.keypad.append(self.key15)
        self.keypad.append(self.key16)
        
        current_answer.text = ""
        
        
        
        
        
        
        
        
        
        
        
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
                    self.characters = Array(txt)
                    self.ans.text = txt
                    
                    let remainder : Int = 16 - self.characters.count
                    
                    
                    let remainder_list = Array(self.randomString(length: remainder))
                    
                    self.characters.append(contentsOf: remainder_list)
                    
                    self.characters.shuffle()
                    print(self.characters)
                    var pos = 0
                    for elem in self.characters {
                        print(String(elem))
                        
                        self.keypad[pos].setTitle(String(elem), for: .normal)
                        pos = pos+1
                    }
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
    
    @IBAction func keyButtonPress(sender: UIButton) {
      
        current_answer.text = current_answer.text! + sender.title(for: .normal)!
        
    }
    
    
    
    @IBAction func submitAns(_ sender: UIButton) {
        
        if self.current_answer.text == self.correct_answer{
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
