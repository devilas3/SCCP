//
//  SearchVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tblSideView;

@property (weak, nonatomic) IBOutlet UITextField *txtKeyword;
@property (weak, nonatomic) IBOutlet UITextField *txtCommon;
@property (weak, nonatomic) IBOutlet UITextField *txtGenus;

- (IBAction)BtnSearch:(id)sender;

@end
