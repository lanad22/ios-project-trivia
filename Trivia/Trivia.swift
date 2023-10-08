//
//  Trivia.swift
//  Trivia
//
//  Created by Lana Do on 10/7/23.
//

import Foundation

struct Trivia: Decodable {
    var results: [Result]
    
    struct Result: Decodable {
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correctAnswer: String
        var incorrectAnswers: [String]
        var answers: [Choice]{
            let correct = [Choice(text: correctAnswer, isCorrect: true)]
            let incorrects = incorrectAnswers.map { choice in
                Choice(text: choice, isCorrect: false) }
            
            let allAnswers = correct + incorrects
            return allAnswers.shuffled()
        }
    }
}
