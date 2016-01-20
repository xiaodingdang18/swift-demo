//
//  main.swift
//  stringLearn
//
//  Created by zhaohf on 16/1/20.
//  Copyright © 2016年 RW. All rights reserved.
//基础数据类型

import Foundation

print("Hello, World!")

let stringA = "stringA"

var stringB = "stringB"

let stringC = stringA + stringB
print(stringC)

stringB = stringA + stringB
print(stringB)

let canNotNagtive:UInt8 = 1
let two :UInt16 = 2000
//用UInt16创建一个新变量，初始值为canNotNagtive，则可以实现不同类型变量相加
let three = UInt16(canNotNagtive) + two

//类型别名
typealias Custom16 = Int16
print("custom 16 max is \(Custom16.max)")

//bool 类型 true false
let i = 1
if i == 1//这里如果写if i会编译错误，因为非bool类型
{
    print("i == 1")
}

//元组可以将一些不同的数据类型组装成元素
let http404Error = (404,"Not Found")
let (statusCode,statusMessage) = http404Error
print("status code is \(statusCode)")
print("status message is \(http404Error.1)")
let http200Status = (statusC :200,statusMes :"200 ok")
print("http 200 status code is \(http200Status.statusC) mess is \(http200Status.1)")

//可选类型
let possibleNumber:String = "我们" //"123"
let covertedNumber:Int? = Int(possibleNumber)

//强制解包，后面添加！，代表已经检测该值存在，如果对nil强制解包会crash
if (covertedNumber != nil)
{
    print("covert number is \(covertedNumber!)")
}
else
{
    print("covert number not exist \(covertedNumber)")
}

//隐式解包，在定义的时候+！，而不是使用的时候加！
let assumeString:String! = "An implicitly unwrapped optional string"

//断言
let age = 9
assert(age > 0,"a person 's age can not less than 0")



