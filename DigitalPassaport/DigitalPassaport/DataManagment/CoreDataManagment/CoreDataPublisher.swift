//
//  CoreDataPublisher.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 1.9.23..
//

import UIKit
import CoreData
import Combine

class CoreDataChangesPublisher<EntityType: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    private let subject = PassthroughSubject<[EntityType], Never>()
    private var fetchedResultsController: NSFetchedResultsController<EntityType>!
    private var sortDescriptor: NSSortDescriptor?
    private var context: NSManagedObjectContext?
    private var predicate: NSPredicate?
    
    init(context: NSManagedObjectContext, sortDescriptor: NSSortDescriptor, predicate: NSPredicate? = nil) {
        super.init()
        self.sortDescriptor = sortDescriptor
        self.context = context
        self.predicate = predicate
        setupFetchedResultController()
    }
    
    private func setupFetchedResultController() {
        let entityName = String(describing: EntityType.self)
        
        guard
            let sortDescriptor = sortDescriptor,
            let context = context,
            NSEntityDescription.entity(forEntityName: entityName, in: context) != nil
        else {
            return
        }
        
        let fetchRequest: NSFetchRequest<EntityType> = NSFetchRequest(entityName: entityName)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch: \(error)")
        }
    }
    
    var changesPublisher: AnyPublisher<[EntityType], Never> {
        subject.eraseToAnyPublisher()
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchedObjects = controller.fetchedObjects as? [EntityType] {
            subject.send(fetchedObjects)
        }
    }
}
