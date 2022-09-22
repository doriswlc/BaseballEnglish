//
//  ViewController.swift
//  BaseballEnglish
//
//  Created by doriswlc on 2022/9/6.
//

import UIKit

class Question1ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var toNextButton: UIButton!
    @IBOutlet var ansButton: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    let qnas = [QnA(question: "「投手」的英文?", answer: ["pitcher", "pig", "Peter", "picture"]), QnA(question: "「捕手」的英文?", answer: ["catcher", "cat", "Kate", "castle"]), QnA(question: "「游擊手」的英文?", answer: ["short stop", "show stop", "short start", "showhand"]), QnA(question: "「右外野手」的英文?", answer: ["right fielder", "left fielder", "center fielder", "infielder"]), QnA(question: "「二好三壞」的英文?", answer: ["full count", "two three", "fool count", "fair count"]), QnA(question: "「界外球」的英文?", answer: ["foul ball", "fly ball", "fair ball", "four ball"]), QnA(question: "「界內球」的英文?", answer: ["fair ball", "fly ball", "foul ball", "four ball"]), QnA(question: "「高飛球」的英文?", answer: ["fly ball", "fair ball", "foul ball", "ground ball"]), QnA(question: "「滾地球」的英文?", answer: ["ground ball", "game ball", "foul ball", "guard ball"]), QnA(question: "「平飛球」的英文?", answer: ["line drive", "line fly", "line up", "fly ball"])]
    var randomQnas: [QnA] = []
    var index = 0
    var point = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        toNextButton.isHidden = true
    }

    @IBAction func startButtonTap(_ sender: UIButton) {
        point = 0
        startButton.isEnabled.toggle()
        randomQnas = qnas.shuffled()
        showQuestion()
        for ansBtn in ansButton {
            ansBtn.isEnabled = true
        }
    }
    @IBAction func AnsChosen(_ sender: UIButton) {
        if sender.currentTitle! == randomQnas[index].answer[0] {
            point += 10
            scoreLabel.text = "⭕️"
        } else {
            scoreLabel.text = "❌"
        }
        if index < 9 {
            index += 1
            showQuestion()
        } else {
            for ansBtn in ansButton {
                ansBtn.isEnabled = false
            }
            var resultTitle = ""
            if point == 100 {
                resultTitle = "🎉🎉🎉Pass🎊🎊🎊"
                toNextButton.isHidden = false
            } else {
                resultTitle = "Try Again"
            }
            let controller = UIAlertController(title: "The End", message: "Your Score is \(point)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: resultTitle, style: .default) { _ in
                self.initUI()
            }
            controller.addAction(okAction)
            present(controller, animated: true)
        }
    }
    
    func initUI() {
        questionLabel.text = "Question"
        for ansBtn in ansButton {
            ansBtn.setTitle("", for: .normal)
            ansBtn.isEnabled = false
        }
        scoreLabel.text = "⚾️"
        index = 0
        startButton.isEnabled = true
    }
    
    func showQuestion() {
        questionLabel.text = randomQnas[index].question
        let randomAns = randomQnas[index].answer.shuffled()
        for (i, answer) in randomAns.enumerated() {
            ansButton[i].setTitle(answer, for: .normal)
        }
    }
    @IBAction func toNext(_ sender: UIButton) {
        if let nextVC = storyboard?.instantiateViewController(withIdentifier: "\(Question2ViewController.self)") as? Question2ViewController {
            nextVC.scorePre = point
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .flipHorizontal
            self.present(nextVC, animated: true)
        }
    }
    

}

