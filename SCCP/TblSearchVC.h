//
//  TblSearchVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TblSearchVC : UIViewController

@property (strong,nonatomic) NSString *strType,*strKey,*StrItem,*strTypeSub,*strKey2,*strType2,*strKey3,*strType3;
@property (weak, nonatomic) IBOutlet UITableView *TblSearch;
@property (weak, nonatomic) IBOutlet UIButton *BtnBack;
- (IBAction)BtnBack:(id)sender;

@end
