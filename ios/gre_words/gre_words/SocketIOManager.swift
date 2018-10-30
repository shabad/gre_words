//
//  SocketIOManager.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/18/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import Foundation

import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    
    
    
    var socket: SocketIOClient!
    
    // defaultNamespaceSocket and swiftSocket both share a single connection to the server
    let manager = SocketManager(socketURL: URL(string: "http://localhost:5000")!, config: [.log(true), .forceWebsockets(true)])
    
    override init() {
        super.init()
        
        socket = manager.defaultSocket
    }
    
    func connectSocket() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        socket.connect()
    }
    
    
    func disconnectSocket() {

        socket.disconnect()
    
        
        
    }
    
    func joinRoom(room: String){
        socket.emit("join", room)
        
    }
    
    func getRoomCode(){
        socket.on("roomCode") { (data, SocketAckEmitter) in
            print(data)
        }
        
    }
    
    func connectToServerWithNickname(nickname: String) -> String {
        var Rcode:String?
        socket.emit("connectHostUser", nickname)
        socket.on("roomcode") { (code, SocketAckEmitter) in
            Rcode = "code as String"
        }
        return Rcode ?? "problem"
        }
        
    
    
    
    
//    func receiveMsg() {
//        socket.on("new message here") { (dataArray, ack) in
//
//            print(dataArray.count)
//
//        }
    
    }

