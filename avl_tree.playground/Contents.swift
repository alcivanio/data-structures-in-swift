import UIKit


class Node<T: Comparable>: Comparable {
    
    var value: T
    
    weak var parent: Node<T>?
    var leftNode: Node<T>?
    var rightNode: Node<T>?
    
    var height: Int = 0
    
    var balance: Int {
        return (leftNode?.height ?? -1) - (rightNode?.height ?? -1)
    }
    
    var isBalanced: Bool { return abs(balance) < 2 }
    var isNotBalanced: Bool { return !isBalanced }
    
    init(value: T) {
        self.value = value
    }
    
    public func setLeftNode(_ leftNode: Node<T>?) {
        self.leftNode = leftNode
        leftNode?.parent = self
    }
    
    public func setRightNode(_ rightNode: Node<T>?) {
        self.rightNode = rightNode
        rightNode?.parent = self
    }
    
    public func replaceNode(_ node: Node<T>, withNode newNode: Node<T>?) {
        if leftNode == node {
            setLeftNode(newNode)
        } else if rightNode == node {
            setRightNode(node)
        }
    }
    
    static func < (lhs: Node, rhs: Node) -> Bool { lhs.value < rhs.value }
    static func <= (lhs: Node, rhs: Node) -> Bool { lhs.value <= rhs.value }
    static func >= (lhs: Node, rhs: Node) -> Bool { lhs.value >= rhs.value }
    static func > (lhs: Node, rhs: Node) -> Bool { lhs.value > rhs.value }
    static func == (lhs: Node, rhs: Node) -> Bool { lhs.value == rhs.value }
}

enum AddOperationStatus {
    case failed, addedLeft, addedRight, addedAsRoot
}

class AVLTree<T: Comparable> {
    
    var root: Node<T>?
    private var temporaryRoot: Node<T>?
    
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
    
    func addValue(_ value: T) {
        addValue(value, inSubtree: &root)
        updateRoot()
    }
    
    @discardableResult private func addValue(_ value: T, inSubtree subtreeRoot: inout Node<T>?) -> Bool {
        if subtreeRoot == nil {
            subtreeRoot = Node(value: value)
            return true
        }
        
        
        if value < subtreeRoot!.value {
            if addValue(value, inSubtree: &subtreeRoot!.leftNode) && !subtreeRoot!.isBalanced {
                subtreeRoot?.leftNode?.parent = subtreeRoot
            }
        } else if value > subtreeRoot!.value {
            if addValue(value, inSubtree: &subtreeRoot!.rightNode) && !subtreeRoot!.isBalanced {
                subtreeRoot?.rightNode?.parent = subtreeRoot
            }
        } else {
            return false
        }
        
        balanceNodeIfNeeded(subtreeRoot!)
        
        subtreeRoot?.height = max(getNodeHeight(subtreeRoot?.leftNode), getNodeHeight(subtreeRoot?.rightNode)) + 1
        return true
    }
    
    private func balanceNodeIfNeeded(_ node: Node<T>) {
        if node.isBalanced { return }
        if node.balance > 1 {
            if (node.leftNode?.balance ?? 0) < 0 {
                rotateLeftRight(node: node)
            } else {
                rotateLeft(node: node)
            }
        } else {
            if (node.rightNode?.balance ?? 0) > 0 {
                rotateRightLeft(node: node)
                
            }else {
                rotateRight(node: node)
            }
        }
    }
    
    private func updateRoot() {
        if temporaryRoot != nil {
            root = temporaryRoot
        }
    }
    
    private func rotateLeft(node: Node<T>) {
        let upperNode = node.leftNode
        node.parent == nil ? upperNode?.parent = nil : node.parent?.replaceNode(node, withNode: upperNode)
        
        node.setLeftNode(upperNode?.rightNode)
        upperNode?.setRightNode(node)
        
        node.height = max(getNodeHeight(node.leftNode), getNodeHeight(node.rightNode))
        upperNode?.height = max(getNodeHeight(node.leftNode), node.height) + 1
        
        if upperNode?.parent == nil {
            temporaryRoot = upperNode
        }
    }
    
    private func rotateRight(node: Node<T>) {
        let upperNode = node.rightNode
        node.parent == nil ? upperNode?.parent = nil : node.parent?.replaceNode(node, withNode: upperNode)
        
        node.setRightNode(upperNode?.leftNode)
        upperNode?.setLeftNode(node)
        
        node.height = max(getNodeHeight(node.leftNode), getNodeHeight(node.rightNode))
        upperNode?.height = max(getNodeHeight(node.rightNode), node.height) + 1
        
        if upperNode?.parent == nil {
            temporaryRoot = upperNode
        }
    }
    
    private func rotateLeftRight(node: Node<T>) {
        if let leftNode = node.leftNode {
            rotateRight(node: leftNode)
        }
        rotateLeft(node: node)
    }
    
    private func rotateRightLeft(node: Node<T>) {
        if let rightNode = node.rightNode {
            rotateLeft(node: rightNode)
        }
        rotateRight(node: node)
    }
    
    private func getNodeHeight(_ node: Node<T>?) -> Int {
        return node?.height ?? -1
    }
    
    func printTree() {
        guard let root = root else { return }
        printNode(root)
        print("")
    }
    
    private func printNode(_ node: Node<T>) {
        print(node.value, terminator: " ")
        if let leftNode = node.leftNode {
            printNode(leftNode)
        }
        
        if let rightNode = node.rightNode {
            printNode(rightNode)
        }
    }
}





let tree = AVLTree<Int>()

tree.addValue(10)
print("\(tree.root?.value)")
print("\(tree.root?.leftNode?.value)")
print("\(tree.root?.rightNode?.value)")

print("====")

tree.addValue(12)

print("\(tree.root?.value)")
print("\(tree.root?.leftNode?.value)")
print("\(tree.root?.rightNode?.value)")

tree.addValue(9)

print("====")

print("\(tree.root?.value)")
print("\(tree.root?.leftNode?.value)")
print("\(tree.root?.rightNode?.value)")


