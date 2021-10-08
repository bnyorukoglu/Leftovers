//
//  Crumb.swift
//  Leftovers
//
//  Created by 109895 on 7.10.2021.
//

import Foundation

class Crumb: Hashable,Codable {
    
    init(){
        self.title = "";
        self.priority = 0;
        self.contentType = 0;
        self.createDate = Date();
        self.due = Date();
        self.content = "";
        self.id = 0;
    }
    
    static func == (lhs: Crumb, rhs: Crumb) -> Bool {
        return lhs.id == rhs.id;
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(priority)
        hasher.combine(due)
        hasher.combine(contentType)
        hasher.combine(content)
    }
    
    
    var title:String
    var priority:Int
    var due:Date
    var contentType:Int
    var content:String
    var createDate:Date
    var id : Int
    var Id: Int {  get{
            return id
        }
        set(newId){
            id=newId
        }
    }
}

