//
//  ImagesVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 21/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "ImagesVC.h"
#import "ImageCell.h"
#import "DBManager.h"
#import "JTSImageInfo.h"
#import "JTSImageViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ImagesVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

{
    NSInteger indexx;
    UITapGestureRecognizer *tapGesture;
    BOOL Check;
}

@property (strong,nonatomic) NSArray *arrimg;
@property (nonatomic, strong) DBManager *dbManager;
@property (strong, nonatomic) NSMutableArray *arrItem;
@end

@implementation ImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
     indexx = [[[NSUserDefaults standardUserDefaults] objectForKey:@"indexx"] integerValue];

    
    _arrimg =[NSArray arrayWithObjects:@"img_1.png", @"img_1.png",@"img_2.png",@"img_3.png",@"img_4.png", nil];
    
    [self loadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    
//    NSInteger section = [self numberOfSectionsInCollectionView:self.collectionView] - 1;
//    
//    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:indexx inSection:section];
//    
//    
//    [self.collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if(Check == YES){
        
    }
    else{
        
        NSInteger section = [self numberOfSectionsInCollectionView:self.collectionView] - 1;
        
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:indexx inSection:section];
        
        
        [self.collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
    }
    
    
    
//    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:0];
//    NSLog(@"%ld", (long)indexPath.row-1);

//    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
//    
//   [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}




-(void)loadData{
    // Form the query.
    
    
    if([_strType isEqualToString:@"SimilarImage"]){
        
        NSString *query = [NSString stringWithFormat:@"select ImageName, Title , nid from %@ where nid=\'%@\'",_strType,_strID];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        
        if(_arrItem.count == 1 || _arrItem.count == 0){
            
            _BtnNext.hidden = YES;
            _Btnprevious.hidden = YES;
        }
        else{
            
            _BtnNext.hidden = NO;
            _Btnprevious.hidden = NO;
        }

        
        NSLog(@"%@",_arrItem);

    }
    else if([_strType isEqualToString:@"LifeImage"]){
        
        NSString *query = [NSString stringWithFormat:@"select ImageName, Title , nid from %@ where nid=\'%@\'",_strType,_strID];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        
        if(_arrItem.count == 1 || _arrItem.count == 0){
            
            _BtnNext.hidden = YES;
            _Btnprevious.hidden = YES;
        }
        else{
            
            _BtnNext.hidden = NO;
            _Btnprevious.hidden = NO;
        }

        
        NSLog(@"%@",_arrItem);
        
    }
    else if([_strType isEqualToString:@"RangeImage"]){
        
        NSString *query = [NSString stringWithFormat:@"select ImageName, Title , nid from %@ where nid=\'%@\'",_strType,_strID];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        
        if(_arrItem.count == 1 || _arrItem.count == 0){
            
            _BtnNext.hidden = YES;
            _Btnprevious.hidden = YES;
        }
        else{
            
            _BtnNext.hidden = NO;
            _Btnprevious.hidden = NO;
        }

        
        NSLog(@"%@",_arrItem);
        
    }
    else if([_strType isEqualToString:@"ObsImages"]){
        
        NSString *query = [NSString stringWithFormat:@"select * from %@ where Ob_id=\'%@\'",_strType,_strID];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
        
        if(_arrItem.count == 1 || _arrItem.count == 0){
            
            _BtnNext.hidden = YES;
            _Btnprevious.hidden = YES;
        }
        else{
            
            _BtnNext.hidden = NO;
            _Btnprevious.hidden = NO;
        }
        
    }
    else{
            NSString *query = [NSString stringWithFormat:@"select ImageName, Title , nid from TblSpeciesImage where nid=\'%@\'",_strID];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
        
        if(_arrItem.count == 1 || _arrItem.count == 0){
            
            _BtnNext.hidden = YES;
            _Btnprevious.hidden = YES;
        }
        else{
            
            _BtnNext.hidden = NO;
            _Btnprevious.hidden = NO;
        }

    }
    
    
   
}

#pragma CollectioView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_arrItem count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell
    ImageCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell"
                                                                  forIndexPath:indexPath];
    
    
//    CGRect frame = CGRectMake(0.0, 0.0, myCell.frame.size.width, myCell.frame.size.height);
//    frame.origin = [myCell convertPoint:myCell.frame.origin toView:self.view];
    if([_strType isEqualToString:@"ObsImages"]){
        
        NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexPath.row] objectAtIndex:2]];
        myCell.ItemImage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        myCell.Title.text=[[_arrItem objectAtIndex:indexPath.row]objectAtIndex:1];
        

        myCell.ItemImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    else{
        
        NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexPath.row] objectAtIndex:0]];
        myCell.ItemImage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        myCell.Title.text=[[_arrItem objectAtIndex:indexPath.row]objectAtIndex:1];
        
        myCell.ItemImage.contentMode = UIViewContentModeScaleAspectFit;

    }
    
    

    
    //myCell.backgroundColor =[UIColor redColor];
    
    return myCell;
    
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *objCell;
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    
    
    if([_strType isEqualToString:@"ObsImages"]){
        NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexPath.row] objectAtIndex:2]];
        objCell.ItemImage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        imageInfo.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];

        
    }
    else{
         NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexPath.row] objectAtIndex:0]];
        objCell.ItemImage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        imageInfo.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];

    }
   
    
    
    
    
    imageInfo.referenceRect = objCell.ItemImage.frame;
    imageInfo.referenceView = objCell.ItemImage.superview;
    imageInfo.referenceContentMode = objCell.ItemImage.contentMode;
    //imageInfo.referenceCornerRadius = objCell.ItemImage.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
    Check = YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*UIImage *image;
     long row = [indexPath row];
     
     image = [UIImage imageNamed:arrimage1[row]];*/
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    return CGSizeMake(_collectionView.frame.size.width, _collectionView.frame.size.height);
    
}
- (void)scrollViewDidScroll:(UICollectionView *)scrollView
{
//    if (self.lastContentOffset > scrollView.contentOffset.x)
//    {
//        NSLog(@"Scrolling left");
//    }
//    else if (self.lastContentOffset < scrollView.contentOffset.x)
//    {
//        NSLog(@"Scrolling right");
//    }
//    self.lastContentOffset = scrollView.contentOffset.x;
    
}

- (IBAction)BtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)BtnNext:(id)sender {
    
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSLog(@"%lu",(unsigned long)[_arrItem count]);
    
    
    NSInteger Count = [_arrItem count];
    if(Count > indexPath.row+1){
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0];
        NSLog(@"%ld", (long)indexPath.row+1);
        
        
        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }else{
        
    }

}

- (IBAction)Btnprevious:(id)sender {
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    if(indexPath.row == 0)
    {
        
    }
    else{
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:0];
        NSLog(@"%ld", (long)indexPath.row-1);
        
        
        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
