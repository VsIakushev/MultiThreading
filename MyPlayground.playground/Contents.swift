import UIKit

//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(2)
//        DispatchQueue.main.async {
//            print(3)
//            DispatchQueue.main.sync {
//                print(5)
//            }
//            print(4)
//        }
//        print(6)
//    }
//}
//
//let vc = ViewController()
//print(1)
//let view = vc.view
//print(7)

// В плейграунде создается инстанс класса ViewController и вызывается viewDidLoad в момент когда загружается view ВьюКонтроллера, когда мы ее присваиваем.
// Поэтому сначала выводится 1, потом 2 из viewDidLoad, потом 6, пока отрабатывает блок передачи кода в DispatchQueue.main.async, потом 7 (уже синхронный вызов вне класса), потом отрабатывает асинхронный вызов 3. 5 не отрабатывает, т.к. дедлок.
// Вывод: 1, 2, 6, 7, 3



func firstMethod() {
    print("A")
    // 1 блок
    DispatchQueue.main.async {
        print("B")
        
        DispatchQueue.main.async {
            print("C")
        }
        
        DispatchQueue.main.async {
            print("D")
        }
        
        DispatchQueue.global().sync {
            print("E")
        }
    }
    
    print("F")
    
    DispatchQueue.main.async {
        print("G")
    }
}

firstMethod()

RunLoop.
