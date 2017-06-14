//
//  ImagesVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 21/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesVC : UIViewController
- (IBAction)BtnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) NSString *strID;
- (IBAction)BtnNext:(id)sender;
- (IBAction)Btnprevious:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *BtnNext;
@property (strong, nonatomic) IBOutlet UIButton *Btnprevious;

@property (strong,nonatomic) NSString *strType;

@end
