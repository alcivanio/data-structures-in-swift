import UIKit
import Foundation




class HashTableNode<T> {
    var value: T
    var key: String
    var nextNode: HashTableNode?
    
    init(value: T, key: String) {
        self.value = value
        self.key = key
    }
}





enum InsertionStatus {
    case success, collision, replacement
}




class HashTable<T> {
    
    private var bucket: [HashTableNode<T>?]
    
    init(bucketSize: Int) {
        bucket = Array(repeating: nil, count: bucketSize)
    }
    
    //best case O(1), worst case O(n)
    @discardableResult func addElement(_ element: T, forKey hashKey: String) -> InsertionStatus  {
        let node = HashTableNode(value: element, key: hashKey)
        let index = findIndex(forKey: hashKey)
        var auxNode = bucket[index]
        if auxNode == nil {
            bucket[index] = node
            return .success
        }
        while auxNode?.nextNode != nil {
            if auxNode?.key == hashKey || auxNode?.nextNode?.key == hashKey {
                auxNode = [auxNode, auxNode?.nextNode].first(where: {$0?.key == hashKey})!
                auxNode?.value = element
                return .replacement
            }
            auxNode = auxNode?.nextNode
        }
        auxNode?.nextNode = node
        return .collision
    }
    
    //best case O(1), worst case O(n)
    func getElement(forKey hashKey: String) -> T? {
        let index = findIndex(forKey: hashKey)
        var node = bucket[index]
        while node != nil {
            if node?.key == hashKey { return node?.value }
            else {
                node = node?.nextNode
            }
        }
        return nil
    }
    
    //best case O(1), worst case O(n)
    func deleteElementForKey(_ key: String) -> Bool {
        let index = findIndex(forKey: key)
        var node = bucket[index]
        if node?.key == key {
            bucket[index] = node?.nextNode
            return true
        }
        
        while node?.nextNode != nil {
            if node?.nextNode?.key == key {
                node?.nextNode = node?.nextNode?.nextNode
                return true
            }
            node = node?.nextNode
        }
        
        return false
    }
    
    private func findIndex(forKey hashKey: String) -> Int {
        if hashKey.isEmpty { return -1 }
        return hashKey.unicodeScalars.reduce(0, { $0 + Int($1.value) }) % bucket.count
    }
    
    public func printHashTable() {
        var node: HashTableNode<T>?
        for i in 0..<bucket.count {
            print("values at section index \(i)")
            node = bucket[i]
            while node != nil {
                print("value: \(node!.value)")
                node = node?.nextNode
            }
        }
    }
}



let hashTable = HashTable<String>(bucketSize: 5)

hashTable.addElement("Hello", forKey: "Greeting")
hashTable.addElement("Five", forKey: "FeetFingers")
hashTable.addElement("Five", forKey: "HandFingers")
hashTable.addElement("A Star is Born", forKey: "Movie")
hashTable.addElement("Ça va?", forKey: "FrenchLesson")
hashTable.addElement("Hi", forKey: "Greeting")


hashTable.printHashTable()


hashTable.deleteElementForKey("Greeting")
print("======")

hashTable.printHashTable()


