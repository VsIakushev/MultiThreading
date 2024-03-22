//
//  TroubleShootingTask3ViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 21.03.2024.
//

import UIKit


// Проблема 3: Race Condition. Исправленный вариант (добавлен Semaphore, один isDifferentDirections пришлось сделать true, иначе условия никогда не выполняются):
class TroubleShootingTask3ViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
            var people1 = People1()
            var people2 = People2()
        
            let semaphore = DispatchSemaphore(value: 1)
            
            let thread1 = Thread {
                people1.walkPast(with: people2, semaphore: semaphore)
            }

            thread1.start()

            let thread2 = Thread {
                people2.walkPast(with: people1, semaphore: semaphore)
            }

            thread2.start()
        }

}

class People1 {
    var isDifferentDirections = false;
    
    func walkPast(with people: People2, semaphore: DispatchSemaphore) {
        semaphore.wait()
        while (!people.isDifferentDirections) {
            print("People1 не может обойти People2")
            sleep(1)
        }
        
        print("People1 смог пройти прямо")
        isDifferentDirections = true
        
        semaphore.signal()
    }
}

class People2 {
    var isDifferentDirections = true;
    
    func walkPast(with people: People1, semaphore: DispatchSemaphore) {
        semaphore.wait()
        while (!people.isDifferentDirections) {
            print("People2 не может обойти People1")
            sleep(1)
        }
        
        print("People2 смог пройти прямо")
        isDifferentDirections = true
        semaphore.signal()
    }
}
