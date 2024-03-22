//
//  ActorViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 20.03.2024.
//

import UIKit


class ActorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phrasesService = PhrasesService()
        
       Task {
            for i in 0..<10 {
                await phrasesService.addPhrase("Phrase \(i)")
                sleep(1)
                print(await phrasesService.phrases[i])
            }
        }
    }
}
actor PhrasesService {
    var phrases: [String] = []
    
    func addPhrase(_ phrase: String) async {
        phrases.append(phrase)
    }
}
