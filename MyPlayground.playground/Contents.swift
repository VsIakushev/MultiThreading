import UIKit
let serialQueue = DispatchQueue(label: "com.example.serialQueue")

// Задача пытается заблокировать свою собственную очередь синхронно
serialQueue.sync {
    print("Task 1 locked serialQueue")
    
    // Эта задача не может продолжить выполнение, потому что она блокирует саму себя синхронно
    serialQueue.sync {
        print("Task 1 locked serialQueue again")
    }
    
    serialQueue.sync {
        print("Task 2 locked serialQueue again")
    }
    
    print("Task 3 unlocked serialQueue")
}
