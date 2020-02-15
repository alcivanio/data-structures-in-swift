import UIKit


//min heap
class Heap<T: Comparable> {
    
    var capacity: Int = 10
    var count: Int { items.count }
    var isEmpty: Bool { return items.isEmpty }
    
    var items: [T] = []
    
    private func getParentIndex(_ index: Int) -> Int { return (index - 1) / 2 }
    private func getLeftChildIndex(_ index: Int) -> Int { return 2 * index + 1 }
    private func getRightChildIndex(_ index: Int) -> Int { return 2 * index + 2 }
    
    private func hasParent(_ index: Int) -> Bool { return getParentIndex(index) >= 0 }
    private func hasLeftChild(_ index: Int) -> Bool { return getLeftChildIndex(index) < count }
    private func hasRightChild(_ index: Int) -> Bool { return getRightChildIndex(index) < count }
    
    private func parent(_ index: Int) -> T { return items[getParentIndex(index)] }
    private func leftChild(_ index: Int) -> T { return items[getLeftChildIndex(index)] }
    private func rightChild(_ index: Int) -> T { return items[getRightChildIndex(index)] }
    
    
    public func peek() -> T? {
        return items[0]
    }
    
    public func poll() -> T? {
        if count == 0 { return nil }
        let item = items[0]
        items[0] = items.removeLast()
        heapifyDown()
        return item
    }
    
    public func add(_ item: T) {
        items.append(item)
        heapifyUp()
    }
    
    public func printHeap() {
        for i in 0..<count {
            print("\(items[i])", terminator: " ")
        }
        print("")
    }
    
    private func heapifyUp() {
        if isEmpty { return }
        var index = count - 1
        while hasParent(index) && parent(index) > items[index] {
            items.swapAt(index, getParentIndex(index))
            index = getParentIndex(index)
        }
    }
    
    private func heapifyDown() {
        if isEmpty { return }
        var index = 0
        var smallestChildIndex: Int
        
        while hasLeftChild(index) {
            smallestChildIndex = getLeftChildIndex(index)
            if hasRightChild(index) && rightChild(index) < leftChild(index) {
                smallestChildIndex = getRightChildIndex(index)
            }
            
            if items[index] < items[smallestChildIndex] { break }
            
            items.swapAt(index, smallestChildIndex)
            index = smallestChildIndex
        }
    }
    
    
}





let heap = Heap<Int>()
heap.add(10)
heap.printHeap()
heap.add(20)
heap.printHeap()
heap.add(30)
heap.printHeap()
heap.add(9)
heap.printHeap()
heap.add(8)
heap.printHeap()
heap.add(32)
heap.printHeap()
heap.add(2)
heap.printHeap()








