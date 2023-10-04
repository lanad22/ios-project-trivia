//
//  Question.swift
//  Trivia
//
//  Created by Lana Do on 10/3/23.
//

import Foundation
struct Question {
    let number: Int
    let category: String
    let content: String
    let choice1: String
    let choice2: String
    let choice3: String
    let choice4: String
    let correctChoice: String
}

enum CorrectChoice: Int {
    case choice1 = 1
    case choice2 = 2
    case choice3 = 3
    case choice4 = 4
}
