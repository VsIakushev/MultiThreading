//
//  TroubleShootingViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 21.03.2024.
//

import UIKit

class TroubleShootingTask1and2ViewController: UIViewController {
    
    // Виды ошибок:
    // Race Condition, Data Race
    // Deadlock, livelock
    // priotiry inverse, starvation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Проблема 1: Дедлок. Исправленный вариант:
        let serialQueue = DispatchQueue(label: "com.example.myQueue")
        
        serialQueue.async {
            serialQueue.async {
                print("This will never be printed.")
            }
        }
        
        // Проблема 2: Race Condition. Исправленный вариант (добавлен Lock):
        
        var sharedResource = 0
        let lock = NSLock()
        
        DispatchQueue.global(qos: .background).async {
            for _ in 1...100 {
                lock.lock()
                sharedResource += 1
                lock.unlock()
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            for _ in 1...100 {
                lock.lock()
                sharedResource += 1
                lock.unlock()
            }
        }
    }
}

