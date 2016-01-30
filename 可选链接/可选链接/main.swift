//
//  main.swift
//  可选链接
//
//  Created by zhaohf on 16/1/30.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.可选链可以替代强制解析
class Person
{
    var residence:Residence? //可选链告诉编译器检查residence是否有值，如果没有，则numberOfRooms返回Int?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms
{
    print("john room count is: \(roomCount)")
}
else
{
    print("unable to retrieve the number of room")
}
john.residence = Residence()
print("john room count is: \(john.residence!.numberOfRooms)")

//2.可选链定义模型
class Residence1
{
    var rooms = [Room]()
    var numberOfRooms: Int
        {
        return rooms.count
    }
    subscript(i: Int) -> Room
    {
        get
        {
            return rooms[i]
        }
        set
        {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms()
    {
        print("the number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}
class Room
{
    let name: String
    init(name: String)
    {
        self.name = name
    }
}
class Address
{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String?
    {
        if (buildingName != nil)
        {
            return buildingName
        }
        else if (buildingNumber != nil && street != nil)
        {
            return "\(buildingNumber) \(street)"
        }
        else
        {
            return nil
        }
        
    }
    
}
class Person1
{
    var residence1:Residence1?
}
let zhf = Person1()
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.buildingName = "road"
zhf.residence1?.address = someAddress //residence1为空，因为residence为空

func createAddress() -> Address
{
    print("function was called")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.buildingName = "road"
    return someAddress
    
}
zhf.residence1?.address = createAddress() //因为residence1为空，createAddress没有打印

//通过可选链获取下标
if let firstRoom = zhf.residence1?.rooms[0].name
{
    print("the first room is \(firstRoom)")
}
else
{
    print("can not print first room")//
}

//可选链上获取可选类型下标志:
var testScore = ["one": [1,2,3],"two" : [2,4,6]]
testScore["one"]?[1] = 91
testScore["two"]?[2] = 89
testScore["three"]?[1] = 90//key为three的元素没有，所以设置失败
print(testScore)

let zhfHouse = Residence1()
zhfHouse.rooms.append(Room(name: "living room"))
zhfHouse.rooms.append(Room(name: "kichen"))
zhf.residence1 = zhfHouse
print("first room is  \(zhf.residence1?.rooms[0].name)")

zhf.residence1?.address = someAddress
print(zhf.residence1?.address?.buildingName)

