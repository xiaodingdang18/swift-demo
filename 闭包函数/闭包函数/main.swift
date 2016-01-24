//
//  main.swift
//  闭包函数
//
//  Created by zhaohf on 16/1/24.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

print("Hello, World!")

/*闭包函数语法
{
    （parameters） -> return type in

    statements
}
*/

func backwards(s1:String, s2:String) -> Bool
{
    return s1 > s2
}

let names = ["ab","cd","bc"]
var reversed = names.sort(backwards)
print("reversed is \(reversed)")


//闭包实现方法,
//特点：1.没有函数名，2.参数和返回类型都写在{}内。3.函数体由关键词in引入
var nReversed = names.sort(
{
    (s1:String, s2:String) -> Bool in
    return s1 > s2
})

print("nReversed is \(nReversed)")


/*
闭包语法
func someFunctionThatTakeClosure(closure:() -> ())
{
    function body 参数是一个函数
}

someFunctionTakeClosure({
    function body  讲函数实现直接写入参数括号内
})

someFunctionTakeTrailingClosure()
{
    function body 只是将函数实现从括号拿出来，并且作为最后一个参数调用
}
*/
//Trailing闭包写法
var tReversed = names.sort()
{
        (s1:String, s2:String) -> Bool in
        return s1 > s2
}

print("trailing reversed is \(tReversed)")
//Trailing闭包，一个书写在函数括号之外的闭包表达式，函数支持将其作为最后一个参数调用
let digitNames = [0:"zero",1:"one",2:"two",3:"three"]
let numbers = [10,11,12]

let strings = numbers.map(){
    (var number) -> String in
    var output = ""
    while number > 0
    {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

print("map strings is \(strings)")


//截获变量
func makeIncrementor(forincrement amount:Int) -> () -> Int//返回值为函数
{
    var runningTotal = 0
    func incrementor() -> Int
    {
        //里面的函数可以截获外部函数的变量
        runningTotal += amount
        return runningTotal
    }
    
    return incrementor
}

let incrementByTen = makeIncrementor(forincrement: 10)
let alsoIncremtnByTen = incrementByTen
print("incrementbyten is \(alsoIncremtnByTen())")



