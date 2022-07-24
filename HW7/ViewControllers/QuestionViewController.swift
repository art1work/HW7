//
//  TestViewController.swift
//  HW7
//
//  Created by Артём Ермохин on 17.07.2022.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionProgressBarView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    
    private let questions = Question.getQuestions()
    private var answersChosen: [Answer] = []
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.answers = answersChosen
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let answer = currentAnswers[buttonIndex]
        answersChosen.append(answer)
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
}

extension QuestionViewController {
    private func updateUI() {
        
        //Hide stacks
        for stackView in  [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        //Get current question
        let currentQuestion = questions[questionIndex]
        
        //Set current question for question label
        questionLabel.text = currentQuestion.title
        
        //Calculate Progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        //Set ProgressBar
        questionProgressBarView.setProgress(totalProgress, animated: true)
        
        //Set title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.responseType)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
 
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)

    }
}
