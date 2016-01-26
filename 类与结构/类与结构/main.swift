//
//  main.swift
//  类与结构
//
//  Created by zhaohf on 16/1/26.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1. 类和结构体定义
class someClass
{
    //class definition here
}

struct SomeStructure
{
    //structure definition here
}

//表示像素的分辨率
struct Resolution
{
    var width = 0
    var height = 0
}

//视频显示方式
class VideoMode
{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
}


//2. 类和结构体实例化
let someResolution = Resolution()
let someVideoMode = VideoMode()

//3.访问属性，用.语法
print("someResolution width is \(someResolution.width)")
print("someVideoMode resolution width is \(someVideoMode.resolution.width)")


//4.结构类型成员初始化方法，注：每个结构成员都有一个成员初始化方法,但是类实例不能使用成员初始化
let age = Resolution(width: 640, height: 480)

//5.结构和枚举类型是数值类型，数值类型：当它被赋值给一个常量或变量，或作为参数传递，是完整复制一个新的数值而不是仅仅改变了引用对象
let hd = Resolution(width: 1920, height: 1080)
var cinerma = hd //此时常量hd和变量cinerma是两个实例，虽然高宽值一样
cinerma.width = 2048
print("hd width is \(hd.width) ; cinerma width is \(cinerma.width)")

enum CommpassPoint
{
    case North, South, East, West
}

var currentDirection = CommpassPoint.East
let rememberDirection = currentDirection
currentDirection = .West
print("currentDirection is \(currentDirection), remeberDirection is \(rememberDirection)")


//6.类是引用类型 注：和数值类型不同引用类型不会复制整个实例，当被赋值给常量或变量，会建立一个和已有的实例相关的引用来表示它
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty //虽然alsoTenEighty被声明一个常量，但是可以修改他的属性，这是因为她本身是没有改变的，我们没有保存VideoMode实例，只是引用实例，修改的是它们所引用实例的属性
alsoTenEighty.frameRate = 15.0
print("the frameRate property of tenEighty is now \(tenEighty.frameRate)")


//7.特征操作  === ！==注：三个等号代表引用同一个实例，两个等号代码数值相同
if(tenEighty === alsoTenEighty)
{
    print("tenEighty and alsoEighty refer to the same resolution instance")
}


//8.字典的赋值和复制操作， 注：被复制而不是引用
var ages = ["peter" : 23, "wel" : 25, "kate" : 28]
var copiedAges = ages
copiedAges["kate"] = 78
print("ages kate value is \(ages["kate"]), copiedAges kate value is \(copiedAges["kate"])")

//9.数组的赋值和复制操作 注：跟字典一样
var a = [1,2,3]
var b = a
var c = a

print("1: a[0]:\(a[0]), b[0]:\(b[0]), c[0]:\(c[0])))")
a[0] = 5
print("2: a[0]:\(a[0]), b[0]:\(b[0]), c[0]:\(c[0])))")
a.append(4)
print("3: a[0]:\(a[0]), b[0]:\(b[0]), c[0]:\(c[0])))")

//@@@ string dictionary,array 实现类型与structure，都会拷贝

