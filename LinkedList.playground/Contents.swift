import UIKit

var str = "Hello, playground"

class Node<T> {
    let value: T
    var nextNode: Node<T>?
    
    init(value: T, nextNode: Node<T>? = nil) {
        self.value = value
        self.nextNode = nextNode
    }
}


class LinkedList<T> {
    
    private var root: Node<T>?
    var count: Int = 0
    
    func addElement(_ element: T) {
        let node = Node(value: element)
        var parent = root
        if parent == nil {
            root = node
        } else {
            while parent?.nextNode != nil {
                parent = parent?.nextNode
            }
            parent?.nextNode = node
        }
        count+=1
    }
    
    func removeItem(atIndex index: Int) -> Bool {
        var parent = root
        let repeatTimes = index-1
        if index >= count { return false }
        
        if repeatTimes > 0 {
            for _ in 0..<repeatTimes {
                parent = parent?.nextNode
            }
        }
        
        parent?.nextNode = parent?.nextNode?.nextNode
        count-=1
        return true
    }
    
    func removeFirst() -> Bool {
        if root == nil { return false }
        root = root?.nextNode
        count-=1
        return true
    }
    
    func removeLast() -> Bool {
        return removeItem(atIndex: count-1)
        //count decreased inside the last statement
    }
    
    func printLinkedList() {
        var node = root
        while node != nil {
            print("\(node!.value) > ", terminator: "")
            node = node?.nextNode
        }
        if root != nil {
            print("nil - count: \(count)")
            
        }
        else { print("empty linked list") }
        print("")
    }
    
}


let linkedList = LinkedList<Int>()

linkedList.addElement(1)
linkedList.addElement(2)
linkedList.addElement(3)
linkedList.addElement(4)
linkedList.printLinkedList()
linkedList.removeItem(atIndex: 1)//remove 2?
linkedList.printLinkedList()
linkedList.removeLast()//remove 4?
linkedList.printLinkedList()
linkedList.removeFirst()//remove 1
linkedList.printLinkedList()
linkedList.removeFirst()//remove 3?
linkedList.printLinkedList()
linkedList.removeFirst()//remove what??
linkedList.printLinkedList()

