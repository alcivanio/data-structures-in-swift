import UIKit
import Foundation

//We'll implement a hash table. Let's give it a try?

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
    
    private func findIndex(forKey hashKey: String) -> Int {
        if hashKey.isEmpty { return -1 }
        return hashKey.unicodeScalars.reduce(0, { $0 + Int($1.value) }) % bucket.count
    }
}



let hashTable = HashTable<String>(bucketSize: 10)

hashTable.addElement("Olá", forKey: "Comprimento")
hashTable.addElement("Opa!", forKey: "Comprimento")


