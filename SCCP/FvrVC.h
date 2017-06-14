//
//  FvrVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FvrVC : UIViewController


@property (strong, nonatomic) IBOutlet UITableView *tblSideView;
@property (weak, nonatomic) IBOutlet UITableView *TblFvr;
@property (weak, nonatomic) IBOutlet UITableView *TblObser;
@property (weak, nonatomic) IBOutlet UIButton *BtnFvrSpe;
- (IBAction)BtnFvrSpe:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnFvrObs;
- (IBAction)BtnFvrObs:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *BlankView;
@property (weak, nonatomic) IBOutlet UILabel *lblmsg;

@end
