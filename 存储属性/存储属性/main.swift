//
//  main.swift
//  存储属性
//
//  Created by zhaohf on 16/1/26.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.存储属性
//FixedLenghtRange的实例包含了一个名为firstValue的变量存储属性和名为length的常量存储属性
struct FixedLenghtRange
{
    var firstValue:Int
    let lenght:Int
}
var rangeThreeItems = FixedLenghtRange(firstValue: 0, lenght: 3)
rangeThreeItems.firstValue = 6

//2.常量结构存储属性 ：当创建一个结构体实例，并把它赋值给一个常量，则实例中的属性不可以更改，即使被声明为常量属性，这是由于结构体是数值类型，但这个特性对类不适用，因为类是引用类型
let rangeOfFourItems = FixedLenghtRange(firstValue: 0, lenght: 4)
//rangeOfFourItems.firstValue = 6  //不可更改

//3.懒惰存储属性 :当他第一次使用时，才进行初值计算

class DataImporter
{
    var fileName = "data.txt"
}

class DataManager
{
    lazy var importer = DataImporter() //DataManager可能不需要立即导入数据到文件，所以DataManager被创建时，并不需要马上创建DataImporter实例。这就是只有在需要DataImporter时才创建DataImporter实例
    var data = [String]()
}

let manager  = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
print("manager importer filename is \(manager.importer.fileName)")


//4.计算属性
struct Point
{
    var x = 0.0, y = 0.0
}

struct Size
{
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center:Point
        {
        get
        {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
//        set(newCenter)
//        {
//            origin.x = newCenter.x - (size.width / 2)
//            origin.y = newCenter.y - (size.height / 2)
//        }
        //set 声明简略写法，没有输入参数，默认使用newValue
        set
        {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initalSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square origin is now at \(square.origin.x) \(square.origin.y)")

var str: String
{
    get
    {
        return "abcd"
    }
}

print("a \(str)")

//5.只读计算属性 ：通过移除get和大括号，简化只读属性定义
struct Cuboid
{
    var width = 0.0, height = 0.0, depth = 0.0
    var vloume:Double
        {
        return width * height * depth
    }
    
}
let fourByFiveTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("volume is \(fourByFiveTwo.vloume)")

//6.属性观察者 :当totalSteps被赋予新值时，willSet和didSet将会调用，即使新旧值相同
class StepCounter
{
    var totalSteps: Int = 0
    {
        willSet(newTotalSteps)
        {
            print("about to set totalSteps to \(newTotalSteps)")
        }
        didSet
        {
            if (totalSteps > oldValue)
            {
                print("added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

//7.类型属性语句：定义静态变量，全局静态变量 对于值类型使用static关键字，对于类使用class关键字
//读取类型属性： 通过类名.操作获取
struct someStructure
{
    static var storedTypeProperty = "some Value"
    var returnValue:String = storedTypeProperty
}
//storedTypeProperty不能被外部引用
let structure = someStructure()
print("strucure is \(someStructure.storedTypeProperty) \(structure)")

enum SomeEnumeration
{
    static var storedTypeProperty = "some Value"
   
}
print("enum is  \(SomeEnumeration.storedTypeProperty)")

class SomeClass {
    static var storedTypeProperty = "some Value"
    static var overrideableProperty: Int{
        return 107
    }
}

var customClass = SomeClass()
print("some class static .\(SomeClass.storedTypeProperty)  .\(SomeClass.overrideableProperty)")



//类型属性举例
struct AudioChannel
{
    static let theShouldLevel = 10
    static var maxInputLevelFforAllChannels = 0
    var currentLevel: Int = 0
        {
            didSet
            {
                if (currentLevel > AudioChannel.theShouldLevel)
                {
                    currentLevel = AudioChannel.theShouldLevel
                }
                if (currentLevel > AudioChannel.maxInputLevelFforAllChannels)
                {
                    AudioChannel.maxInputLevelFforAllChannels = currentLevel
                }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print("current level: \(leftChannel.currentLevel), maxChannel: \(AudioChannel.maxInputLevelFforAllChannels)")

rightChannel.currentLevel = 11
print("current level: \(rightChannel.currentLevel), maxChannel: \(AudioChannel.maxInputLevelFforAllChannels)")

struct aaa {
    var str:String!
}
