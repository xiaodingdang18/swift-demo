//
//  main.swift
//  泛型
//
//  Created by zhaohf on 16/2/2.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.泛型解决的问题
//非泛型函数:此函数只能交换Int类型的值，如果要交换String就必须修改参数类型
func swapTwoInts(inout a: Int, inout _ b: Int)
{
    let temporaryA = a
    a = b
    b = temporaryA
}


//泛型函数: T占位类型（可以使Int,String,Array...）,<T>告诉编译器T只是一个占位类型，不用去查找它所代表的类型，只有在调用的时候才知道是什么类型
func swapTwoValues<T>(inout a:T, inout b:T)
{
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
swapTwoValues(&someInt, b: &anotherInt)
print("someInt is  now \(someInt), another is now \(anotherInt)")

//2.泛型类型
//泛型实现栈
struct Stack<Element>
{
    var items = [Element]()
    mutating func push(item: Element)
    {
        items.append(item)
    }
    mutating func pop() -> Element
    {
        return items.removeLast()
    }
    
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()
print("pop: " + fromTheTop)

//3.扩展一个泛型类型
extension Stack
{
    var topItem: Element?
    {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem
{
    print("the top item is \(topItem)")
}


//4.给泛型的类型加约束
//类型约束语法：
/*
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U)
{
    //泛型函数的函数体
}
*/
//非泛型实现
func findStringIndex(array: [String],  valueToFind: String) -> Int?
{
    for (index, value) in array.enumerate()
    {
        if value == valueToFind
        {
            return index
        }
        
    }
    
    return nil
}

let strings = ["a","b","c","d","e","f"]
if let foundIndex = findStringIndex(strings, valueToFind: "c")
{
    print("found index: \(foundIndex)")
}

//泛型实现
//不是所有的swift类型可以用==进行比较，标准库定义了Equatable协议，任何遵从Equatable协议的都必须实现==方法
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int?
{
    for (index, value) in array.enumerate()
    {
        if value == valueToFind
        {
            return index
        }
    }
    
    return nil
}

let doubleIndex = findIndex([3.13,0.1,0.25], 9.3)
print("double index: \(doubleIndex)")

let stringIndex = findIndex(["hh","zhf","hhkk"], "zhf")
print("string index: \(stringIndex)")

//5.关联类型
protocol Container
{
    typealias ItemType
    mutating  func append(item: ItemType)
    var count : Int { get }
    subscript(i: Int) -> ItemType {get}
}

extension Stack: Container
{
    mutating func append(item: Element) {
        items.append(item)
    }
    var count: Int
    {
        return items.count
    }
    
    subscript(i: Int) -> Element
    {
        return items[i]
    }
}

//通过扩展一个存在的类型来指定关联类型
func allItemMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>(someContainer: C1,_ anotherContrainer: C2) -> Bool
{
    if someContainer.count != anotherContrainer.count
    {
        return false
    }
    for i in 0..<someContainer.count
    {
        if someContainer[i] != anotherContrainer[i]
        {
            return false
        }
    }
    
    return true
}

extension Array:Container{}//////////

var stackOfStrings2 = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("jjj")
var arrayOfStrings = ["un0","dos"]
if allItemMatch(stackOfStrings2, arrayOfStrings)
{
    print("all items match")
}
else
{
    print("not all items match")
}

