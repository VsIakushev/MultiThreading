//
//  ThreadSanitizerViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 19.03.2024.
//

import UIKit

class ThreadSanitizerViewController: UIViewController {
    
    private var name = "Enter name"
    private let lockQueue = DispatchQueue(label: "name.lock.queue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
        
    }
    
    func updateName() {
        lockQueue.async {
            self.name = "I love RM"
            print(Thread.current)
            print(self.name)
        }
        
        lockQueue.sync {
            print(self.name)
        }
    }
}

