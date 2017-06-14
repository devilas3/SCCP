//
//  SpeciesDetailVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 20/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeciesDetailVC : UIViewController



- (IBAction)BtnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblMaintitle;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *ImageView;
@property (strong,nonatomic) NSMutableDictionary *dicData;
@property (strong,nonatomic) NSString *strID,*strMainTitle;

@property (weak, nonatomic) IBOutlet UIButton *BtnAddFav;
- (IBAction)BtnAddFav:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnRemoveFav;
- (IBAction)BtnRemoveFav:(id)sender;
- (IBAction)BtnPrevious:(id)sender;
- (IBAction)BtnNext:(id)sender;
- (IBAction)BtnShare:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *BtnNext;
@property (strong, nonatomic) IBOutlet UIButton *BtnPrevious;


@end
