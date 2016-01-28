//
//  main.swift
//  初始化
//
//  Created by zhaohf on 16/1/28.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.存储属性的初始化： 类和结构体在它们被创建时必须把所有存储属性设置为合理的值

struct Fathrenheig {
    var temperature: Double //可以在这里直接赋予默认值32.0,比在构造函数里面赋值更好
    
    init()
    {
        temperature = 32.0
    }
}
var f = Fathrenheig()
print("temperture: \(f.temperature)")

//2.自定义初始化
struct Celsus
{
    var temperature: Double = 0.0
    init(fromFahrenheit fathrenheit: Double)
    {
        temperature = (fathrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double)
    {
        temperature = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsus(fromFahrenheit: 212.0)
print("boiling point of water \(boilingPointOfWater)")
let freezingPointOfWater = Celsus(fromKelvin: 273.15)
print("freezingPointOfWater: \(freezingPointOfWater)")

//3.实参和形参: 如果不想要形参，可以在参数名前面加上"_"
struct Color
{
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double)
    {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double)
    {
        red = white
        green = white
        blue = white
    }
    init(_ withoutArg: Double)
    {
        red = withoutArg
        green = withoutArg
        blue = withoutArg
    }
    
    func description()
    {
        print("red: \(red), green: \(green), blue: \(green)")
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
magenta.description()
let halfGreen = Color(white: 0.5)
halfGreen.description()
let noArgColor = Color(34.0)
noArgColor.description()

//4.可选类型：构造函数必须保证所有属性为合理的值，如果需要一个属性为空，可以声明为可选，后面+ “?”
class SurveyQuestion
{
    var text: String
    var response: String?
    init(text: String)
    {
        self.text = text
    }
    func ask()
    {
        print(text)
    }
}
let chooseQuestion = SurveyQuestion(text: "do you like cheese")
chooseQuestion.ask()
chooseQuestion.response = "yes ,i do like cheese"

//5.在初始化时修改静态属性： 在初始化完成之前都可以修改静态属性
class nSubQuestion
{
    let text: String
    init(text: String)
    {
        self.text = text
    }
}

//6.默认构造器: 所有属性都有默认值，并且是基类，所以自动创建构造器
class ShoppingListItem
{
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

//7.系统为结构体成员生成初始化构造器，如果没有定义构造器方法
struct Size
{
    var height: Double = 0
    var width: Double = 0.0
//    init(height: Double)
//    {
//        self.height = height//如果定义了init方法，就必须保证所有成员都有值，不可以定义部分属性
//    }
}

//7.数值类型结构构造器代理
struct Point
{
    var x = 0.0, y = 0.0
}

struct  Rect {
    var origin = Point()
    var size = Size()
    init()
    {
        
    }
    init(origin: Point, size: Size)
    {
        self.origin = origin
        self.size = size
    }
    
    init (center: Point, size: Size)
    {
        let originX = center.x - (size.width / 2.0)
        let originY = center.y - (size.height / 2.0)
        let org = Point(x: originX, y: originY)
        self.init(origin: org, size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(height: 3.0, width: 3.0))
print("center Rect origin: \(centerRect.origin)")

//8.类的继承和初始化
//指定构造器和便捷构造器
//指定构造器语法
/*
init(parameters)
{
    statements
}
*/

//便捷构造器语法
/*
convenience init(parameters)
{
    statements
}
*/
/*
指定构造器和便捷构造器关系:
1.指定构造器必须调用它直接父类的指定构造器
2.便捷构造器必须调用它同类中的指定构造器
3.便捷构造器必须以指定构造器结束调用
 指定构造器调用都是向上调用
便捷构造器都是横向同级调用
两阶段的初始化：
1.每一个存储属性都被设置一个初始值
2.每个类在实例被使用之前都有机会设置它们相应的存储属性
四个检查步骤：
1.每个类中指定构造器在调用父类指定构造器之前，确保把自己定义的存储属性做初始化操作
2.指定构造器如果需要赋值继承下来的存储属性，必须在赋值之前 ，调用父类的的指定构造器。否则赋值的值将被父类的指定构造器的赋值覆盖掉
3.便捷构造器如果要赋值给一个存储属性，必须在赋值之前，调用另外一个构造器，否则赋值将被本类的指定构造器赋值覆盖掉
4.当第一阶段结束后，所有的构造器都可以访问实例方法，读取任何实例属性，获取self

根据这四个检查，每个阶段都需要做的事情如下
阶段一：：：
1.类调用指定构造器或便捷构造器
2.分配类的一个新的实例内存，内存这个时候还没有被初始化
3.指定构造器确保本类的所有属性被赋值，这些对应的存储属性内存别分配
4.指定构造器调用父类的指定构造器，对父类本身的存储属性做同样的操作
5.在继承链中做同样的操作，知道基类为止
6.基类的指定构造器完成对本类的存储属性赋值后，整个继承链中的存储属性都被赋值，可以认为实例的内存被初始化，阶段一完成
阶段二：：：：
1.从基类往下，每一个类的指定构造器，都可以对本类的存储属性进行修改，并且可以通过self修改属性和调用方法
2.便利构造器也可以通过slef对实例进行操作

*/

//9.构造器的继承和重写
class Vehicle
{
    var numberOfWheels = 0
    var description: String
        {
        return "\(numberOfWheels) wheels"
    }
}
let vehicale = Vehicle()
print("vehicle: \(vehicale.description)")

class Bicycle: Vehicle {
    override init() //重写父类的init方法，override
    {
        super.init()//保证父类先初始化，然后子类有机会修改numberOfWheels,否则会被父类的值覆盖
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("bicycle: \(bicycle.description)")

//10.构造器的自动继承
/*
1.如果子类没有定义指定构造器，子类自动继承父类构造器
2.如果子类实现或者继承了所有指定构造器，那么子类将继承所有父类的便捷构造器
*/
class Food
{
    var name: String
    init(name: String)
    {
        self.name = name
    }
    convenience init()
    {
        self.init(name: "Unnamed")
    }
}
let nameMeat = Food(name: "bacon")
print("nameMeat: \(nameMeat.name)")

let mySteryMeat = Food()
print("myStery Meat: \(mySteryMeat.name)")

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int)
    {
        self.quantity = quantity
        super.init(name: name)
    }
    //子类中定义便捷构造器，重写了父类的指定构造器
     convenience override init(name: String)
    {
        self.init(name:name, quantity:1)
    }
}
//子类继承父类所有方法
let oneMsteryitem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "bacon")
let sixTgs = RecipeIngredient(name: "eggs", quantity: 1)
print("oneMsteryitem: "+oneMsteryitem.name  + String(oneMsteryitem.quantity))
print("oneBacon: " + oneBacon.name + String(oneMsteryitem.quantity))
print("sixTgs: " + sixTgs.name + String(oneMsteryitem.quantity))

class ShoppintListItem:RecipeIngredient
{
    var purchased = false
    var description:String
        {
        var output = "\(quantity) * \(name)"
            output += purchased ? "right" : "wrong"
            return output
    }
}

//11.失败的初始化
struct Animal
{
    let spieces: String
    init?(spieces: String)
    {
        if spieces.isEmpty
        {
            return nil
        }
        self.spieces = spieces
    }
}
let someCreature = Animal(spieces: "")
print("some creature \(someCreature?.spieces)")

enum Temperature
{
    case Kvelvin, Celsius, Fahrenheit
    init?(symbol: Character)
    {
        switch symbol
        {
            case "K":
            self = .Kvelvin
            case "C":
            self = .Celsius
            case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fTem = Temperature(symbol: "F")
print("fTem : \(fTem)")
let nonTem = Temperature(symbol: "h")
print("nonTem: \(nonTem)")

//12.闭包函数设置默认值

//闭包跟block很相似，{}里面就是函数实现，而入参和返回类型（s1: String, s2: String）-> bool in
//写在函数实现的上一行，调用函数的就是{}（），加小括号调用
struct CheckBoard
{
    let boardColors: [Bool] =
    {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10
        {
            for j in 1...10
            {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool
    {
        return boardColors[(row * 10) + column]
    }
}

let board = CheckBoard()


