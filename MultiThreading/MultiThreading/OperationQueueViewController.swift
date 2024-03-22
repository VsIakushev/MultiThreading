//
//  OperationQueueViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 21.03.2024.
//

import UIKit

class OperationQueueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

class RecipeViewController: UIViewController {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let rmOperationQueue = RMOperationQueue()
        
        let rmOperation1 = RMOperation()
        rmOperation1.priority = .background
        
        rmOperation1.completionBlock = {
            print(1)
        }
        
        let rmOperation2 = RMOperation()
        rmOperation2.priority = .userInteractive
        
        rmOperation2.completionBlock = {
            print(2)
        }
        
    
        rmOperationQueue.addOperation(rmOperation1)
        rmOperationQueue.addOperation(rmOperation2)
      
    }
}

protocol RMOperationQueueProtocol {
    /// Тут храним пул наших операций
    var operations: [RMOperation] { get }
    /// Добавляем наши кастомные операции в пул operations
    func addOperation(_ operation: RMOperation)
    /// Запускаем следующую
    func executeNextOperation()
}

// Класс, управляющий очередью операций
final class RMOperationQueue: RMOperationQueueProtocol {
    var operations: [RMOperation] = []

    func addOperation(_ operation: RMOperation) {
        operations.append(operation)
        executeNextOperation()
    }

    func executeNextOperation() {
        if let nextOperation = operations.first(where: { !$0.isExecuting && !$0.isFinished }) {
            /// Тут делаем старт операции
            ///
            nextOperation.isExecuting = true
            nextOperation.start()
            /// Тут рекурсивно запускаем следующую операцию (что такое рекурсия?)
            executeNextOperation()
        }
    }
}
