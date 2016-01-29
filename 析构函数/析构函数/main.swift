//
//  main.swift
//  析构函数
//
//  Created by zhaohf on 16/1/29.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//1.析构：每个类对多有一个析构函数，析构不带任何参数，写法不带括号，子类的析构函数实现后，父类的析构自动调用
//deinit
//{
//    //执行析构过程
//}

//2.析构器操作：

class Bank {
    static var coninsInBank = 1000//static修改的变量不能被实例调用，类方法
    static func vendCoins(numberOfCoinsRequesten: Int) -> Int
    {
        let numberOfCoinsToVend = min(numberOfCoinsRequesten,coninsInBank)
        coninsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func reveiveCoins(coins: Int)
    {
        coninsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int)
    {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int)
    {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit
    {
        Bank.reveiveCoins(coinsInPurse)
    }
}
var playerOne: Player? = Player(coins: 100)
print("coinsInPurse: \(playerOne!.coinsInPurse)")
print("coins In Bacnk: \(Bank.coninsInBank)")
playerOne!.winCoins(2000)
print("coinsInPurse: \(playerOne!.coinsInPurse)")
print("coins In Bacnk: \(Bank.coninsInBank)")
playerOne = nil
print("palyer left game")
print("coinsInPurse: \(playerOne?.coinsInPurse)")
print("coins In Bacnk: \(Bank.coninsInBank)")


