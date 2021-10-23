//
//  CrumbViewModel.swift
//  LeftoversApp
//
//  Created by 109895 on 11.10.2021.
//
import Foundation
import CoreData

class CrumbViewModel:ObservableObject{
    
    
    static var  CREATE_DATE:String = "createdate"
    static var  TITLE:String  = "title"
    static var  DUE_DATE:String  = "due"
    @Published var crumbs:[CrumbModel] = [];
    init() {
        
    }
    
    var isDirty:Bool{
        
        return CoreDataManager.Instance.Context.hasChanges;
    }
    
    func sortByKey(key:String,direction:Int){
        
        if key.elementsEqual(CrumbViewModel.CREATE_DATE){
            
            if direction == 0{
                crumbs.sort {
                    $0.CreateDate < $1.CreateDate
                }
            }
            else{
                crumbs.sort {
                    $0.CreateDate > $1.CreateDate
                }
            }
           
        }
        if key.elementsEqual(CrumbViewModel.TITLE){
            if direction == 0{
                crumbs.sort {
                    $0.Title < $1.Title
                }
            }
            else{
                crumbs.sort {
                    $0.Title > $1.Title
                }
            }
            
           
        }
        if key.elementsEqual(CrumbViewModel.DUE_DATE){
            if direction == 0{
                crumbs.sort {
                    $0.DueDate < $1.DueDate
                }
            }
            else{
                crumbs.sort {
                    $0.DueDate > $1.DueDate
                }
            }
        }
        
    }
    
    func deleteCrumb(crumb:CrumbModel){
        
        deleteCrumb(crumb: crumb.crumb);
    }
    
    func filter(filterText:String){
        let pred:NSPredicate = NSPredicate(format: "title CONTAINS[cd] %@", filterText);
        let ftch: NSFetchRequest <Crumb> = Crumb.fetchRequest()
        ftch.predicate  = pred;
        crumbs = CoreDataManager.Instance.executeRequest(request:ftch).map(CrumbModel.init);
    }
    
    func getContext()->NSManagedObjectContext{
        return CoreDataManager.Instance.Context;
    }
    
    func deleteCrumb(crumb:Crumb){
        
        CoreDataManager.Instance.Context.delete(crumb)
        CoreDataManager.Instance.saveStates();
    }
    func saveChanges(){
        
       
        CoreDataManager.Instance.saveStates();
    }
    
    func getCrumbs(){
        
        crumbs =  CoreDataManager.Instance.getAllCrumbs().map(CrumbModel.init);
    }
    func getCrumbById(id:NSManagedObjectID) throws ->CrumbModel{
        
        var crumb:Crumb =  try CoreDataManager.Instance.fetchById(id:id) as! Crumb
        return CrumbModel(crumb: crumb)
    }
    func reflectChanges(){
        do {
            try  CoreDataManager.Instance.Context.save();
        } catch  {
            print("Error in transactions");
            CoreDataManager.Instance.Context.rollback();
        }
       
    }
    
    
}
protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}

class CrumbModel: ObservableObject,PropertyReflectable{
    
    @Published var crumb:Crumb;
    init(crumb:Crumb){
        self.crumb = crumb
    }
     init() {
        
        self.crumb = Crumb(context:CoreDataManager.Instance.Context);
    }
    
    var Id:NSManagedObjectID{
        return crumb.objectID
    
    }
    
    var Title:String{
        get{return crumb.title ?? ""}
        set{crumb.title = newValue}
    
    }
    var Content:String
    {
        return crumb.title ?? "";
    
    }
    var Priority:Int32
    {
        return crumb.priority
    
    }
    
    var CreateDate:Date{
        return crumb.createDate ?? Date();
        
    
    }
    var DueDate:Date{
        return crumb.due ?? Date();
        
    
    }
    
}
