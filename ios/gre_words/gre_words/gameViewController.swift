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
    var isHost: Bool?
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var gameQuestion: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLabel.text = roomCode
        
        if(isHost == true){
            SocketIOManager.shared.socket.emit("getQuestion", ["roomCode": self.roomCode!, "question_number": self.questionNum])
        }
        
        
        SocketIOManager.shared.socket.on("gameQuestion"){data, ack in
            if let question = data[0] as? String{
                let q = Question(question: question, option1: "Option1", option2: "option2", option3: "intricate", option4: "Option4")
                self.gameQuestion.text = q.question
                self.option1.setTitle(q.option1, for: .normal)
                self.option2.setTitle(q.option2, for: .normal)
                self.option3.setTitle(q.option3, for: .normal)
                self.option4.setTitle(q.option4, for: .normal)
               
            }
        }
        
        // Do any additional setup after loading the view.
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
