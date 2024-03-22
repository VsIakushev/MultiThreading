//
//  FreeupMainThread.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 18.03.2024.
//

import Foundation

/// FreeupMainThread
class FreeupMainThread: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FreeupMainThread"
        view.backgroundColor = .lightGray
        
        // Разгружаю MainTread - убираю первый цикл в другой Поток. Теперь он выполняется параллельно со вторым циклом
        Thread.detachNewThread {
            for _ in (0..<10) {
                let currentThread = Thread.current
                print("1, Current thread: \(currentThread)")
            }
        }
        
        for _ in (0..<10) {
            let currentThread = Thread.current
            print("2, Current thread: \(currentThread)")
        }
    }
}
