//
//  main.swift
//  继承
//
//  Created by zhaohf on 16/1/27.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.基类：任何一个不继承其他类的类被称作基类
class Vehicle {
    var numberofWheels: Int
    let maxPassengers: Int
    var currentSpeed = 0.0
    
    func description() -> String
    {
        return "\(numberofWheels) wheels ; up to \(maxPassengers) passengers currentspeed \(currentSpeed)"
    }
    
    func makeNoise()
    {
        
    }
    //构造函数确保所有实例的属性都是有效的
    init()
    {
        numberofWheels = 0
        maxPassengers = 1
    }
}

let someVehicle = Vehicle()
print("vehicle : \(someVehicle.description)")
//1.子类：继承父类属性，并且可以被重写，也可以新增属性

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("bicycle description \(bicycle.description())")

//3.重写方法
class Train: Vehicle
{
    override func makeNoise() {
        print("choo choo")
    }
}

let train = Train()
train.makeNoise()

//4.重写属性： 可以将只读的属性重写为读写的，但是反之不可以
class Car: Vehicle
{
    var gear = 1
    override func description() -> String {
        return super.description() + "in gear \(gear)"
    }
}

let car  = Car()
car.gear = 5
car.currentSpeed = 35
print("car: \(car.description())")

//4.重写getter setter
class SpeedLimitCar: Car
{
    override var currentSpeed: Double
    {
        get
        {
            return super.currentSpeed
        }
        set
        {
            super.currentSpeed = min(newValue, 40.0)
        }
    }
}

let limitCar = SpeedLimitCar()
limitCar.currentSpeed = 60.0
print("limitCar: \(limitCar.description())")

//5.重写属性观察者
class AutomaticCar: Car
{
    override var currentSpeed: Double
        {
        didSet
        {
            gear = Int(currentSpeed / 10.0 + 1)
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 10
print("automatic car : \(automatic.description())")



//6.禁止重写 ： 关键词前面+final