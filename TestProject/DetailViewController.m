//
//  DetailViewController.m
//  TestProject
//
//  Created by Ron Hom on 1/10/16.
//  Copyright © 2016 OllieCo. All rights reserved.
//

#import "DetailViewController.h"
#import <CoreData/CoreData.h>
#import "SWAddViewController.h"


@interface DetailViewController ()

@property (strong) NSMutableArray *fetchResults;



@end

@implementation DetailViewController

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
    
    //NSString *msg = [NSString stringWithFormat:@"You have selected row number %@", _SequeData[0]];
    //UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Entity selected" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //[alert show];
    
    NSLog(@"OK!!!");
    NSLog(@"Segue Data: %@", _SequeData[0]);
    
    
    NSString *image;
    
       /*if ([_SequeData[0]  isEqualToString:@"0"]) {
        image = @"San Holo.jpg";
        self.Name.text = @"San Holo";
        self.Faction.text = @"Mercenary (Turned to be allied with the Rebels)";
        self.Description.text = @"Super badass";
        self.Race.text = @"Human";
        self.Weapon.text = @"Single Blaster";
    }
    else if ([_SequeData[0] isEqualToString:@"1"]) {
        image = @"Obi Juan Kenobi.jpg";
        self.Name.text = @"Obi Juan Kenobi";
        self.Faction.text = @"Republic Jedi";
        self.Description.text = @"Wise and kinda badass";
        self.Race.text = @"Human";
        self.Weapon.text = @"Blue Lightsaber";
    }
    else if ([_SequeData[0] isEqualToString:@"2"]) {
        image = @"Finn.jpg";
        self.Name.text = @"Finn";
        self.Faction.text = @"Resistence (Used to be with the First Order)";
        self.Description.text = @"Not at all badass";
        self.Race.text = @"Human";
        self.Weapon.text = @"Rifle (used a Lightsaber once)";
    }*/
    //self.CharacterImage.image = [UIImage imageNamed:image];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SWChar"];
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSString *input = [NSString stringWithFormat:@"(charid == %@)", _SequeData[0] ];
    NSPredicate *pred = [NSPredicate predicateWithFormat:input];
    
    [fetchRequest setPredicate:pred];
    
    self.fetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"Number of Records Found IN DETAIL VIEW CONTROLLER: %lu", (unsigned long)[self.fetchResults count]);
    NSLog(@"Retrieved record: %@", self.fetchResults[0]);
    NSLog(@"Char ID: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"charid"]);
    NSLog(@"Name: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"name"]);
    NSLog(@"Faction: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"faction"]);
    NSLog(@"Weapon: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"weapon"]);
    NSLog(@"Race: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"race"]);
    NSLog(@"Description: %@", [[self.fetchResults objectAtIndex:0] valueForKey:@"desc"]);
    
    self.Name.text = [[self.fetchResults objectAtIndex:0] valueForKey:@"name"];
    self.Faction.text = [[self.fetchResults objectAtIndex:0] valueForKey:@"faction"];
    self.Description.text = [[self.fetchResults objectAtIndex:0] valueForKey:@"desc"];
    self.Race.text = [[self.fetchResults objectAtIndex:0] valueForKey:@"race"];
    self.Weapon.text = [[self.fetchResults objectAtIndex:0] valueForKey:@"weapon"];
    

    
    
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

//***** Edit detail data ******
- (IBAction)edit:(id)sender {
    
 
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        
    if ([[segue identifier] isEqualToString:@"ShowUpdate"]) {
        
        SWAddViewController *swaddviewcontroller = [segue destinationViewController];
        
       // NSLog(@"Seque to Update Item (List ID): %@", _SequeData[1]);
       // NSLog(@"Seque to Update Item (Item Name): %@", _SequeData[0]);
        
        
        swaddviewcontroller.SequeData = @[@"Update",self.Name.text, self.Faction.text, self.Description.text, self.Race.text, self.Weapon.text];
       // swaddviewcontroller.Seque_listitem = _Selectedlistitem;
     
        //!!!!
        //pass the point to the row to update
        //swaddviewcontroller.Seque_selectedRow = _Seque_selectedRow;
        
        swaddviewcontroller.Seque_selectedRow = [self.fetchResults objectAtIndex:0];
    }
    
    
    
}


@end
