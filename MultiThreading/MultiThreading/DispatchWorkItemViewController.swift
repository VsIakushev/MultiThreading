//
//  DispatchWorkItemViewController.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 20.03.2024.
//

import UIKit

// Повторение видео-урока

class DispatchWorkItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
}

class ViewController1: UIViewController {
    
    let imageURL = "https://static.tildacdn.com/tild3632-3034-4937-a532-613236616335/ViFinance_logo.png"
    
    let dipatchWorkItem = DispatchWorkItem2()
    
    var someView = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 150))
    var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 150))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.backgroundColor = .lightGray
        image.contentMode = .scaleAspectFit
        
        view.addSubview(someView)
        someView.addSubview(image)
        fetchImage3()
        

    }
    
    // classic
    func fetchImage() {
        let queue1 = DispatchQueue.global(qos: .utility)
        
        queue1.async {
            if let data = try? Data(contentsOf: URL(string: self.imageURL)!) {
                
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    // DistatchWorkItem
    func fetchImage2() {
        var data: Data? = nil
        
        let queue1 = DispatchQueue.global(qos: .utility)
        
        let workItem = DispatchWorkItem(qos: .userInteractive) {
            data = try? Data(contentsOf: URL(string: self.imageURL)!)
            print(Thread.current)
        }
        
        queue1.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                self.image.image = UIImage(data: imageData)
            }
        }
    }
    
    // Async URL session
    func fetchImage3() {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: self.imageURL)!)) { (data, response, error) in
            print(Thread.current)
            if let imageData = data {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}
    
class DispatchWorkItem1 {
    // concurrent queue
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("task finish")
        }
        
        queue.async(execute: workItem)
        
    }
}

class DispatchWorkItem2 {
    // serial queue
    private let queue = DispatchQueue(label: "DispatchWorkItem1")
    
    func create() {
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 1")
        }
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Work Item Task")
        }
        
        queue.async(execute: workItem)
        
        workItem.cancel()
        
    }
}



// GCD and semaphores
//class ViewController: UIViewController {
//
//    var eightImagesView = EightImage(frame: CGRect(x: 0, y: 0, width: 700, height: 900))
//    var images = [UIImage]()
//
//    let imageURLs = ["http://www.planetware.com/photos-larg...", "http://adriatic-lines.com/wp-content/...", "http://bestkora.com/IosDeveloper/wp-c...", "http://www.picture-newsletter.com/arc..." ]
//
//    let dispatchGr = DispatchGroupTest2()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        eightImagesView.backgroundColor = .red
//
//        dispatchGr.loadInfo()
//
//    }
//
//    func asyncLoadImage(imageURL: URL,
//                        runQueue: DispatchQueue,
//                        completionQueue: DispatchQueue,
//                        completion: @escaping (UIImage?, Error?)->()) {
//        runQueue.async {
//            do {
//                let data = try Data(contentsOf: imageURL)
//                completionQueue.async { completion(UIImage(data: data), nil) }
//            } catch let error {
//                completionQueue.async {
//                    completion(nil, error)
//                }
//            }
//        }
//    }
//
//    func asyncGroup() {
//        let agroup =  DispatchGroup()
//        for i in 0...3 {
//            agroup.enter()
//            asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
//                           runQueue: .global(),
//                           completionQueue: .main) { result, error in
//                guard let image1 = result  else{ return }
//                self.images.append(image1)
//                agroup.leave()
//            }
//        }
//        agroup.notify(queue: .main) {
//            for i in 0...3 {
//                self.eightImagesView.ivs[i].image = self.images[i]
//            }
//        }
//    }
//}
//
//class DispatchGroupTest1 {
//    private let queueSerial = DispatchQueue(label: "RM")
//
//    private let groupRed = DispatchGroup()
//
//    // т.к. serial queue блоки выполняются последовательно
//    func loadInfo() {
//        queueSerial.async(group: groupRed) {
//            sleep(1)
//            print("1")
//        }
//
//        queueSerial.async(group: groupRed) {
//            sleep(1)
//            print("2")
//        }
//
//        // Отработка кода после завершения группы
//        groupRed.notify(queue: .main) {
//            print("Group finish all")
//        }
//
//    }
//}
//
//class DispatchGroupTest2 {
//    private let queueConc = DispatchQueue(label: "RM 2", attributes: .concurrent)
//
//    private let groupBlack = DispatchGroup()
//
//    // т.к. concurrent queue блоки выполняются парралельон (одновременно)
//    func loadInfo() {
//
//        groupBlack.enter() // + 1 блок кода в группу
//        queueConc.async {
//            sleep(1)
//            print("1")
//            self.groupBlack.leave() // - 1 блок кода в группу //  надо сообщить группе что код выполнился
//        }
//
//        groupBlack.enter() // + 1 блок кода в группу
//        queueConc.async {
//            sleep(1)
//            print("2")
//            self.groupBlack.leave() // - 1 блок кода в группу //  надо сообщить группе что код выполнился
//        }
//
//        groupBlack.wait() // ждем пока выполнятся блоки кода выше
//        print("Group finish all")
//
//        groupBlack.notify(queue: .main) {
//            print("Group finish all")
//        }
//    }
//}
//
//class EightImage: UIView {
//
//    public var ivs = [UIImageView]()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
//        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
//        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
//        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
//
//        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
//        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
//        ivs.append(UIImageView(frame: CGRect(x: 00, y: 400, width: 100, height: 100)))
//        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
//
//        for i in 0...7 {
//            ivs[i].contentMode = .scaleToFill
//            self.addSubview(ivs[i])
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}



//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        DispatchQueue.global().sync { print("00")
//        }
//        print("111")
//
//    }
//
//
//}
//
//
//class QueueTest1 {
//    private let serialQueue = DispatchQueue(label: "serialTest")
//    private let concurrentQueue = DispatchQueue(label: "concurrrentTest", attributes: .concurrent)
//}
//
//
//class QueueTest2 {
//    private let globalQueue = DispatchQueue.global(qos: .userInteractive)
//    private let mainQueue = DispatchQueue.main
//}
