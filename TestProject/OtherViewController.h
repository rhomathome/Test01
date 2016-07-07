//
//  OtherViewController.h
//  TestProject
//
//  Created by Ron Hom on 11/29/15.
//  Copyright © 2015 OllieCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherViewController : UIViewController
- (IBAction)buttonDoSomething:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextField;
- (IBAction)testCoreData:(id)sender;
- (IBAction)loadData:(UIButton *)sender;
- (IBAction)GetData:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *Input;
- (IBAction)getNextCharID:(id)sender;
- (IBAction)TheRealGetNextCharID:(UIButton *)sender;

@end
