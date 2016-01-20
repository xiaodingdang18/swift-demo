//
//  main.swift
//  函数
//
//  Created by zhaohf on 16/1/20.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

func sayHello(person: String) ->String
{
    let greeting = "Hello " + person
    return greeting
}

print(sayHello("zhaohf"))

//多返回值函数
func count(string: String) -> (vowels:Int, consonants: Int, others: Int)
{
    return (0, 1, 2)
}

//外部函数名,只要参数多于1个就会有外部函数名
func join(string s1:String, toString s2:String, joinString s3:String = "default") -> String
{
    return s1+s2+s3
}
//外部参数快速标记，这个特性已经去掉
print(join(string: "hello ", toString: "zhao ", joinString: "hf"))
//参数的默认值，看joinString 后面设置了默认值，不不传参数时候，就会使用默认值
print(join(string: "hello ", toString: "zhao "))


//可变参数,函数最多可以出现一个可变参数，并且放在参数列表的最后面
func arithmeticMean(numbers: Double...) -> Double
{
    var total: Double = 0
    for number in numbers
    {
        total += number
    }
    return total
}

print("total is \(arithmeticMean(1,2,3,4,5))")


//函数类型
func addTwoInts(a: Int, b: Int) -> Int
{
    return a + b
}//类型为：(Int, Int)->Int
func printHello()
{
    print("hello")
}//类型为：()->()

//使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts
print("math: \(mathFunction(1, 2))")


//函数类型作为参数
func printMathResult(mathFunction: (Int, Int) -> Int ,a:Int,b: Int)
{
    print("result is : \(mathFunction(a, b))")
}

printMathResult(mathFunction, a: 5, b: 6)

//函数类型作为返回值
func stepFoward(input:Int) -> Int
{
    return input - 1
}
func stepBack(input: Int) -> Int
{
    return input + 1
}

func chooseStepFunction(back:Bool) -> (Int)->Int
{
    return back ? stepBack : stepFoward
}

let currentValue = 3

let function = chooseStepFunction(currentValue < 0)
print("chooseStepFunction result is \(function(currentValue))")


//嵌套函数
func nChooseStepFunction(back:Bool) -> (Int)->Int
{
    
    func stepFoward(input:Int) -> Int
    {
        return input - 1
    }
    func stepBack(input: Int) -> Int
    {
        return input + 1
    }
    
    return back ? stepBack : stepFoward
}
