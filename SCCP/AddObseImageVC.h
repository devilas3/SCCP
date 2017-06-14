//
//  AddObseImageVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 03/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddObseImageVC : UIViewController
- (IBAction)BtnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMainPage;
@property (weak, nonatomic) IBOutlet UIButton *BtnAnotherImage;

- (IBAction)BtnAnotherImage:(id)sender;
- (IBAction)BtnAddImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnAddImage;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIButton *BtnSave;

- (IBAction)BtnSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnEdit;
- (IBAction)BtnEdit:(id)sender;


@property(strong,nonatomic) NSString *strType,*strID,*ItemID;



@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
