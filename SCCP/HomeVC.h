//
//  HomeVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 02/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@class CTCheckbox;

@interface HomeVC : UIViewController<NSURLConnectionDelegate>
{
    NSData *jsonData1;
    NSMutableString *mutableJsonString;
    NSMutableDictionary *dicType,*dicallData,*dicAllImg,*dicImg,*dicSimilarImg,*diclifeImg,*dicRangeImg;
    NSArray *arrCount;
    NSMutableArray *arrData,*arrAllImg,*arrSimAllImg,*arrlifeImg,*arrRangeImg;
    NSInteger idNo;
    NSString *strID,*title,*genus,*species,*globalStatus,*provincialStatus,*saraStatus,*bclistStatus,*images,*similarValue,*similarImages,*ecology,*threats,*conservation,*subspecies,*description,*sources,*credits,*strAllImg,*Habitat,*diet,*life_cycle,*Range;
    NSString *strImage,*strImgTitle,*strimageName;
    NSString *strSimImage,*strSimImgTitle,*strSimimageName;
    NSString *strlifeImage,*strlifeImgTitle,*strlifeimageName;
    NSString *strRangeImage,*strRangeImgTitle,*strRangeimageName;
    NSString *strSub;
    
}
@property(strong,nonatomic)DBManager *dbManager;

@property (weak, nonatomic) IBOutlet UIView *SyncView;

@property (weak, nonatomic) IBOutlet UIView *SepciesView;

@property (strong,nonatomic) NSString *strType;

@property (weak, nonatomic) IBOutlet UIButton *BtnSyncLatest;
- (IBAction)BtnSyncLatest:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnReSync;
- (IBAction)btnReSync:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblLatestDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAllDate;

@property (weak, nonatomic) IBOutlet UIView *LoadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Activity;
@property (weak, nonatomic) IBOutlet UIView *LoadingMSgView;
@property (weak, nonatomic) IBOutlet UILabel *LblPerce;

@end
