//
//  main.swift
//  扩展
//
//  Created by zhaohf on 16/2/1.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.扩展语法:类似Objective-C的Category

/*
extension someType
{
    //new functionality to add to someType goes here
}

extension someType: SomeProtocol, AnotherProtocol
{
    //implementation of protocol requirements goes here
}
*/

extension Double
{
    var km: Double {return self * 1000.0}
    var m: Double {return self}
    var cm: Double{ return self / 100.0}
    var mm: Double {return self / 1_000.0}
    var ft: Double { return self / 3.28}
}

let oneInch = 25.4.mm
print("oneInch is : \(oneInch)")

let threeFeet = 3.ft
print("threefeel: \(threeFeet)")

let aMarathon = 42.km + 195.m
print("aMarathon : \(aMarathon)")

//扩展初始化
struct Size
{
    var width = 0.0, height = 0.0
}

struct  Point
{
    var x = 0.0, y = 0.0
}

struct  Rect
{
    var size = Size()
    var point = Point()
}

let defaulRect = Rect()
let memberwizeRect = Rect(size: Size(width: 5.0, height: 5.0), point: Point(x:2.0, y: 2.0))
extension Rect
{
    init(center: Point, size: Size)
    {
        let originX = center.x - size.width / 2.0
        let originY = center.y - size.height / 2.0
        let point = Point(x: originX, y: originY)
        self.init(size: size, point: point)
        
    }
}
let centerRect  = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//扩展方法
extension Int
{
    func repetitions(task: () -> Void)
    {
        for _ in 0..<self
        {
            task()
        }
    }
}

3.repetitions { () -> Void in
    print("hello")
}

//修改实例本身方法
extension Int
{
    mutating func square()
    {
        self = self * self
    }
}

var someInt = 3
someInt.square()
print("someInt square \(someInt)")

//下标
extension Int
{
    subscript(digitIndex: Int) -> String
    {
        var decimalBase = 1
        for _ in 0..<digitIndex
        {
            decimalBase *= 10
            //print("decimalBase index \(index)")
        }
        print("decimalBase index \(self / decimalBase)")
        return "\((self / decimalBase) % 10)"
        
    }
}

print("index 0 " + 123456[0])
print("index 9: " + 123456[9])

//通过扩展向已有的类、结构、枚举中添加嵌套类型
extension Int
{
    enum Kind
    {
        case Negative, Zero, Positive, Error
    }
    
    var kind: Kind
    {
        switch self
        {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        case let y where y < 0:
            return .Negative
        default:
            return .Error
        }
    }
}

func printIntegerKinds(numbers: [Int])
{
    for number in numbers
    {
        switch number.kind
        {
        case .Positive:
            print("+", terminator:"hh ")
        case .Negative:
            print("-", terminator:" ")
        case .Zero:
            print("0", terminator:" ")
        default:
            print("error")
        }
    }
    print("")
}
printIntegerKinds([-2,23,3,4,50,0,0,-3,-5])