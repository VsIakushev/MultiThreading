//
//  AsyncAwaitViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 22.03.2024.
//

import UIKit

// Task 5 - 4
class AsyncAwaitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Task.init {
            let result =  await randomD6()
            print(result)
        }
        
    }
    
    func randomD6() async -> Int {
        Int.random(in: 1...6)
    }
    
}
