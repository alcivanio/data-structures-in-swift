# Data structures in Swift

I decided to create some data structures using swift. The idea is just to practice and have a better idea how some structures work. 

Here's the list of the structures:

## 1. Hash table.
What I have learned after implementing a hash table.
According to the wikipedia a hashtable is a type of structure that most part of the time is supposed to return a stored value in a constant time. With the help of a hash function, it associates a position for each value in its bucket - the place where the information is actually stored.

##### How i implemented the hash table

First of all, I created a node for that hash table. Each node contains a value, a key associated to that value and also a reference for a next node.
```swift
class HashTableNode<T> {
        var value: T
        var key: String
        var nextNode: HashTableNode?
        init(value: T, key: String) {
            self.value = value
            self.key = key
        }
    }
```

Also, I wanted to have a operation status for the insertion in the hashtable, just to inform the user what happened. This step is usually not necessary, but I still wanted to implement. The insertion could have a success status, which means that the value was sucessfully added to the bucket. The other case is collision, when the value was added to the bucket, but there was a colision, which means we didn't match the optimal case. Finally, I imagined another case would be to experience a replacement of a key.
```swift
enum InsertionStatus {
    case success, collision, replacement
}
```
Now we're ready to implement the HashTable itself. Basically it will have a bucket, which will contains a reference for the first node of the sequence pointed by a hashkey. And it's pretty much it. The only exceptional thing done here would be to fill that array with empty references of nodes, like done in the init.

```swift
class HashTable<T> {
    private var bucket: [HashTableNode<T>?]
    init(bucketSize: Int) {
        bucket = Array(repeating: nil, count: bucketSize)
    }
}
```
The important now are the operations. Let's begin with the most basic operation, the add. Basically what this function will do is to check the index pointed by the hash function. If that index is empty, good, it's the optimal case, we just create a new node and assign to that position. Otherwise, we'll have to go throgh the node's next node till we find a nil spot and assign it to our new node, as we can read in the implementation below. Also it's important to note how the insertion operation status is implemented.

```swift
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

```
Now the fecth operation. So the user will try to find an object by a key. So we'll get this key, check what's the index provided by the hash function to that key, and check in the nodes of that index if there's any matching the key. If yes we return the value, otherwise we just return nil.

```swift
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
```

Delete will work in a very simillar way. We receive a key, we check the index for that key, and then we check in all the nodes of that index if there's any of them matching the given key. Let's see some code.

```swift
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
```

The big deal of this time of structure is the hash function. It has to calculate the key in a constant time to worth all the hard work we have done so far. I made a lazy implementation of it, using just the values of the string. It's not actually constant because it will get each value of the key and make a math using the unicode value of that character. But there's no much secret here, just make a code that's constant and you'll be fine.
```swift
private func findIndex(forKey hashKey: String) -> Int {
	if hashKey.isEmpty { return -1 }
	return hashKey.unicodeScalars.reduce(0, { $0 + Int($1.value) }) % bucket.count
}
````

We have our hash table implementation done now. Hope it have helped someone.
