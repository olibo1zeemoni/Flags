//
//  ViewController.swift
//  Flags
//
//  Created by Olibo moni on 01/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    let scoreLabel = UILabel()
    let totalQuestionsLabel = UILabel()
    let restartButton = UIButton()
    
    
    
    var countries: [Country] = [Country(name: "uk"),
                                Country(name: "us"),
                                Country(name: "estonia"),
                                Country(name: "poland"),
                                Country(name: "nigeria"),
                                Country(name: "italy"),
                                Country(name: "ireland"),
                                Country(name: "monaco"),
                                Country(name: "germany"),
                                Country(name: "france"),
                                Country(name: "spain"),
                                Country(name: "russia")
    ]
    
    var score = 0
    var correctAnswer = 0
    var totalQuestions = 1
    
    let rightButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons: [UIButton] = [button1, button2, button3]
        //let gestureR = UITapGestureRecognizer(target: self, action: #selector(onTap(gesture:button:)))
        //view.addGestureRecognizer(gestureR)
        
        buttons.forEach { button in
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray2.cgColor
        }
        
        askQuestion()
        scoreLabel.frame = CGRect(x: 20, y: 49, width: 200, height: 40)
        scoreLabel.text = "Score \(score)"
        scoreLabel.textColor = .red
        view.addSubview(scoreLabel)
        
//        totalQuestionsLabel.frame = CGRect(x: view.frame.width - 100, y: 49, width: 200, height: 40)
//        totalQuestionsLabel.autoresizingMask = .flexibleLeftMargin
//        totalQuestionsLabel.text = "Question: \(totalQuestions)"
//        totalQuestionsLabel.font = UIFont.preferredFont(forTextStyle: .headline)
//        view.addSubview(totalQuestionsLabel)
        
        rightButton.title = "Question: \(totalQuestions)"
        //rightButton.action = #selector(restart(sender:))
        navigationItem.setRightBarButton(rightButton, animated: true)
        
        
        
        restartButton.frame = CGRect(x: view.frame.width / 2 - 40 , y: view.frame.height / 1.4, width: 80, height: 40)
        restartButton.setTitle("Restart", for: .normal)
        
        restartButton.setTitleColor(.blue, for: .normal)
        view.addSubview(restartButton)
        restartButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
        
        
    }
 

    
//    func randomNumber( _ number: Int)-> Int{
//        return Int.random(in: 0..<number)
//    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(countries[0].flag, for: .normal)
        button2.setImage(countries[1].flag, for: .normal)
        button3.setImage(countries[2].flag, for: .normal)
        
        title = countries[correctAnswer].name.uppercased()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct  👍"
            message = "Your score is \(score)"
            totalQuestions += 1
        } else {
            score -= 1
            title = "Incorrect"
            message = "Ouch. That is the flag of \(countries[sender.tag].name)"
            totalQuestions += 1
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { [self] Continue in
            askQuestion()
            scoreLabel.text = "Score \(score)"
            rightButton.title = "Question: \(totalQuestions)"
            
        }
      
        alertController.addAction(continueAction)
        //present(alertController, animated: true, completion: nil)
        
        let endOfGameAlert = UIAlertController(title: "Game over", message: "Total Score: \(score)\n Do you wish to play again", preferredStyle: .alert)
        let affirmAction = UIAlertAction(title: "yes", style: .default) { [self] alertAction in
            askQuestion()
            totalQuestions = 1
            score = 0
            scoreLabel.text = "Score \(score)"
            rightButton.title = "Question: \(totalQuestions)"
        }
        let negativeAction = UIAlertAction(title: "No", style: .destructive) { [self] _ in
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
        }
        endOfGameAlert.addAction(affirmAction)
        endOfGameAlert.addAction(negativeAction)
        if totalQuestions < 11 {
            present(alertController, animated: true, completion: nil)
            
        } else {
            present(endOfGameAlert, animated: true, completion: nil )
        }
        
        
        
    }
    
    
    @objc func restart(){
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        askQuestion()
        totalQuestions = 1
        score = 0
        scoreLabel.text = "Score \(score)"
        rightButton.title = "Question: \(totalQuestions)"
        
    }
    
    
}

