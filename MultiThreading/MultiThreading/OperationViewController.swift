//
//  OperationViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 21.03.2024.
//

import UIKit

protocol RMOperationProtocol {
    // Приоритеты
    var priority: DispatchQoS.QoSClass { get }
    // Выполняемый блок
    var completionBlock: (() -> Void)? { get }
    // Завершена ли операция
    var isFinished: Bool { get }
    // Выполняется ли операция
    var isExecuting: Bool { get }
    // Метод для запуска операции
    func start()
}


class OperationViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
           
            let operationFirst = RMOperation()
            let operationSecond = RMOperation()
            
           
            operationFirst.priority = .userInitiated
            operationFirst.completionBlock = {
                
                for _ in 0..<50 {
                    print(2)
                }
                print(Thread.current)
                print("Операция полностью завершена!")
            }
           
            operationFirst.start()
            

            
            operationSecond.priority = .background
            operationSecond.completionBlock = {
              
                for _ in 0..<50 {
                    print(1)
                }
                print(Thread.current)
                print("Операция полностью завершена!")
            }
            operationSecond.start()

        }
    

}

class RMOperation: RMOperationProtocol {
    var isExecuting: Bool = false
    
    var priority: DispatchQoS.QoSClass = .default
    
    var completionBlock: (() -> Void)?
    
    var isFinished: Bool = false
    
    func start() {
        DispatchQueue.global(qos: priority).async {
            self.completionBlock?()
            self.isFinished = true
            self.isExecuting = false
        }
        
    }
 
}
