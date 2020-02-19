import UIKit

extension Array where Iterator.Element: Comparable {
    
    mutating func heapSort() {
        
        if count < 2 { return }//an array with less than 2 is already sorted
        
        
        //MAKE IT A HEAP-MAX
        var auxIndex: Int
        for i in 1..<count {
            auxIndex = i
            
            while auxIndex > 0 && self[getParentIndex(auxIndex)] < self[auxIndex] {
                swapAt(auxIndex, getParentIndex(auxIndex))
                auxIndex = getParentIndex(auxIndex)
            }
        }
        
        
        //NOW WITH HEAP SORT
        
        
        for i in (1..<count).reversed() {
            swapAt(0, i)
            
            
            var index = 0
            var biggestChildIndex: Int
            
        
            while hasLeftChild(index, i) {
                biggestChildIndex = getLeftChildIndex(index)
                if hasRightChild(index, i) && rightChild(index) > leftChild(index) {
                    biggestChildIndex = getRightChildIndex(index)
                }
                
                if self[index] > self[biggestChildIndex] { break }
                
                swapAt(index, biggestChildIndex)
                index = biggestChildIndex
            }
            
        }
        
    
    
        
        
        
        
        
        
    }
    
    private func getParentIndex(_ index:Int) -> Int { return (index-1)/2 }
    private func getLeftChildIndex(_ index: Int) -> Int { return 2 * index + 1 }
    private func getRightChildIndex(_ index: Int) -> Int { return 2 * index + 2 }
    
    private func hasLeftChild(_ index: Int, _ maxIndex: Int) -> Bool { return getLeftChildIndex(index) < maxIndex }
    private func hasRightChild(_ index: Int, _ maxIndex: Int) -> Bool { return getRightChildIndex(index) < maxIndex }
    
    private func leftChild(_ index: Int) -> Element { return self[getLeftChildIndex(index)] }
    private func rightChild(_ index: Int) -> Element { return self[getRightChildIndex(index)] }
    
    
}


var aa = [4,1,9,3,12]
aa.heapSort()s
