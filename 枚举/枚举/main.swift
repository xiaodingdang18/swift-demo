//
//  main.swift
//  枚举
//
//  Created by zhaohf on 16/1/24.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//枚举创建时不分配默认值
enum CompassPoint
{
    case North
    case South
    case Ease
    case West
}

print(CompassPoint.North,CompassPoint.South)

enum Planet
{
    case Mercury,Venus,Earth,Mars,Jupiter
    case Other
}

print(Planet.Mercury, Planet.Venus,Planet.Other.hashValue)

//当directionToHead被声明为CompassPoint类型后，就可以用.West赋值
var directionToHead = CompassPoint.South
print(directionToHead)

directionToHead = .West
print(directionToHead)

//枚举与switch语句
directionToHead = .South
switch directionToHead
{
case .North:
    print("north ==")
case .South:
    print("south ==")
case .West:
    print("west ==")
default:
    print("unknow ==")
    
}

//关联值,存储不同类型的值
enum Barcode
{
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

func printProduceCode(produceBarcode:Barcode)
{
    switch produceBarcode
    {
    case Barcode.UPCA(let numberSystem, let identifier, let check):
        print("produce UPCA \(numberSystem) \(identifier) \(check)")
        
    case Barcode.QRCode(let produceCode):
        print("produce QRCode \(produceCode)")
    }
}


var produceBarcode = Barcode.UPCA(8, 85909_51226, 3)
printProduceCode(produceBarcode)

produceBarcode = Barcode.QRCode("ABCDEFGHIJKL")
printProduceCode(produceBarcode)


//原始值
enum ASCIIControlCharacter: Character
{
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
//字符串不会递增
enum str:String
{
    case strA = "a", strB
}
print("enum str value \(str.strA.rawValue) \(str.strB.rawValue)")

//Int 会递增，apple的值为5
enum iPlanet:Int
{
    case Mercury = 1,Venus,Earth,Mars,Jupiter
    case apple, pair
}
print(iPlanet.Mercury,iPlanet.Venus)
print("apple ==== \(iPlanet.apple.rawValue),\(iPlanet.pair.rawValue)")

//rawValue 访问成员的初始值
let earthOrder = iPlanet.Venus.rawValue
print("planet Venus value is \(earthOrder)")

//iPlanet(rawValue: rowValue) 访问枚举成员初始值为rowValue的成员
var rowValue = 4
let possiblePlanet = iPlanet(rawValue: rowValue)
print("planet possible value \(rowValue) is \(possiblePlanet)")
