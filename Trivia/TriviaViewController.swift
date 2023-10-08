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
        Task.init {
            await fetchTrivia()
            if index < questionList.count{
                answerChoices = questionList[index].answers
                createButtons(answerChoices)
            }
            
        }
    }
    
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var questionCategory: UILabel!
    @IBOutlet weak var questionContent: UILabel!
    
    
    private var questionList: [Trivia.Result] = []
    private var answerChoices: [Choice] = []
    private var index = 0
    private var points = 0
    
    func fetchTrivia() async {
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing")}
        let urlRequest = URLRequest(url:url)
        
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)
            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
                self.index = 0
                self.points = 0
                // Set new values for all variables
                self.questionList = decodedData.results
                self.display()
            }
            
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    
    private func display() {
        let question = questionList[index]
        questionCount.text = "Question: " + String(index+1) + "/" + String(questionList.count)
        questionContent.text = question.question
        questionCategory.text = question.category
        answerChoices = question.answers
        createButtons(answerChoices)
    }
    
    func createButtons(_ answerChoices: [Choice]) {
        view.subviews.compactMap { $0 as? UIButton }.forEach { $0.removeFromSuperview() }
        let buttonWidth: CGFloat = 300
        let buttonHeight: CGFloat = 50
        
        for (index, answer) in answerChoices.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(answer.text, for: .normal)
            button.frame = CGRect(x: (view.frame.width - buttonWidth) / 2, y: CGFloat(index) * (buttonHeight + 20) + 450, width: buttonWidth, height: buttonHeight)
            button.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index
            view.addSubview(button)
        }
    }
    @objc func buttonTapped(_ sender: UIButton){
        let selectedIndex = sender.tag
        let selectedAnswer = answerChoices[selectedIndex]
        if selectedAnswer.isCorrect {
            points += 1
        } 
        index += 1
        
        if index < questionList.count {
            display()
        } else {
            gameOver()
        }
    }
    
    func gameOver(){
        let pointsDisplay = "Final Score: \(points) out of \(questionList.count)"
        let alert = UIAlertController(title: "Game Over", message: pointsDisplay, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {action in self.restart()})
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
    func restart(){
        Task.init {
            await fetchTrivia()
        }
    }
   
}
