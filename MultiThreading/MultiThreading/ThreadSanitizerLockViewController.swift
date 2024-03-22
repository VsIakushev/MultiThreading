//
//  ThreadSanitizerLockViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 19.03.2024.
//

import UIKit

class ThreadSanitizerLockViewController: UIViewController {
    
    private var lock = NSLock()
    
    private lazy var name = "I love RM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async {
            self.lock.lock()
            print(self.name) 
            print(Thread.current)
            self.lock.unlock()
        }
        lock.lock()
        print(self.name)
        lock.unlock()
    }
    
}
