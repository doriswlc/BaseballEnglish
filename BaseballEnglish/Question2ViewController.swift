//
//  PointViewController.swift
//  BaseballEnglish
//
//  Created by doriswlc on 2022/9/6.
//

import UIKit

class Question2ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var ansButton: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scorePreLabel: UILabel!
    let qnas = [QnA(question: "「雙殺」的英文?", answer: [" double play", "two kill", "double kill", "doubt play"]), QnA(question: "「安打」的英文?", answer: ["hit", "pit", "hat", "hot"]), QnA(question: "「二壘安打」的英文?", answer: ["double", "two base", "second base", "doubt"]), QnA(question: "「三壘安打」的英文?", answer: ["triple", "three base", "third base", "triangle"]), QnA(question: "「高飛犧牲打」的英文?", answer: ["sacrifice fly", "fly ball", "infield fly", "butterfly"]), QnA(question: "「短打」的英文?", answer: ["bunt", "short", "popup", "fly"]), QnA(question: "「滑壘」的英文?", answer: ["slide", "fly ball", "foul ball", "four ball"]), QnA(question: "「裁判」的英文?", answer: ["umpire", "sir", "teacher", "umbrella"]), QnA(question: "「記分板」的英文?", answer: ["scoreboard", "whiteboard", "blackboard", "cardboard"]), QnA(question: "「滿壘全壘打」的英文?", answer: ["grand slam home run", "four-points home run", "big home run", "super home run"])]
    var scorePre = 0
    var randomQnas: [QnA] = []
    var index = 0
    var point = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        scorePreLabel.text = "\(scorePre)"
        initUI()
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
            //    toNextButton.isHidden = false
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
    
    @IBAction func backButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
}


