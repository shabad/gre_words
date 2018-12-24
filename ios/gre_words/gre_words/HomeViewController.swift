//
//  HomeViewController.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/18/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    var nickname: String = "Anon"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SocketIOManager.shared.socket.connect()
       

        // Do any additional setup after loading the view.
    }
    

    @IBAction func hostGame(_ sender: UIButton) {
        
        
        let alertController = UIAlertController(title: "Enter a nickname", message: "", preferredStyle: .alert)
        
        let submitNameAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            let textField = alertController.textFields![0]
            self.nickname = textField.text!
            self.performSegue(withIdentifier: "hostGameSegue", sender: nil)
            

        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "John Doe"
            textField.keyboardType = .namePhonePad
        }
        
        alertController.addAction(submitNameAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
       
        
    }
    
    @IBAction func joinGame(_ sender: UIButton) {
  
        let alertController = UIAlertController(title: "Enter a nickname", message: "", preferredStyle: .alert)
        
        let submitNameAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            let textField = alertController.textFields![0]
            self.nickname = textField.text!
           
       
            self.performSegue(withIdentifier: "joinGameSegue", sender: nil)
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "John Doe"
            textField.keyboardType = .namePhonePad
        }
        
        alertController.addAction(submitNameAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        // If segue is the HostViewController Segue, we send the nickname to it.
        if segue.identifier == "hostGameSegue" {
            let controller = segue.destination as! HostViewController
            controller.nickname = self.nickname
            
        }
        
        if segue.identifier == "joinGameSegue" {
            let controller = segue.destination as! JoinViewController
            controller.nickname = self.nickname
            
        }
        
        
//        destinationVC.programVar = newProgramVar
    }
    

}
