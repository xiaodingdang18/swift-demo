//
//  main.swift
//  访问控制
//
//  Created by zhaohf on 16/2/3.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//访问控制语法
public class SomePublicClass{}
internal class SomeInternalClass{}
private class SomePrivateClass{}

public var somePublicVariable = 0
internal let someInternalConstant = 0
private func somePrivateFunction(){}

//自定义类型
public class SomePublicClass1
{
    public var somePublicProperty = 0 //显示public
    var someInternalProperty = 0 //隐式internal
    private func somePrivateMethod() {} //显示private成员
}

class SomeInternalClass1
{
    var someInternalProperty = 0  //隐式internal成员
    private func somePrivateMethod(){} //显示private
}

private class SomePivateClass1
{
    var somePrivateProperty = 0 //隐式private类成员
    func somePrivateMethod(){} //隐式private方法
}

//函数的访问级别根据访问级别最严格的参数类型或返回类型级别决定，如果这个访问级别不符合函数定义的默认级别，需要明确的指定该函数的访问级别
/*
private func someFunction() -> (SomeInternalClass1, SomePublicClass1)
{
    //函数实现部分
}
*/

//枚举成员的访问级别和枚举类型相同，不能为枚举成员单独指定不同的访问级别，并且初始值不能低于枚举级别
public enum CompassPoint
{
    case North//成员都是public
    case South
    case East
    case West
}

//子类的访问级别不得高于父类的访问级别，可以通过重写为继承来的类成员提供,可以在子类中访问比自己级别低的父类成员成员

public class A
{
    private func someMethod()
    {
        
    }
}

internal class B: A
{
    override internal func someMethod()
    {
        super.someMethod() //A,B在同一个源文件中，所以可以访问private
    }
}

//getter /setter
public struct TrackedString
{
    public private(set) var numberOfEdits = 0 //public的get，和private的set
    public var value: String = ""
    {
        didSet
        {
            numberOfEdits++
        }
    }
}
