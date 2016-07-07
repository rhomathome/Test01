//
//  DetailViewController.h
//  TestProject
//
//  Created by Ron Hom on 1/10/16.
//  Copyright © 2016 OllieCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) NSArray *SequeData;
@property (strong, nonatomic) IBOutlet UIImageView *CharacterImage;
@property (strong, nonatomic) IBOutlet UILabel *Name;
@property (strong, nonatomic) IBOutlet UILabel *Faction;
@property (strong, nonatomic) IBOutlet UILabel *Description;
@property (strong, nonatomic) IBOutlet UILabel *Weapon;
@property (strong, nonatomic) IBOutlet UILabel *Race;


// !!!!!!
//row to update
@property (strong, nonatomic) NSManagedObject *Seque_selectedRow;

- (IBAction)edit:(id)sender;

@end
