//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Nikita on 01.02.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var responses: [Answer]
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var resultAnserLable: UILabel!
    
    @IBOutlet weak var resaltDefinitionLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult() {
        let frequencyOfAnswerw = responses.reduce(into: [:]) {
            (counts, answer) in counts[answer.type, default: 0] += 1
        }
        let frequentAnswersSorted = frequencyOfAnswerw.sorted(by: {(pair1, pair2) in return pair1.value > pair2.value})
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnserLable.text = "You are a \(mostCommonAnswer.rawValue)!"
        resaltDefinitionLable.text = mostCommonAnswer.defenition
    }
}
