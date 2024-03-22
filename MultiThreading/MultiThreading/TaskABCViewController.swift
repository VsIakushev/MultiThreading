//
//  TaskABCViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 19.03.2024.
//

import UIKit

class TaskABCViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()

            print("A")
            
            DispatchQueue.main.async {
                print("B")
            }
        
            print("C")
    }
}

// Сначала А, потом С - т.к. выполнение В передается в главный поток для асинхронного выполнения, т.е. не блокирует выполнение последующего кода. Принт С выполняется сразу, одновременно с тем как Принт В пока еще добавляется в очередь на выполнение, хоть и с минимальной задержкой. Вывод будет А С В
