//
//  main.swift
//  自动引用计数
//
//  Created by zhaohf on 16/1/29.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//引用计数仅仅作用于类实例上
//1.ARC怎么样工作： 每当创建一个实例，ARC分配一块内存存储实例信息，当有强引用指向实例时，内存不会释放
class Test
{
    var a:Int = 0
    init(a: Int)
    {
        self.a = a
    }
    deinit
    {
        
    }
}
var test:Test? = Test(a: 1)
print(test?.a)
test = nil
print(test?.a)

//2.ARC
class Person
{
    let name:String
    init(name: String)
    {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit
    {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?
print("before init reference1")
reference1 = Person(name: "name1")
reference2 = reference1
reference3 = reference1

reference1 = nil
print("reference1 = nil")
reference2 = nil
print("reference2 = nil")
reference3 = nil
print("reference3 = nil")
print(reference3?.name)

//3.实例间强引用循环:使用weak或unowned,weak的变量可以为空，所以声明为可选类型，unowned为一直有值，所以不可以声明为可选类型，类似unsafe
class Person1
{
    let name:String?
    init(name: String)
    {
        self.name = name
    }
    var apartment: Apartment?
    deinit
    {
        print("\(name) is being deinit")
    }
}
class Apartment {
    let unit: Int
    init(unit: Int)
    {
        self.unit = unit
    }
    
    weak var tenant: Person1?
    deinit
    {
        print("apartment \(unit) is being deinit")
    }
}

var johb: Person1?
var number73: Apartment?
johb = Person1(name: "john")
number73 = Apartment(unit: 73)

johb!.apartment = number73
number73!.tenant = johb

johb = nil //person实例释放,
print("after person = nil, number referent person is \(number73!.tenant?.name)")

number73 = nil //apartment实例释放
/*
johb --strong--> person
number73 --strong--> apartment
johb --strong--> apartment
person <--strong-- number73

johb = nil

[person dealloc]
number73 --strong--> apartment
number73.tenant --> nil

*/

//4.无主引用
class Customer
{
    let name: String
    var card:CreditCard? //用户可以没有信用卡，所以声明为可选类型，并且var可变
    init(name: String)//构造函数不必为可选类型初始化，默认为nil
    {
        self.name = name
    }
    deinit
    {
        print("\(name) is being deinitialed")
    }
}

class CreditCard
{
    let number: Int
    unowned var customer: Customer //信用卡对应的人不能为空，并且不可以修改
    init(number: Int, customer: Customer)
    {
        self.number = number
        self.customer = customer//unowned类型必须有值，所以必须初始化
    }
    deinit
    {
        print("\(number) card is being deinitalized")
    }
}

var zhf: Customer?
zhf = Customer(name: "zhf")
zhf?.card = CreditCard(number: 2222, customer: zhf!)
zhf = nil //zhf实例释放后，card也释放,
/*
zhf --strong--> custom
zhf --strong--> card
zhf <--unowned-- card
zhf释放后没有强引用指向card，所以card也释放
*/

//5.无主引用和隐式拆分可选属性

//city的构造器在country里面调用，但是知道country实例初始化完成之前都不可以把self传递给country构造器，所以capitalCity需要加！默认值为nil
class Country
{
    let name: String
    var capitalCity: City!
    var oterStr: String!
    init(name: String, capitalName: String)
    {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City
{
    let name: String
    unowned let country: Country
    init(name: String, country:Country)
    {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
print("country name: \(country.name), capital name: \(country.capitalCity.name)")

//6.闭包的强引用循环: 闭包是函数指针，即HTMLElement有一个对闭包函数的强引用，而闭包函数里面又截获HTMLElement成员属性变量，所以HTMLElement实例和闭包之间构成循环引用
class HTMLElement
{
    let name:String
    let text: String?
    lazy var asHTML:() -> String =
    {
        [unowned self] in //定义捕获列表，防止循环引用
        if let text = self.text
        {
            return "<\(self.name)>\(text)"
        }
        else
        {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil)
    {
        self.name = name
        self.text = text
    }
    deinit
    {
        print("html elememt deinititalized")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello world")
print(paragraph!.asHTML())
paragraph = nil

//7.结局闭包循环引用方法：补货列表的元素由一个weak/unowned关键词，
//当闭包和实例总是引用对方并且同时释放时，定义捕获列表为无主引用
//当捕获引用可能为nil的时候,定义捕获列表为弱引用
/*
lazy var someClosure:(Int, String) -> String =
{
    [unowned self, weak delegate = self.delegate!](index: Int, stringToProcess: String) -> String in
    //closure body goes here
}

//没有参数和返回值的时候，可以简写
lazy var someClosure:Void -> String = {
    [unowned self, weak delegate = self.delegate!] in
}
*/
