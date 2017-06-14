//
//  ViewController.h
//  SCCP
//
//  Created by Jimit Bagadiya on 02/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@class CTCheckbox;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblimg;
@property(strong,nonatomic)DBManager *dbManager;
@property (weak, nonatomic) IBOutlet UIWebView *txtWebview;
@end

