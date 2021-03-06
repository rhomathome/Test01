//
//  AppDelegate.h
//  TestProject
//
//  Created by Ron Hom on 11/29/15.
//  Copyright © 2015 OllieCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;




- (NSURL *)applicationDocumentsDirectory; // nice to have to reference files for core data
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

