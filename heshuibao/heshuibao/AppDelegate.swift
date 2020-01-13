//
//  AppDelegate.swift
//  heshuibao
//
//  Created by ST on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // coredata propties
    lazy var managedObjectModel: NSManagedObjectModel = {
            let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")
            let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL!)
            return managedObjectModel!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
        let sqliteURL = documentDir.appendingPathComponent("Model.sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteURL, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: Any]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as Any?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as Any?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 6666, userInfo: dict)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return persistentStoreCoordinator
    }()

    lazy var documentDir: URL = {
        let documentDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        return documentDir!
    }()
    
    lazy var context: NSManagedObjectContext = {
        let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()


    //
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        AppViewModel.checkDateAddRecord()
        window?.rootViewController = RootViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    //
    func applicationWillEnterForeground(_ application: UIApplication) {
        AppViewModel.checkDateAddRecord()
    }


}

