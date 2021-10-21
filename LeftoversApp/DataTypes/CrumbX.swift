//
//  Crumb.swift
//  Leftovers
//
//  Created by 109895 on 7.10.2021.
//

import Foundation
import CoreData

class CrumbX: Hashable,ObservableObject{
    
    @Published var title:String
    @Published var priority:Int
    @Published var due:Date
    @Published var contentType:Int
    @Published var content:String
    @Published var createDate:Date
    
    @Published var id : Int
    
    var Id: Int {  get{
            return id
        }
        set(newId){
            id=newId
        }
    }
    
    init(){
        self.title = "";
        self.priority = 0;
        self.contentType = 0;
        self.createDate = Date();
        self.due = Date();
        self.content = "";
        self.id = 0;
        
    }
    func fromCrumb(crumb:Crumb){
       
        //self.objId = crumb.objectID;
        self.title = crumb.title ?? " ";
        self.content = crumb.content ?? " "
        self.createDate = crumb.createDate ?? Date()
        self.due = crumb.due ?? Date();
        self.priority = Int(crumb.priority)
       
    }
    func toCrumb(crumb:Crumb){
       
        crumb.id =  Int32(self.id) ;
        crumb.title = self.title;
        crumb.content = self.content;
        crumb.createDate = self.createDate;
        crumb.due = self.due;
        crumb.priority = Int32(self.priority)
       
    }
    
  
 
    
    static func == (lhs: CrumbX, rhs: CrumbX) -> Bool {
        return lhs.id == rhs.id;
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(priority)
        hasher.combine(due)
        hasher.combine(contentType)
        hasher.combine(content)
    }
    
 
}

