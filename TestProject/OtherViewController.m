//
//  OtherViewController.m
//  TestProject
//
//  Created by Ron Hom on 11/29/15.
//  Copyright © 2015 OllieCo. All rights reserved.
//

#import "OtherViewController.h"

//!!!!!!!!!!!!!!!!!!!!!!!!!!
#import <CoreData/CoreData.h>

@interface OtherViewController ()


//!!!!!!!!!!!!!!!!!!!!!!!!!!
@property (strong) NSMutableArray *fetchResults;


@end

@implementation OtherViewController

//!!!!!!!!!!!!!!!!!!!!!!!!!!
//***********************************************************************
// Setup ManagedObjectContext to access core data
//***********************************************************************
- (NSManagedObjectContext *)managedObjectContext
{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonDoSomething:(id)sender {
    
    NSString *msg = [NSString stringWithFormat:@"IT WERKKKED: %@", self.TextField.text];
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Check" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    self.TextField.text = @"Something";
    
}
- (IBAction)testCoreData:(id)sender {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
   
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Foobar"];
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(recId == 32)"];
    
    [fetchRequest setPredicate:pred];
    
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    NSLog(@"Current Users: %lu", (unsigned long)[self.fetchResults count]);
    NSLog(@"Retrieved record: %@", self.fetchResults[0]);
    NSLog(@"Record ID: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"recId"]);
    NSLog(@"Name: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"name"]);
    NSLog(@"Position: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"type"]);
    
    
}

- (IBAction)loadData:(UIButton *)sender {
    
    // setup database connection
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    // set up badges
    NSManagedObject *SWChar = [NSEntityDescription insertNewObjectForEntityForName:@"SWChar" inManagedObjectContext:context];
    
    
    
    [SWChar setValue:[NSNumber numberWithInteger:0] forKey:@"charid"];
    [SWChar setValue:[NSString stringWithFormat:@"Luke Skywalker"] forKey:@"name"];
    [SWChar setValue:[NSString stringWithFormat:@"Description"] forKey:@"desc"];
    [SWChar setValue:[NSString stringWithFormat:@"Rebel"] forKey:@"faction"];
    [SWChar setValue:[NSString stringWithFormat:@"Blue Lightsaber"] forKey:@"weapon"];
    [SWChar setValue:[NSString stringWithFormat:@"Human"] forKey:@"race"];
    
    NSManagedObject *SWChar01 = [NSEntityDescription insertNewObjectForEntityForName:@"SWChar" inManagedObjectContext:context];
    [SWChar01 setValue:[NSNumber numberWithInteger:1] forKey:@"charid"];
    [SWChar01 setValue:[NSString stringWithFormat:@"Han Solo"] forKey:@"name"];
    [SWChar01 setValue:[NSString stringWithFormat:@"Description"] forKey:@"desc"];
    [SWChar01 setValue:[NSString stringWithFormat:@"Rebel"] forKey:@"faction"];
    [SWChar01 setValue:[NSString stringWithFormat:@"Blaster"] forKey:@"weapon"];
    [SWChar01 setValue:[NSString stringWithFormat:@"Human"] forKey:@"race"];
    
    NSManagedObject *SWChar02 = [NSEntityDescription insertNewObjectForEntityForName:@"SWChar" inManagedObjectContext:context];
    [SWChar02 setValue:[NSNumber numberWithInteger:2] forKey:@"charid"];
    [SWChar02 setValue:[NSString stringWithFormat:@"BB-8"] forKey:@"name"];
    [SWChar02 setValue:[NSString stringWithFormat:@"Description"] forKey:@"desc"];
    [SWChar02 setValue:[NSString stringWithFormat:@"Rebel"] forKey:@"faction"];
    [SWChar02 setValue:[NSString stringWithFormat:@"Everything"] forKey:@"weapon"];
    [SWChar02 setValue:[NSString stringWithFormat:@"Droid"] forKey:@"race"];
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SWChar"];
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(charid == 1)"];
    
    //[fetchRequest setPredicate:pred];
    
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"Number of Records Found: %lu", (unsigned long)[self.fetchResults count]);
    NSLog(@"Retrieved record: %@", self.fetchResults[0]);
    NSLog(@"Char ID: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"charid"]);
    NSLog(@"Name: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"name"]);
    NSLog(@"Faction: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"faction"]);
    NSLog(@"Weapon: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"weapon"]);
    NSLog(@"Race: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"race"]);
    NSLog(@"Description: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"desc"]);
    
}

- (IBAction)GetData:(UIButton *)sender {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SWChar"];
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSString *input = [NSString stringWithFormat:@"(charid == %@)", self.Input.text ];
    NSPredicate *pred = [NSPredicate predicateWithFormat:input];
    
    [fetchRequest setPredicate:pred];
    
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"Number of Records Found: %lu", (unsigned long)[self.fetchResults count]);
    NSLog(@"Retrieved record: %@", self.fetchResults[0]);
    NSLog(@"Char ID: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"charid"]);
    NSLog(@"Name: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"name"]);
    NSLog(@"Faction: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"faction"]);
    NSLog(@"Weapon: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"weapon"]);
    NSLog(@"Race: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"race"]);
    NSLog(@"Description: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"desc"]);

}
- (IBAction)getNextCharID:(id)sender {
    
    NSLog(@"Next Char ID: %@",[self goGetIt]);
    
    
}

- (IBAction)TheRealGetNextCharID:(UIButton *)sender {
    
    NSLog(@"Next Char ID: %@",[self TheRealGoGetIt]);
    
}

- (NSString *) TheRealGoGetIt {
    //establish database connection
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SWChar"];
    //self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"charid"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    //get the thingy from the datathingy
    NSLog(@"Number of Records Found: %lu", (unsigned long)[self.fetchResults count]);
    
    NSLog(@"*MAX Char ID: %@", [[self.fetchResults objectAtIndex:[self.fetchResults count]-1] valueForKey:@"charid"]);
    
    NSInteger i;
    
    NSString *nextCharID  =[[self.fetchResults objectAtIndex:[self.fetchResults count]-1] valueForKey:@"charid"];
    
    //increment the charid
    i = [nextCharID integerValue];
    
    i = i+1;
    
    nextCharID = [NSString stringWithFormat:@"%ld", (long)i];

    //return it BOIS
    return nextCharID;
    
}



- (NSString *) goGetIt {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SWChar"];
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"Number of Records Found: %lu", (unsigned long)[self.fetchResults count]);
    
    NSLog(@"MAX Char ID: %@", [[self.fetchResults objectAtIndex:[self.fetchResults count]-1] valueForKey:@"charid"]);
    
    NSInteger i;
    
    NSString *nextCharID  =[[self.fetchResults objectAtIndex:[self.fetchResults count]-1] valueForKey:@"charid"];

    i = [nextCharID integerValue];
    
    i = i+1;
    
    nextCharID = [NSString stringWithFormat:@"%ld", (long)i];
    
    
    return nextCharID;
    
}


@end
