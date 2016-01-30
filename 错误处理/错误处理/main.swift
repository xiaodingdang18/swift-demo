//
//  main.swift
//  错误处理
//
//  Created by zhaohf on 16/1/30.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

enum VendingMatchingError: ErrorType
{
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

//throw VendingMatchingError.InsufficientFunds(coinsNeeded: 5)

//1.为了表示canThrowErrors这个函数可以抛出错误，在此函数声明参数列表之后加上throws关键字。一个标有throws关键词的函数被称作throwing函数.
//2.抛出错误使用throw关键词
//3.在调用一个能抛出错误的函数前面，要加try关键词



//func canThrowErrors() throws -> String
//func cannotThrowErrors() -> String

//4.Do-Catch处理错误
/*
do{
try expression
statements
}
catch pattern1{
statements
}
catch pattern2{
statements
}
*/

struct  Item {
    var price: Int
    var count: Int
    
}

class VendingMachine {
    var inventory =
    [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Pretzels"  : Item(price: 7, count: 11)
        
    ]
    
    var coinsDeposed = 0
    func dispenseSnack(snack: String)
    {
        print("Dispending \(snack)")
    }
    
    func vend(itemNamed name: String) throws
    {
        //使用guard提前退出方法，如果有条件不满足，能提前退出方法并throw出错误
        guard let item = inventory[name] else
        {
            throw VendingMatchingError.InvalidSelection
        }
        
        guard item.count > 0 else
        {
            throw VendingMatchingError.OutOfStock
        }
        
        guard item.price <= coinsDeposed else
        {
            throw VendingMatchingError.InsufficientFunds(coinsNeeded: item.price - coinsDeposed)
        }
        
        coinsDeposed -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        dispenseSnack(name)
    }
}


let favoritSnack =
[
    "Alice" : "Chips",
    "Bob" : "licorice",
    "eve" : "Pretzels"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws
{
    let snackName = favoritSnack[person] ?? "Candy Bar"
    print(snackName + "=======")
    try vendingMachine.vend(itemNamed: snackName)
    
}

let vendingMachine = VendingMachine()
vendingMachine.coinsDeposed = 8

do{
    
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine) //函数在try表达式中调用，因为它能抛出错误。如果错误被抛出，相应的执行会马上转移到catch,如果没抛出错误就继续执行do语句的余下子语句
    
    print("do try over ")
}
catch VendingMatchingError.InvalidSelection
{
    print("invalid selection")
}
catch VendingMatchingError.OutOfStock
{
    print("out of stock")
}
catch VendingMatchingError.InsufficientFunds(let coinNeeded)
{
    print("need coin \(coinNeeded)")
}

//5.将错误转换成可选值
//可以使用 try?将错误转换成一个可选值来处理。如果错误抛出，那么表达式的值就为nil
enum ValueError:ErrorType
{
    case UpToFive
    case EquelToFive
}
func someThrowingFuntion(value: Int) throws -> Int
{
    guard (value < 6) else
    {
        print("> 5 ===")
        throw ValueError.UpToFive
    }
    guard value < 5 else
    {
        print("= 5 ===")
        throw ValueError.EquelToFive
    }
    return value
}

let x = try? someThrowingFuntion(5)
let y = try? someThrowingFuntion(8)
let z = try? someThrowingFuntion(2)

print("x: \(x), y: \(y), z: \(z)")

let xy: Int?
do
{
    try someThrowingFuntion(8)
}
catch
{
    xy = nil
}
//禁止错误传递:当你知道某个throwing函数不会抛出错误的时候，可以+ try!禁用错误传递

let noThrow = try! someThrowingFuntion(2)
print("no throw \(noThrow)")


//指定清理操作：可以使用defer语句在即将离开当前代码块时执行一系列语句（无论以何种方式离开throw、break return）


/*
func processFile(fileName: String) throws
{
if (exists(fileName))
{
let file = open(fileName)
defer{
close(file)
}
}

while let line = try file.readline(){
//处理文件
}
//defer的close操作会在作用域的最后执行
}

*/

