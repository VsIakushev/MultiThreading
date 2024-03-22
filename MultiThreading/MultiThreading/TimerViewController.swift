//
//  TimerViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 18.03.2024.
//

import UIKit

// Создать второй поток на базе Thread, создать таймер так, чтобы он заработал.
class TimerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TimerViewController"
        view.backgroundColor = .lightGray
        
        // Создаем и запускаем поток с таймером
        let timer = TimerThread(duration: 10)
        timer.start()
        
        
    }
    
    
}


class TimerThread: Thread {
    private var timerDuration: Int
    private var timer: Timer!
    
    init(duration: Int) {
        self.timerDuration = duration
    }
    
    override func main() {
        // Создаем таймер, который будет выполняться каждую секунду
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        print(Thread.current)
        
        // Добавляем таймер в текущий run loop ниже
        RunLoop.current.add(timer, forMode: .default)
        
        // Запускаем текущий run loop ниже
        RunLoop.current.run()
    }
    
    @objc func updateTimer() {
        // Ваш код здесь будет выполняться каждую секунду
        if timerDuration > 0 {
            print("Осталось \(timerDuration) секунд...")
            timerDuration -= 1
        } else {
            print("Время истекло!")
            
            timer.invalidate()
            // Остановка текущего run loop после завершения таймера
            CFRunLoopStop(CFRunLoopGetCurrent())
        }
    }
}
