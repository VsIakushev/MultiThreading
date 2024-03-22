//
//  PrioritiesViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 18.03.2024.
//

import UIKit

class PrioritiesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Priorities"
        view.backgroundColor = .white
        
        // Создаем и запускаем поток
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
        
        // Меняем приоритеты
        thread1.qualityOfService = .background
        thread2.qualityOfService = .userInitiated
        
        thread1.start()
        thread2.start()
        
    }
}

class ThreadprintDemon: Thread {
    override func main() {
        for _ in (0..<100) {
            print("1")
        }
    }
}
class ThreadprintAngel: Thread {
    override func main() {
        for _ in (0..<100) {
            print("2")
        }
    }
}
