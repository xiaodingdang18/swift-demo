//
//  main.swift
//  基本运算
//
//  Created by zhaohf on 16/1/20.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//swift可以对浮点数进行取余数
print("qu ju is \(8%2.5)")

//封闭运算符
for index in 1...6
{
    print("index is \(index)")
}

//半封闭运算符，包含左边第一个值，但是不包含右边的值
let names = ["name0","name1","name2"]
let count = names.count
for name in names
{
    print("person index \(name) ")
}

//初始化空字符串
let emptyStr = ""
let emptyStr2 = String()

//字符串是有character组成,每一个character代表一个Unicode字符
let str = "我叫赵"
for character in str.characters
{
    print("character is \(character)")
}

//组合使用字符和字符串
let firstString:String = "zhao"
let midCharacter:Character = "h"
let  lastString = firstString + String(midCharacter)
print("last name is \(lastString)")

//数组初始化
var shoppingList:[String] = ["eggs","milk"]
shoppingList.append("potato")//数组追加元素
shoppingList += ["pear"]
shoppingList.insert("insert", atIndex: 3)
shoppingList.removeAtIndex(0)
print("shopping list is \(shoppingList)")

for (index,value) in shoppingList.enumerate()
{
    print("index is \(index), value is \(value)")
}

//空数组
var emptyArr = [Int]()

//字典,字典不可以有重复的key，crash
var airport:Dictionary<String, String> = ["key":"value","key3":"value3"]
airport["key2"] = "value2"
let oldValue = airport.updateValue("newValue", forKey: "key")//此方法更新后回返回旧值
print("old value is \(oldValue)")
print("dic is \(airport)")
for(key, value) in airport
{
    print("key: \(key), vlaue :\(value)")
}
//空字典
var emptyDic = [Int:String]()
