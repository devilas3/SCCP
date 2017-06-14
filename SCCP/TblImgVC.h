//
//  TblImgVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 04/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TblImgVC : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *TblImg;
@property (strong,nonatomic) NSString *strID;
- (IBAction)BtnBack:(id)sender;
- (IBAction)BtnNewAddImg:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnNewAddImg;
@property (weak, nonatomic) IBOutlet UIView *BlankView;

@end
