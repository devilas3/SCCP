//
//  DetailVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 24/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVC : UIViewController
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbMainTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtTextView;

@property (weak, nonatomic) IBOutlet UIWebView *txtWebView;

@property (strong,nonatomic) NSMutableDictionary *dicData;
@property (strong,nonatomic) NSString *strID,*strMainTitle,*strType,*strTbl;

@property (weak, nonatomic) IBOutlet UIView *StatusView;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *lblGenus;
@property (weak, nonatomic) IBOutlet UILabel *lblspecies;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl1txt;
@property (weak, nonatomic) IBOutlet UILabel *lbl2txt;
@property (weak, nonatomic) IBOutlet UILabel *lbl3txt;
@property (weak, nonatomic) IBOutlet UILabel *lbl4txt;


@property (weak, nonatomic) IBOutlet UIView *TxtView;
@property (weak, nonatomic) IBOutlet UIView *ImageView;
- (IBAction)BtnNext:(id)sender;
- (IBAction)BtnPrevious:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *BtnNext;
@property (strong, nonatomic) IBOutlet UIButton *BtnPrevious;

@property (weak, nonatomic) IBOutlet UIWebView *ImgWebText;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
