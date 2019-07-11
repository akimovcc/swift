import UIKit

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)

//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.



struct queue<Element> {
    
    var items = [Element]()
    
    mutating func push(_ item: Element){
        items.append(item)
        print("Добавлен элемент \(item)")
    }
    mutating func pop(){
        if !isEmpty() {
            print("Element \(items.first!) deleted")
            items.removeFirst()
        }else{
            print("Queue is empty!")
        }
    }
    
    mutating func first() -> Element?{
        if !isEmpty(){
            print("First element is \(items.first!)")
            return items.first
        }else{
            print("Queue is empty!")
            return nil
        }
    }
    
    mutating func last() -> Element?{
        if !isEmpty(){
             print("Last element is \(items.first!)")
            return items.last
        }else{
            print("Queue is empty!")
            return nil
        }

    }
    
    func isEmpty() -> Bool{
        if (items.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    mutating func showQueue(){
        if !isEmpty() {
            print("start show queue")
            for (index, value) in items.enumerated(){
                print("\(index + 1) - \(value)")
            }
            print("finish show queue")
            
        }else{
           print("Queue is empty")
        }
    }
    
    func count(){
        print("Count of queue is \(items.count) elements")
    }

    
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
    func myfilter(){
       items.filter { (someElement: Element? ) -> Bool in return someElement != nil }
    }
    
    
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
    subscript(index: Int) -> Int? {
        get { if isEmpty(){
            return nil
                }else{
            return index
            }
        }
    }
}

var myqueue = queue<String>()
myqueue.isEmpty()
myqueue.push("Петя")
myqueue.push("Вася")
myqueue.push("Миша")
myqueue.count()
myqueue.showQueue()
myqueue.showQueue()
myqueue.last()
myqueue.first()
myqueue.count()
myqueue.showQueue()
myqueue.showQueue()
myqueue.pop()
myqueue.pop()
myqueue.pop()
myqueue.count()
myqueue[15]
myqueue.myfilter()


