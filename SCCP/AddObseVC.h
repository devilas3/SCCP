//
//  AddObseVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface AddObseVC : UIViewController
- (IBAction)BtnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMainTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@property (weak, nonatomic) IBOutlet UITextField *txtLoca;
@property (weak, nonatomic) IBOutlet UILabel *lblloca;
@property (weak, nonatomic) IBOutlet UITextView *txtDesc;
@property (weak, nonatomic) IBOutlet UIView *txtTextView;
- (IBAction)BtnContinue:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnContinue;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIView *AddView;

@property (strong,nonatomic) NSString *strType,*strMainTitle;
@property (weak, nonatomic) IBOutlet UIView *OBDeatilView;
- (IBAction)BtnAddFav:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnAddFav;
@property (weak, nonatomic) IBOutlet UIButton *BtnRmoveFvr;
- (IBAction)BtnRmoveFvr:(id)sender;
@property (strong,nonatomic) NSString *strID;
@property (weak, nonatomic) IBOutlet UIScrollView *ObScroll;
@property (weak, nonatomic) IBOutlet UILabel *lblObTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *OBcollectionView;
- (IBAction)BtnNext:(id)sender;
- (IBAction)BtnPrevious:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *BtnNext;
@property (strong, nonatomic) IBOutlet UIButton *BtnPrevious;

- (IBAction)BtnEditObser:(id)sender;
- (IBAction)BtnEditObImage:(id)sender;
- (IBAction)BtnObDelete:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lblObDate;
@property (weak, nonatomic) IBOutlet UILabel *lblObLocation;
@property (weak, nonatomic) IBOutlet UITextView *txtObDesc;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *Scrollview;
- (IBAction)btnEditOb:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEditOb;

@property (strong,nonatomic) NSString *ChkPage;



@property (strong, nonatomic) IBOutlet UILabel *lblNote;

@end
