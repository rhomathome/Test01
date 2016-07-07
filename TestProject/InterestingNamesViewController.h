//
//  InterestingNamesViewController.h
//  TestProject
//
//  Created by Ron Hom on 12/23/15.
//  Copyright © 2015 OllieCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestingNamesViewController : UIViewController 
@property (nonatomic, strong) NSMutableArray *InterestingNames;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)done_back:(id)sender;


@end