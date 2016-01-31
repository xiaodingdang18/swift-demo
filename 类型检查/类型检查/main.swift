//
//  main.swift
//  类型检查
//
//  Created by zhaohf on 16/1/30.
//  Copyright © 2016年 RW. All rights reserved.
//

import Foundation

class MediaItem
{
    var name: String
    init(name: String)
    {
        self.name = name
    }
}

class  Movie: MediaItem
{
    var director: String
    init(name: String, director: String)
    {
        self.director = director
        super.init(name: name)
        
    }
}

class Song: MediaItem
{
    var artist: String
    init(name: String, artist: String)
    {
        self.artist = artist
        super.init(name: name)
    }
}
//当libaray里面的类型是Movie和Song类型，取出的实例是MediaItem类型
let libaray = [
    Movie(name: "movieA", director: "directorA"),
    Song(name: "songA", artist: "songA"),
    Movie(name: "movieB", director: "directorB"),
    Song(name: "songB", artist: "songB"),
    Movie(name: "movieC", director: "directorC"),
    Song(name: "songC", artist: "songC"),
]

print(libaray[1])

//1.检查类型
var movieCount = 0
var songCount = 0
for item in libaray
{
    if item is Movie
    {
        movieCount++
    }
    else if item is Song
    {
        songCount++
    }
}

print("library movei count: \(movieCount), song count: \(songCount)")

//2.向下转型
for item in libaray
{
    if let movie = item as? Movie
    {
        print("movie: \(movie.name), dir.\(movie.director)")
    }
    else if let song = item as? Song
    {
        print("song: name \(song.name), artist: \(song.artist)")
    }
}

//3.Any和AnyObject类型检查

//AnyObject:任何对象类型
let someObject:[AnyObject] = [
    Movie(name: "MA", director: "DA"),
    Movie(name: "MB", director: "DB"),
    Movie(name: "MC", director: "DC")
]

for item in someObject
{
    let movie = item as! Movie
    print("movie: \(movie.name), dir.\(movie.director)")
}

for movie in someObject as! [Movie]
{
    print("movie: \(movie.name), dir.\(movie.director)")
}

//Any：任何类型，包括方法
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14158)
things.append("hellog")
things.append((3,5))
things.append(Movie(name: "movie", director: "director"))
things.append({(name: String) -> String in "hellog, \(name)"})

for thing in things
{
    switch thing
    {
    case 0 as Int:
        print("zero is int")
    case 0 as Double:
        print("zero is double")
    case let someInt as Int:
        print("an integer value: \(someInt)")
    case let someDouble as Double:
        print("some double value: \(someDouble)")
    case is Double:
        print("is double")
    case let someString as String:
        print("some string: \(someString)")
    case let (x,y) as (Int, Int):
        print("an (x,y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called: \(movie.name), \(movie.director)")
    case let stringConvert as (String) -> String:
        print(stringConvert("zhaohf"))
    
    default:
        print("default...")
    }
    
}
