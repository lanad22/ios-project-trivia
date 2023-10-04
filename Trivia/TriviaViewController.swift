//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Lana Do on 10/3/23.
//

import UIKit

class TriviaViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionList = createMockData()
        display(with: questionList[index])
        choiceButton1.layer.cornerRadius = 15
        choiceButton2.layer.cornerRadius = 15
        choiceButton3.layer.cornerRadius = 15
        choiceButton4.layer.cornerRadius = 15
    }
    
    
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var questionCategory: UILabel!
    @IBOutlet weak var questionContent: UILabel!
    
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton3: UIButton!
    @IBOutlet weak var choiceButton4: UIButton!
    
    
    @IBAction func clickedButton(_ sender: UIButton) {
        
        let clickedChoice = sender.titleLabel?.text
        let question = questionList[index]
        
        if clickedChoice == question.correctChoice{
            points += 1
        }
        index += 1
        
        if index < questionList.count {
            display(with: questionList[index])
        } else {
            gameOver()
        }
    }
    
    private var questionList = [Question]()
    private var index = 0
    private var points = 0
    private func createMockData() -> [Question] {
        let mockData1 = Question(
            number: 1,
            category: "Entertainment",
            content: "What was the first feature-length animated movie ever released?",
            choice1: "Spirited Away",
            choice2: "Snow White and the Seven Dwarfs",
            choice3: "Anastasia",
            choice4: "The Thief and the Cobbler",
            correctChoice: "Snow White and the Seven Dwarfs"
        )
        
        let mockData2 = Question(
            number: 2,
            category: "Food and Drink",
            content: "What is the rarest M&M color?",
            choice1: "Red",
            choice2: "Green",
            choice3: "Purple",
            choice4: "Brown",
            correctChoice: "Brown"
        )
        
        let mockData3 = Question(
            number: 3,
            category: "Sports",
            content: "Which Basketball team has completed two threepeats",
            choice1: "Chicago Bulls",
            choice2: "San Francisco Warriors",
            choice3: "Los Angeles Lakers",
            choice4: "Boston Celtics",
            correctChoice: "Chicago Bulls"
        )
        
        return [mockData1, mockData2, mockData3]
    }
    
    private func display(with question: Question) {
        questionCount.text = "Question: " + String(question.number) + "/" + String(questionList.count)
        questionContent.text = question.content
        questionCategory.text = question.category
        choiceButton1.setTitle(question.choice1, for: .normal)
        choiceButton2.setTitle(question.choice2, for: .normal)
        choiceButton3.setTitle(question.choice3, for: .normal)
        choiceButton4.setTitle(question.choice4, for: .normal)
        
    }
    
    func gameOver(){
        let pointsDisplay = "Final Score: \(points) out of \(questionList.count)"
        let alert = UIAlertController(title: "Game Over", message: pointsDisplay, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {action in self.restart()})
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
    func restart(){
        points = 0
        index = 0
        display(with: questionList[index])
    }
}
