import UIKit


class Node<T: Comparable> {
    var value: T
    var leftNode: Node<T>?
    var rightNode: Node<T>?
    var balance: Int = 0
    
    init(value: T) {
        self.value = value
    }
}

enum AddOperationStatus {
    case failed, addedLeft, addedRight
}

class AVLTree<T: Comparable> {
    
    var root: Node<T>?
    
    func containsValue(_ value: T) -> Node<T>? {
        return searchValue(value, inNode: root)
    }
    
    private func searchValue(_ value: T, inNode node: Node<T>?) -> Node<T>? {
        if node == nil {
            return nil
        } else if node!.value == value {
            return node
        } else if value > node!.value {
            return searchValue(value, inNode: node?.rightNode)
        } else /*if value < node!.value*/ {
            return searchValue(value, inNode: node?.leftNode)
        }
    }
    
    func addValue(value: T) -> AddOperationStatus {
        var hasCompleted = false
        var node = root
        var operationStatus = .failed
        while !hasCompleted {
            if node.value == value {
                operationStatus = .failed
                hasCompleted = true
            } else if value < node.value {
                node = node?.leftNode
            } else if value > node.value {
                node = node?.rightNode
            }
        }
        
        return operationStatus
        
    }
    
    
    
}
