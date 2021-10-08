//
//  RandomDataGenerator.swift
//  Leftovers
//
//  Created by 109895 on 7.10.2021.
//

import Foundation


var randomCrumbs:[Crumb] = generateData();


func generateData()->[Crumb]{
    
    var randomCrumbs2:[Crumb] = []
    for _ in 1..<20 {
        var q = Crumb();
        
        q.Id = Int.random(in: 1..<200)
        q.priority = Int.random(in: 0..<3)
        q.title = randomString(length: 30)
        q.content =  randomString(length: 500)
        randomCrumbs2.append(q);
    }
    return randomCrumbs2

}

func newDataItem()->Crumb{
    var q = Crumb();
    q.Id = Int.random(in: 1..<200)
    q.priority = Int.random(in: 0..<3)
    q.title = randomString(length: 30)
    q.content =  randomString(length: 500)
    return q;
}

func randomString(length: Int) -> String {
  let letters = "abcdefghijk lmno     pqrst  uvwxyzABCDEFGHIJKLMNOPQRST  UVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
