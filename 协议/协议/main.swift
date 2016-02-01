//
//  main.swift
//  协议
//
//  Created by zhaohf on 16/2/1.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.协议语法
/*
protocol SomeProtocol
{
    //protocol definition goes here
}

struct SomeStructure: FirstProtocol, SecondProtocol
{
    //structure  definition goes here
}

class SomeClass: SomeSuperClass: FirstProtocol, SecondProtocol
{
    //class definition goes here
}
*/

//2.属性要求
protocol SomeProtocol
{
    var mustBeSettable: Int{ get set}
    var doesnotNeedToBeSettable: Int{get}
}

protocol AnotherProtocol
{
    static var someTypeProperty: Int{get set}
}

protocol FullyNamed
{
    var fullName: String {get}
}

struct Person: FullyNamed
{
    var fullName: String
}
let john = Person(fullName: "john fullname")
print("full name is \(john.fullName)")


class Startship: FullyNamed
{
    var perfix: String?
    var name: String
    init(name: String, perfix: String? = nil)
    {
        self.name = name
        self.perfix = perfix
    }
    
    var fullName: String
    {
        return (perfix != nil ? perfix! + " " : " ") + name
    }
}
var ncc1701 = Startship(name: "enterprise", perfix: "USS")
print("startship fullNmae: " + ncc1701.fullName)


//3。方法要求
protocol SomeProtocol1
{
    static func someTypeMethod()
}

