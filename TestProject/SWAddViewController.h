//
//  SWAddViewController.h
//  TestProject
//
//  Created by Ron Hom on 4/3/16.
//  Copyright © 2016 OllieCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface SWAddViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *Name;
@property (strong, nonatomic) IBOutlet UITextField *Faction;
@property (strong, nonatomic) IBOutlet UITextField *Description;
@property (strong, nonatomic) IBOutlet UITextField *Weapon;
@property (strong, nonatomic) IBOutlet UITextField *Race;
- (IBAction)Save:(UIBarButtonItem *)sender;

// !!!!!!
//row to update
@property (strong, nonatomic) NSManagedObject *Seque_selectedRow;

//seque data
@property (strong, nonatomic) NSArray *SequeData;

@end
