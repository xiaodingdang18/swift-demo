//
//  main.swift
//  方法
//
//  Created by zhaohf on 16/1/27.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.实例方法: counter定义三个实例方法，调用实例方法用.语法的属性
class Counter
{
    var count = 0
    func increment()
    {
        count++
    }
    
    func incrementBy(amount: Int)
    {
        count += amount
    }
    
    func reset()
    {
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.incrementBy(5)
counter.reset()

//2.本地和外部参数名称方法: swift默认第一个参数名为本地参数名，第二个和后续的为本地和外部参数名称
class LCounter
{
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int)
    {
        count += amount * numberOfTimes
    }
}

let Lcounter = LCounter()
Lcounter.incrementBy(5, numberOfTimes: 3)

//3.Self属性: 每一个实例都有一个隐含的self属性，有一个实例属性和方法参数都叫x，这时候加上self，可以区分
struct Point
{
    var x = 0.0, y = 0.0
    func isTheRightOfX(x: Double) -> Bool
    {
        return self.x > x
    }
    var z = 0.0
}
let somePoint = Point(x: 5.0, y: 0, z: 0)
print(somePoint.isTheRightOfX(0.0))

//4.修改类型的实例方法: 默认，一个数值类型的属性不能被它的实例方法修改，如要修改需加关键词mutating，但是常量的实例还是不能被修改的
struct Npoint
{
    var x = 0.0, y = 0.0
     mutating func moveByX(deltaX: Double, deltaY: Double)
    {
        x += deltaX
        y += deltaY
    }
}

var nSomePoint = Npoint(x: 1.0, y: 1.0)
print("nPoint now is \(nSomePoint.x), \(nSomePoint.y)")
nSomePoint.moveByX(2.0, deltaY: 3.0)
print("nPoint now is \(nSomePoint.x), \(nSomePoint.y)")

//可另外种写法
struct zPoint
{
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, deltaY: Double)
    {
        self  = zPoint(x: x + deltaX, y: y + deltaY)
    }
}

let lSomePoint = Npoint(x: 1.0, y: 1.0)
//lSomePoint.moveByX(2.0, deltaY: 3.0) //这里会报错，因为属性不能被修改，当实例类型为let时


enum TriStateSwitch
{
    case Off, Low, High
    
    mutating func next()
    {
        switch self
        {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

var ovenLight = TriStateSwitch.Off
print("before oven light \(ovenLight)")
ovenLight.next()
print("next oven light \(ovenLight)")

//5.类型方法: 类的类方法前+class关键字， 数值结构的类方法前+static
class SomeClass
{
    class func someTypeMethod() -> Bool
    {
        //类型方法实现
        return true
    }
}

print(SomeClass.someTypeMethod())

//举例
struct LevelTracker
{
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int)
    {
        if (level  > highestUnlockedLevel)
        {
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool
    {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool
    {
        if (LevelTracker.levelIsUnlocked(level))
        {
            currentLevel = level
            return true
        }
        else
        {
            return false
        }
    }
}

class Palyer
{
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int)
    {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }

    init(name: String)
    {
        playerName = name
    }
}

var player = Palyer(name: "zhf")
player.completedLevel(1)
print("highest unlock level is \(LevelTracker.highestUnlockedLevel)")
print(LevelTracker.levelIsUnlocked(1))

var zplayer = Palyer(name: "zhao")
if (zplayer.tracker.advanceToLevel(6))
{
    print("player now is level 6")
}
else
{
    print("level 6 is not unlock")
}
print(LevelTracker.levelIsUnlocked(1))

