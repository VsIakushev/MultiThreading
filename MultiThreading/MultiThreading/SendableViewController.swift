//
//  SendableViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 21.03.2024.
//

import UIKit

class SendableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}


// Task 4 - 1
// Нужно подписать Post под протокол Sendable
class ViewController2: UIViewController {
    
    final class Post: Sendable {
        
    }
    
    enum State1: Sendable {
        case loading
        case data(String)
    }
    
    enum State2: Sendable {
        case loading
        case data(Post) // Out: Associated value 'data' of 'Sendable'-conforming enum 'State2' has non-sendable type 'ViewController.Post'
    }
    
}
