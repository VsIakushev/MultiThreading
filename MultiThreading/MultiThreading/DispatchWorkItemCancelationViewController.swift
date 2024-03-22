//
//  DispatchWorkItemCancelationViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 21.03.2024.
//

import UIKit

// Создаем 10 workItem на создание элементов, последний отменяем, должно получиться 9 элементов

class DispatchWorkItemCancelationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = ArrayAdditionService()
        
        for i in 1...10 {
            service.addElement(i)
        }
        service.cancelAddition()
        
        
    }
}

class ArrayAdditionService {
    private var array = [Int]()
    private var pendingWorkItems = [DispatchWorkItem]()
    
    func addElement(_ element: Int) {
        let newWorkItem = DispatchWorkItem { [weak self] in
            self?.array.append(element)
            print("Элемент \(element) успешно добавлен в массив")
        }
        
        pendingWorkItems.append(newWorkItem)
        
        // время на отмену операции
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: newWorkItem)
    }
    
    func cancelAddition() {
        guard let lastWorkItem = pendingWorkItems.last else {
            print("нет операций для отмены")
            return
        }
        // отменяем последнюю операцию
        lastWorkItem.cancel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            print(self.array)
        }
    }
    
    
    
}