protocol RandomNumberGenerator
{
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator
{
    var lastRandom = 42.0
    let m = 13989.0
    let a = 3877.0
    let c = 33323.0
    func random() -> Double {
        lastRandom  = (lastRandom * a + c) % m
        return lastRandom / m
    }
}

let genertator = LinearCongruentialGenerator()
print("here is a random number: \(genertator.random())")
print("another random number: \(genertator.random())")

//4.修改方法
protocol Togglable
{
    mutating func toggle()
}
enum OnOffSwitch: Togglable
{
    case Off, On
    mutating func toggle() {
        switch self
        {
        case .Off:
            self = .On
        case .On:
            self = .Off
            
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
print("light Swithch is: \(lightSwitch)")


//5.初始化要求：可以是固定构造器和便捷构造器，方法实现的时候前面必须加关键词requared
protocol SomeProtocl2
{
    init(someParameter: Int)
}

class SomeClass2: SomeProtocl2
{
    required init(someParameter: Int) {
        //initializer implemention goes here
    }
}

//如果一个子类重载父类的固定构造函数并且遵循一个协议也实现了该构造函数，则required override
class someSuperClass
{
    init(someParameter: Int)
    {
        
    }
}

class someSubClass: someSuperClass, SomeProtocl2
{
    required override init(someParameter: Int)
    {
        super.init(someParameter: 5)
    }
}

//6.协议作为类型
/*
1.入参和返回类型，
2.常量、变量、属性类型
3.数组和字典中的元素类型
*/

class Dice
{
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) //可以接受任何遵循random协议的类型
    {
        self.sides = sides
        self.generator = generator
        
    }
    
    func roll() -> Int
    {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5
{
    print("random  dice roll is \(d6.roll())")
}

//7.委托
protocol DiceGame
{
    var dice: Dice{get}
    func play()
}
protocol DiceDelegate
{
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll didRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame
{
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init()
    {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare
        {
            let dictRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: dictRoll)
            switch square + dictRoll
            {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += dictRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
    
}

class DiceGameTracker: DiceDelegate
{
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders
        {
            print("start snake games")
        }
        
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll didRoll: Int) {
        numberOfTurns += 1
        print("rolled  a \(didRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("the game is over")
    }
}
let tracker  = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


//8.在扩展中添加协议

protocol TextRepresentable
{
    var textualRepresention: String{get}
    // func asText() -> String
}

extension Dice: TextRepresentable
{
    var textualRepresention: String
    {
        return "A  \(sides) -side dice"
    }
//    func asText() -> String
//    {
//        return("extension protocol sucess!")
//    }
}
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
//print(d12.asText())

//9.当以个类型已经实现了协议中所要求的，却没有声明，可以通过扩展来补充声明
struct Hamster
{
    var name: String
    var textualRepresention: String
        {
        return "A Hamster"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresention: TextRepresentable = simonTheHamster
print("something textRepresention \(somethingTextRepresention.textualRepresention)")

//10.集合中的协议类型
let things: [TextRepresentable] = [d12,simonTheHamster]
for thing in things
{
    print(thing.textualRepresention)
}

//11.协议的继承：协议能继承一个或多个协议
protocol InheritingProtocol: SomeProtocol,AnotherProtocol
{
    
}

protocol PrettyTextRepresentable: TextRepresentable
{
    var prettyTextDecription: String { get }
}

extension Hamster: PrettyTextRepresentable
{
    var prettyTextDecription: String
    {
        return "pretty text decrition!"
    }
}

let theHamster = Hamster(name: "zhf")
print("协议继承多个：" + theHamster.prettyTextDecription + "and : " + theHamster.textualRepresention)
//12.只允许类遵从协议
protocol SomeClassOnlyProtocol: class, SomeProtocol
{
    //class only protocol definition goes here
}

//13.协议的合成
protocol Named
{
    var name: String { get }
}

protocol Aged
{
    var age: Int { get }
}

struct Person1: Named, Aged
{
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named,Aged>) //celebarator入参，同事遵循Named和Aged两个协议
{
    print("happy birthday \(celebrator.name), \(celebrator.age)")
}
let birthdayPerson = Person1(name: "zhf", age: 25)
wishHappyBirthday(birthdayPerson)

//14.检查协议的一致性
/*
1.is操作作福检查实例是否遵循某个协议
2.as？返回一个可选值，当实例遵循协议时返回该协议类型；否则返回nil
3.as用以强制向下转换
*/

protocol HasArea
{
    var area: Double { get }
}

class Circle: HasArea
{
    let pi = 3.14159
    var radius: Double
    var area: Double { return pi * radius * radius}
    init(radius: Double)
    {
        self.radius = radius
    }
    
}

class Country: HasArea
{
    var area: Double
    init(area: Double)
    {
        self.area = area
    }
}

class Animal
{
    var legs: Int
    init(legs: Int)
    {
        self.legs = legs
    }
}

let objects:[AnyObject] = [
Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects
{
    if let objectWithArea = object as? HasArea
    {
        print("area is: \(objectWithArea.area)")
    }
    else
    
    {
        print("something that doesn't have an area")
    }
}

//15.可选协议要求： 可选协议只能在含有@objc前缀的协议中生效，协议中使用optional关键词,可选协议只能在类对象中使用，结构和枚举bukyi
@objc protocol CounterDataSource
{
    optional func incrementForCount(count: Int) -> Int
    optional var fixIncrement: Int { get }
}

class Counter
{
    var count = 0
    var dataSource: CounterDataSource?
    func increment()
    {
        if let amount = dataSource?.incrementForCount?(count)
        {
            count += amount
        }
        else if let amount = dataSource?.fixIncrement
        {
            count += amount
        }
    }
    
}
class ThreeSource: NSObject, CounterDataSource
{
    let fixIncrement = 3
    
    func incrementForCount(count: Int) -> Int {
        return count + 1
    }
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4
{
    counter.increment()
    print(counter.count)
}
counter.increment()

class TowardsZeroSource: NSObject, CounterDataSource
{
    func incrementForCount(count: Int) -> Int {
        if count == 0
        {
            return 0
        }
        else if count < 0
        {
            return 1
        }
        else
        {
            return -1
        }
        
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5
{
    counter.increment()
    print(counter.count)
}

//16。协议的扩展: 不仅声明方法，还可以添加方法的实现
extension RandomNumberGenerator
{
    func randomBool() -> Bool
    {
        return random() > 0.5
    }
}

let generator = LinearCongruentialGenerator()
print("here is a random number: \(generator.random())")
print("and here is a random boolen : \(generator.randomBool())")

//17.给协议提供默认实现方法
extension PrettyTextRepresentable
{
    var prettyTextDecription:String
        {
            return "aaaaa"
    }
}

extension TextRepresentable
{
    
}
//18.为协议扩展添加限制条件????????????????
//符合集合，并且元素遵循TextRepresentable协议
extension CollectionType where Generator.Element: TextRepresentable
{
    var textualDescription: String
        {
            let itemsAsText = self.map{$0.textualRepresention }
            return "[" + itemsAsText.joinWithSeparator(", ") + "]"
    }
    
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.textualDescription)
