//
//  Question.swift
//  gre_words
//
//  Created by Shabad Sobti on 10/26/18.
//  Copyright © 2018 Shabad Sobti. All rights reserved.
//

import Foundation

class Question {
    var question: String
    var option1: String
    var option2: String
    var option3: String
    var option4: String
    
    init(question: String, option1: String, option2: String, option3: String, option4: String) {
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4

    }
}
