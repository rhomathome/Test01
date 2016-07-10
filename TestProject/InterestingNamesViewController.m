//
//  InterestingNamesViewController.m
//  TestProject
//
//  Created by Ron Hom on 12/23/15.
//  Copyright © 2015 OllieCo. All rights reserved.
//

//***************************************************************************
//
// This is the main view controller the user will after starting the app
//
//***************************************************************************


#import "InterestingNamesViewController.h"
#import "NameCell.h"
#import "DetailViewController.h"
#import <CoreData/CoreData.h>

@interface InterestingNamesViewController ()

@property (strong) NSMutableArray *SWNames;

// !!!!!!
@property (strong, nonatomic) NSManagedObject *selectedSWChar;



@end

@implementation InterestingNamesViewController

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

//***********************************************************************
// Loads the View when the view is loaded?
//***********************************************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //**************************** For Class *************************************************
    
    //set title of screen to the List Name
    [self setTitle:@"Star Wars Characters"];
    
    //add Edit button to Navigation button bar
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.editButtonItem setTintColor: [UIColor colorWithRed:0 green:255 blue:0 alpha:1]];
    
    //allow rows to be selected during editing
    self.tableView.allowsSelectionDuringEditing = YES;
    
    //change color of table view separator lines
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0 green:255 blue:0 alpha:1]];
    
    
    
    
    
    _InterestingNames = [[NSMutableArray alloc] init];
    [_InterestingNames addObject:@"San Holo"];
    [_InterestingNames addObject:@"Obi Juan Kenobi"];
    [_InterestingNames addObject:@"Black-Stormtrooper-Who-Defected-For-No-Reason:/"];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SWChar"];
    self.SWNames = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //NSString *input = [NSString stringWithFormat:@"(charid == %@)", self.Input.text ];
    //NSPredicate *pred = [NSPredicate predicateWithFormat:input];
    
    //[fetchRequest setPredicate:pred];
    
    //self.SWNames = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"****************VIEW DID LOAD***********************");
    NSLog(@"Number of Records Found: %lu", (unsigned long)[self.SWNames count]);
    NSLog(@"Retrieved record: %@", self.SWNames[0]);
    NSLog(@"Char ID: %@", [[self.SWNames objectAtIndex:0] valueForKey:@"charid"]);
    NSLog(@"Name: %@", [[self.SWNames objectAtIndex:0] valueForKey:@"name"]);
    NSLog(@"Faction: %@", [[self.SWNames objectAtIndex:0] valueForKey:@"faction"]);
    NSLog(@"Weapon: %@", [[self.SWNames objectAtIndex:0] valueForKey:@"weapon"]);
    NSLog(@"Race: %@", [[self.SWNames objectAtIndex:0] valueForKey:@"race"]);
    NSLog(@"Description: %@", [[self.SWNames objectAtIndex:0] valueForKey:@"desc"]);
    
}

//***********************************************************************
// Executes everytime the view is shown
//***********************************************************************
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    
    
    
    
    
    
    
    [self loadTableView];
}

//***********************************************************************
// This method retrieves data rows from the SWChar table and reloads/refreshs the table view
//***********************************************************************
- (void)loadTableView
{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SWChar"];
    self.SWNames = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

    [self.tableView reloadData];
    
    
}


//*******************************************
// Load rows
//*******************************************
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NameCell";
    NameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    int row = [indexPath row];
    
    //cell.Name.text= _InterestingNames[row];
    
    NSManagedObject *listitem = [self.SWNames objectAtIndex:indexPath.row];
    
    [cell.Name setText:[NSString stringWithFormat:@"%@", [listitem valueForKey:@"name"]]];
    
    //NSString *checkmark = _Checked[row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    /*
     
     if ([_Checked[row] isEqualToString: @"Y"]) {
     
     cell.accessoryType = UITableViewCellAccessoryCheckmark;
     
     } else {
     
     cell.accessoryType = UITableViewCellAccessoryNone;
     
     }
     
     */
    
    
    return cell;
}
//*******************************************
// User Select-a-row
//*******************************************
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //!!!!!!
    NSManagedObject *selectedRow = [self.SWNames objectAtIndex:indexPath.row];
    // save selected list item to pass to Update view contoller
    _selectedSWChar = selectedRow;
    
    NSLog(@"******SELECTED ROW: %@",[_selectedSWChar valueForKey:@"name"]);
    
    
    
    //!!!!!!!!!
    //NSString *nameSelected = [_InterestingNames objectAtIndex:indexPath.row];
    
    //NSString *msg = [NSString stringWithFormat:@"You have selected %@", nameSelected];
    //UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Player selected" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //[alert show];
    
    //!!!!!!!
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //[self performSegueWithIdentifier:@"ShowDetail" sender:cell];
}

//*******************************************
// Pass Data to Detail View Controller
//*******************************************

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"ShowDetail"]) {
        
        DetailViewController *detailviewcontroller = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        
        int row = [myIndexPath row];
        
       // NSString *selectedRow = [NSString stringWithFormat:@"%d", row];
        
        NSString *selectedRow = [NSString stringWithFormat:@"%@", [[self.SWNames objectAtIndex:row] valueForKey:@"charid"] ];
        
        NSLog(@"SELECTED ROW Char ID: %@", selectedRow);
       // NSLog(@"SELECTED ROW Char ID: %@", [[self.SWNames objectAtIndex:row] valueForKey:@"charid"]);
        
        
        detailviewcontroller.SequeData = @[selectedRow];
     
        //!!!!
        detailviewcontroller.Seque_selectedRow = _selectedSWChar;
        
    }
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.SWNames.count;


}

//**************** For Class **********************
// ***********************************
// Setup EDIT Button
// ***********************************
- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
}

//***********************************************************************
//  Delete a row
//***********************************************************************
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.SWNames objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.SWNames removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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

- (IBAction)done_back:(id)sender {
    
      [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
