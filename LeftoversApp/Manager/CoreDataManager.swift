//
//  CoreDataManager.swift
//  LeftoversApp
//
//  Created by 109895 on 8.10.2021.
//

import Foundation

import CoreData


class CoreDataManager{
    
    let persistenceContainer:NSPersistentContainer
    
    static let Instance = CoreDataManager();
    
    
    var Context:NSManagedObjectContext{
        return persistenceContainer.viewContext;
    }
    
    private init() {
        persistenceContainer = NSPersistentContainer(name:"LeftoversApp")
        persistenceContainer.loadPersistentStores{ (description,error) in if let error = error{
                fatalError("Core Data Store Failed")
            }
            
        }
    }
    
    /*
      We should Change thissss... We have to use some kind of a generic method... This does not seem right!!!
     **/
    
    func executeRequest(request:NSFetchRequest<Crumb>)-> [Crumb]{
        do{
            return try persistenceContainer.viewContext.fetch(request)
        }catch{
            return []
        }
    }
    
    func getAllCrumbs() -> [Crumb]{
        let fetchRequest: NSFetchRequest <Crumb> = Crumb.fetchRequest()
        return executeRequest(request: fetchRequest)
    }
    func clearStates(){
        
        do{
            try persistenceContainer.viewContext.undo();
        }catch{
            persistenceContainer.viewContext.rollback();
            print("Failed to save");
        }
        
    }
    
    func saveStates(){
        
        do{
            try persistenceContainer.viewContext.save();
        }catch{
            persistenceContainer.viewContext.rollback();
            print("Failed to save");
        }
        
    }
    func fetchById(id:NSManagedObjectID) throws ->NSManagedObject{
        
        return try Context.existingObject(with: id);
    }
    
}
public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}
