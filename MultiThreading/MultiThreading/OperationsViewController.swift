//
//  OperationsViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 21.03.2024.
//

import UIKit


class OperationsViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Использование
        let threadSafeArray = ThreadSafeArray()
        let operationQueue = OperationQueue()

        let firstOperation = FirstOperation(threadSafeArray: threadSafeArray)
        let secondOperation = SecondOperation(threadSafeArray: threadSafeArray)
        
        // первый способ через dependency, чтобы вторая операция ожидала завершение первой
//        secondOperation.addDependency(firstOperation)
        
        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)

        // Дождитесь завершения операций перед выводом содержимого массива
        operationQueue.waitUntilAllOperationsAreFinished()

        print(threadSafeArray.getAll())
    }
}

// Объявляем класс для для синхронизации потоков
class ThreadSafeArray {
    private var array: [String] = []
    private let lock = NSLock()

    
    // Второй способ через lock на изменение массива, чтобы только один поток мог менять
    func append(_ item: String) {
        lock.lock()
        array.append(item)
        lock.unlock()
    }

    func getAll() -> [String] {
        return array
    }
}

// Определяем первую операцию для добавления строки в массив
class FirstOperation: Operation {
    let threadSafeArray: ThreadSafeArray

    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }

    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Первая операция")
    }
}

// Определяем вторую операцию для добавления строки в массив
class SecondOperation: Operation {
    let threadSafeArray: ThreadSafeArray
    
    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }
    
    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Вторая операция")
    }
}
