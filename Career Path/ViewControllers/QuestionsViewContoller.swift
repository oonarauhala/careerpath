//
//  QuestionsViewContoller.swift
//  Career Path
//
//  Created by iosdev on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    
    //MARK:variables
    var personalityTest = PersonalityTest()
    var questionIndex = 0
    var responses: [Answer]!
    var buttonText1Pressed = false
    var buttonText2Pressed = false
    //MARK: buttons
    @IBOutlet weak var buttonText1: UIButton!
    @IBOutlet weak var buttonText2: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    //MARK:labels
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    //MARK: views (progress view)
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //UI will update when question will change
    func updateUI(){
        
        let currentQuestion = personalityTest.questions[questionIndex]
        let totalProgress = Float(questionIndex)/Float(personalityTest.questions.count)
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        questionNumber.text = "Question " + String(questionIndex+1) + "/" + String(personalityTest.questions.count)
        buttonText1.setTitle(currentQuestion.answers[0].text, for: .normal)
        buttonText2.setTitle(currentQuestion.answers[1].text, for: .normal)

    }
    
    var answersChosen: [Answer] = []
    
    //MARK: when user press the answer  or the next button
       @IBAction func answerPressed(_ sender: UIButton) {
        
        let currentAnswers = personalityTest.questions[questionIndex].answers
        switch sender {
            
        case buttonText1:
                buttonText1Pressed = true
                buttonText2Pressed = false
                buttonText1.backgroundColor = UIColor.lightGray
                buttonText2.backgroundColor = UIColor.white
        case buttonText2:
                buttonText1Pressed = false
                buttonText2Pressed = true
                //answersChosen.append(currentAnswers[1])
                buttonText2.backgroundColor = UIColor.lightGray
                buttonText1.backgroundColor = UIColor.white
        case buttonNext:
               if (buttonText1Pressed == true){
               answersChosen.append(currentAnswers[0])
                nextQuestion()
            } else if (buttonText2Pressed == true){
                answersChosen.append(currentAnswers[1])
                nextQuestion()
            } else if (buttonText2Pressed == false && buttonText1Pressed == false){
                // alert message if user don't choose any of answers
                let alert = UIAlertController(title: "Warning message", message: "You need to choose an answer", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")}))
                self.present(alert, animated: true, completion: nil)
               }
        default:
            break
        }
        
    }
    
    //when the "NEXT >" button is pressed
    func nextQuestion(){
        
        questionIndex+=1
        buttonText2Pressed = false
        buttonText1Pressed = false
        
        if questionIndex < personalityTest.questions.count {
            updateUI()
        }
        else {
        performSegue(withIdentifier:"ResultSegue", sender: nil)
        }
        buttonText1.backgroundColor = UIColor.white
        buttonText2.backgroundColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ResultSegue"{
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.responses = answersChosen
        }
    }
    
}
