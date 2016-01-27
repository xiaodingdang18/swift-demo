//
//  main.swift
//  下标
//
//  Created by zhaohf on 16/1/27.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

//下标语法
//subscript(index: Int) -> Int
//{
//    get
//    {
//        
//    }
//    set(newValue)
//    {
//        
//    }
//}
struct TimesTable
{
    let multiplier: Int
    subscript(index: Int) -> Int
        {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six timesthree is \(threeTimesTable[6])")

//2.下标的使用
var numberOfLegs = ["a" : 8, "b" : 9]
numberOfLegs["c"] = 10

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int)
    {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool
    {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double
    {
        get
        {
            assert(indexIsValidForRow(row, column: column), "index out of range")
            return grid[(row * columns) + column]
        }
        set
        {
            assert(indexIsValidForRow(row, column: column), "index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0,1] = 1.5
matrix[1,0] = 2.5
print(matrix)