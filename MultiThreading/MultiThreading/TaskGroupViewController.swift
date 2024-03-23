//
//  TaskGroupViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 22.03.2024.
//

import UIKit

class TaskGroupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await printMessage()
        }
    }
    
    func printMessage() async {
        let string = await withTaskGroup(of: String.self) { group -> String in
            // тут добавляем строки в группу
            group.addTask {
                "Hello"
            }
            
            group.addTask {
                "My"
            }
            
            group.addTask {
                "Road"
            }
            
            group.addTask {
                "Map"
            }
            
            group.addTask {
                "Group"
            }
            
            var collected = [String]()
            
            for await value in group {
                collected.append(value)
            }
            
            return collected.joined(separator: " ")
        }
        
        print(string)
    }
}
