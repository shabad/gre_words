//
//  WaitingRoomViewController.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/24/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import UIKit

class WaitingRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var membersTable: UITableView!
    
    var members_list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketIOManager.shared.socket.on("room_members_new"){data, ack in
            if let members = data[0] as? [String]{
                self.members_list = members
                self.membersTable.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membersTable.dequeueReusableCell(withIdentifier: "playerNameCell", for: indexPath)
        cell.textLabel?.text = members_list[indexPath.row]
        return cell
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
