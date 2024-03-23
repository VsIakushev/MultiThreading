//
//  TaskViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 22.03.2024.
//

import UIKit

// Task 5 - 1,2,3
class TaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Task 1
        print(1)
//        DispatchQueue.main.async {
//            print(2)
//        }
        
        Task {
            print(2)
        }
        print(3)
        
        /// Task 2
        // @MainActor указывает, что данный Task должен выполняться на основном акторе (main actor) в вашем приложении. Основной актор - это специальный тип актора в Swift, который предназначен для обработки пользовательского интерфейса и всех связанных с ним операций
        print(1)
        Task { @MainActor  in
            print(2)
        }
        print(3)
        
        /// Task 3
        print("Task 1 is finished")
        
//        DispatchQueue.global().async {
//            for i in 0..<50 {
//                print(i)
//            }
//            print("Task 2 is finished")
//            print(Thread.current)
//        }
        
        Task.detached {
            for i in 0..<50 {
                print(i)
            }
            print("Task 2 is finished")
        }
        
        print("Task 3 is finished")
        
    }
}

// Prints 1, 3, 2
