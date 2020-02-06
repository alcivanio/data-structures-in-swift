import UIKit


class Node<T: Comparable> {
    var value: T
    
    weak var parent: Node<T>?
    
    var leftNode: Node<T>?
    var rightNode: Node<T>?
    
    var balance: Int = 0
    
    init(value: T) {
        self.value = value
    }
}

enum AddOperationStatus {
    case failed, addedLeft, addedRight, addedAsRoot
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
    
    private func addValue(_ value: T) {
        let result = addValueFromRoot(value)
        switch result.status {
        case .addedLeft:
            break
        case .addedRight:
            break
        case .failed, .addedAsRoot:
            break
        }
    }
    
    private func addValueFromRoot(_ value: T) -> (node: Node<T>?, status: AddOperationStatus) {
        var hasCompleted = false
        var node = root
        var operationStatus = AddOperationStatus.failed
        
        if node == nil {
            root = Node(value: value)
            operationStatus = .addedAsRoot
        }
        
        while !hasCompleted && node != nil {
            if node?.value == value {
                operationStatus = .failed
                hasCompleted = true
            } else if value < node!.value {
                if node?.leftNode == nil {
                    node?.leftNode = Node(value: value)
                    node?.leftNode?.parent = node
                    node = node?.leftNode//final
                    operationStatus = .addedLeft
                    hasCompleted = true
                    
                } else {
                    node = node?.leftNode
                }
            } else if value > node!.value {
                node = node?.rightNode
                if node?.leftNode == nil {
                    node?.rightNode = Node(value: value)
                    node?.rightNode?.parent = node
                    node = node?.rightNode//final
                    operationStatus = .addedRight
                    hasCompleted = true
                } else {
                    node = node?.rightNode
                }
            }
        }
        
        return (node: node ?? root, status: operationStatus)
    }
    
    func updateBalanceFromNode(_ node: Node<T>, operationStatus: AddOperationStatus) {
        
        
        switch operationStatus {
        case .addedLeft:
            node.parent?.balance+=1
        case .addedRight:
            node.parent?.balance-=1
        default:
            break
        }
        
        if abs(node.parent!.balance) == 1 {
            //tell other people that they may need to be updated
        } else if abs(node.parent!.balance) == 2 {
            //a rotation may need to be performed
        }
        
        
        
        /*repeat {
            

        } while node.parent?.balance != nil &&*/
        
        
    }
    
    func rotateLeft(node: Node<T>) {
        let newTop = node.rightNode
        newTop?.parent = node.parent
        node.parent?.rightNode = newTop
        newTop?.leftNode = node
        node.parent = newTop
    }
    
    func rotateRight(node: Node<T>) {
        let newTop = node.leftNode
        newTop?.parent = node.parent
        node.parent?.leftNode = newTop
        newTop?.rightNode = node
        node.parent = newTop
    }
    
    
    
    
}
