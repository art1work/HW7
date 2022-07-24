//
//  ResultViewController.swift
//  HW7
//
//  Created by Артём Ермохин on 17.07.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var beerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }

    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
}

extension ResultViewController {
    private func updateResult() {
        var freqOfBeer: [Beer: Int] = [:]
        let beers = answers.map { $0.beer }
        
        for beer in beers {
            if let beerTypeCount = freqOfBeer[beer] {
                freqOfBeer.updateValue(beerTypeCount + 1, forKey: beer)
            } else {
                freqOfBeer[beer] = 1
            }
        }
        
        let sortedFreqBeer = freqOfBeer.sorted {$0.value > $1.value}
        guard let mostFreqBeer = sortedFreqBeer.first?.key else { return }
        updateUI(with: mostFreqBeer)
    }
    
    func updateUI(with beer: Beer?) {
        beerLabel.text = "Вы - \(beer?.rawValue ?? "")🍻"
        descriptionLabel.text = beer?.definition ?? ""
    }
}


