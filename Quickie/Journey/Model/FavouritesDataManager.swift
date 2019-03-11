//
//  FavouritesDataManager.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 09/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import CoreData
import UIKit

class FavouritesDataManager {
    
    var favouritePlaces: [FavouritePlace]?
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.persistentContainer.viewContext
    }()
    
    init() {
        favouritePlaces = readData()
    }
    
    func addPlace(_ place: PlaceItem,  completionHandler: @escaping ()->()) {
        
        let favouritePlace = FavouritePlace(context: context)
        favouritePlace.name = place.name
        favouritePlace.subtitle = place.detailedName
        favouritePlace.latitude = place.latitude ?? 0
        favouritePlace.longitude = place.longitude ?? 0
        
        do {
            try context.save()
            self.favouritePlaces = readData()
            completionHandler()
        } catch let error as NSError {
            print("Couldn't save the data. \(error)")
        }
    }
    
    func readData() -> [FavouritePlace]? {
        
        let request: NSFetchRequest<FavouritePlace> = NSFetchRequest(entityName: "FavouritePlace")
        
        do {
            let result = try context.fetch(request)
            return result
            
        } catch let error as NSError {
            print("Couldn't read the data,. \(error)")
        }
        return nil
    }
    
    func deleteFavouriteLocation(_ name: String) {
        let request: NSFetchRequest<FavouritePlace> = NSFetchRequest(entityName: "FavouritePlace")
        let predicate = NSPredicate(format: "name = %@", name)
        
        request.predicate = predicate
        
        do {
            let objects = try context.fetch(request)
            let objectToDelete = objects[0]
            context.delete(objectToDelete)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Couldn't read the data,. \(error)")
            }
            
        } catch let error as NSError {
            print("Couldn't read the data,. \(error)")
        }
    }
    
    func clearDataBase() {
        let request: NSFetchRequest<FavouritePlace> = NSFetchRequest(entityName: "FavouritePlace")
        
        do {
            let objects = try context.fetch(request)
            for object in objects {
                context.delete(object)
            }
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Couldn't read the data,. \(error)")
            }
            
        } catch let error as NSError {
            print("Couldn't delete entities \(error)")
        }
    }
    
    
    
}

