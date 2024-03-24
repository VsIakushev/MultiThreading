//
//  AsyncAwaitLegacyViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 22.03.2024.
//

import UIKit

// Task 5 - 5
class AsyncAwaitLegacyViewController: UIViewController {
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        Task.init {
            let messages = await fetchMessagesResult()
            print(messages)
        }
       
    }
    
    func fetchMessagesResult(completion: @escaping ([Message]) -> Void) {
        networkService.fetchMessages { message in
            completion(message)
        }
    }
    
    @available(*, renamed: "fetchMessagesResult()")
    func fetchMessagesResult() async -> [Message] {
        return await withCheckedContinuation { continuation in
            fetchMessagesResult() { messages in
                continuation.resume(returning: messages)
            }
        }
    }
}

// Task 5 - 6
class AsyncAwaitLegacyThrowsViewController: UIViewController {
    
    var networkService = NetworkService()
    let error = NSError(domain: "MyDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No messages found"])
    
    override func viewDidLoad() {
            super.viewDidLoad()

        Task.init {
            let messages =  try await fetchMessagesResult()
            print(messages)
        }
       
    }
    
    func fetchMessagesResult(completion: @escaping ([Message]) -> Void) {
        networkService.fetchMessages { message in
            completion(message)
        }
    }
    
    @available(*, renamed: "fetchMessagesResult()")
    func fetchMessagesResult() async throws -> [Message] {
        return try await withCheckedThrowingContinuation { continuation in
            fetchMessagesResult() { messages in
                if messages.isEmpty {
                    continuation.resume(throwing: self.error)
                } else {
                    continuation.resume(returning: messages)
                }
            }
        }
    }
}



struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}


class NetworkService {
    
    func fetchMessages(completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }

            completion([])
        }
        .resume()
    }
}
