//
//  StopAfter5ViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 18.03.2024.
//

import UIKit

// Отменяем задачу когда цикл while досчитает до 5.
class StopAfter5ViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            title = "Stop Loop after 5"
            view.backgroundColor = .white
     
            // Создаем и запускаем поток
            let infinityThread = InfinityLoop()
            infinityThread.start()
            print("Thread executing:", infinityThread.isExecuting)

            // Подождем некоторое время, а затем отменяем выполнение потока
            sleep(5)
            infinityThread.cancel()
            print("Thread canceled:", infinityThread.isCancelled)
            print("Thread finished:", infinityThread.isFinished)
            // Отменяем тут
    }
}

class InfinityLoop: Thread {
    var counter = 0
    
    override func main() {
        while counter < 30 && !isCancelled {
            counter += 1
            print(counter)
            InfinityLoop.sleep(forTimeInterval: 1)
        }
    }
}
