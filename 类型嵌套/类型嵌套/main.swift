//
//  main.swift
//  类型嵌套
//
//  Created by zhaohf on 16/1/31.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation


struct BlackJackCard {
    enum Suit: Character
    {
        case Spades = "♠️",Heart = "❤️",Diamonds = "♦️",Clubs = "♣️"
        
    }
    
    enum Rank: Int
    {
        case Two = 2, Three, Four,Five,Six, Seven, Eight, Nine, Tem
        case Jack, Queen,King, Ace
        struct Values
        {
            let first: Int, second: Int?
        }
        var  values: Values
            {
                switch self
                {
                case .Ace:
                    return Values(first: 10, second: 11)
                case .Jack,.Queen,.King:
                    return Values(first: 10, second: nil)
                default:
                    return Values(first: self.rawValue, second: nil)
                }
                
        
            }
    }
    
    let rank:Rank , suit:Suit
    var description: String
        {
            var output = "suit is  \(suit.rawValue),"
            output += "value is \(rank.values.first)"
           
            if let second = rank.values.second
            {
                output += "or \(second)"
            }
             output += "rawValue \(suit.rawValue)"
            
            return output
    }
}

let theAceOfSpades = BlackJackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

