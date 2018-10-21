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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.nickname ?? "default valued")

        // Do any additional setup after loading the view.
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
