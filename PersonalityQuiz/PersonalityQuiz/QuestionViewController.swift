//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Nikita on 01.02.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLable: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLable1: UILabel!
    @IBOutlet weak var multiLable2: UILabel!
    @IBOutlet weak var multiLable3: UILabel!
    @IBOutlet weak var multiLable4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLable1: UILabel!
    @IBOutlet weak var rangedLable2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions: [Question] = [
        Question(
            text: "Which food do you like \n the most?",
            type: .single,
            answers: [
                Answer(text: "Steak", type: .dog),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .rabbit),
                Answer(text: "Corn", type: .turtle)
            ]
        ),
        Question(
            text: "Wich activities \n do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .dog)
            ]
        ),
        Question(
            text: "How much do you enjoy \n car riders?",
            type: .ranged,
            answers: [
                Answer(text: "I dislike \n them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love \n them", type: .dog)
            ]
        )
    ]
    
    var questionIndex = 0
    var answersChosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswer[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswer[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswer[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswer[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswer = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswer.count - 1)))
        
        answersChosen.append(currentAnswer[index])
        
        nextQuestion()
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultiStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLable1.text = answers[0].text
        multiLable2.text = answers[1].text
        multiLable3.text = answers[2].text
        multiLable4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLable1.text = answers.first?.text
        rangedLable2.text = answers.last?.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLable.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultiStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
}
