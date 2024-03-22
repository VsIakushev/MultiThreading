//
//  SemaphoreViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 20.03.2024.
//

import UIKit

class SemaphoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let semaphore = DispatchSemaphore(value: 1)
        
        let phrasesServise = PhraseService()
        
        for i in 0..<10 {
            
            DispatchQueue.global(qos: .utility).async {
                semaphore.wait()
                phrasesServise.addPhrase("Phrase \(i)")
                Thread.sleep(forTimeInterval: 1)
                print(phrasesServise.phrases[i])
                semaphore.signal()
            }
        }
    }
}

class PhraseService {
    var phrases: [String] = []
    
    func addPhrase(_ phrase: String) {
        phrases.append(phrase)
    }
}




/// До добавления Семафора
//class SemaphoreViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       //        DispatchQueue.global().async {
//            for i in 0..<10 {
//                phrasesServise.addPhrase("Phrase \(i)")
//                Thread.sleep(forTimeInterval: 1)
//                print(phrasesServise.phrases[i])
//            }
//
//
//            DispatchQueue.main.async {
//                print(phrasesServise.phrases)
//            }
//        }
//    }
//}
//
//class PhraseService {
//    var phrases: [String] = []

//    func addPhrase(_ phrase: String) {
//        phrases.append(phrase)
//    }
//}
