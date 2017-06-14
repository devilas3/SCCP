//
//  AboutVC.h
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutVC : UIViewController<UIWebViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblSideView;
@property (weak, nonatomic) IBOutlet UIWebView *txtWebView;
@property (strong,nonatomic) NSString *strType;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *TxtTextView;
@property (weak, nonatomic) IBOutlet UIView *CollView;

@property (weak, nonatomic) IBOutlet UILabel *titleHeader;

@property (weak, nonatomic) IBOutlet UIWebView *txtWebView2;


@end
