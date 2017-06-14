  //
//  ViewController.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "ViewController.h"
#import "CTCheckbox.h"
#import "ImageCell.h"
#import "JTSImageInfo.h"
#import "JTSImageViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewController (){
    
    
    NSMutableData *responseData;

}


@property (strong, nonatomic) NSArray *arrWild;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (strong, nonatomic) IBOutlet UIImageView *logoImg;

@property (weak, nonatomic) IBOutlet UIView *SecondView;

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet CTCheckbox *check;
@property (strong, nonatomic) IBOutlet UIButton *btnSkip;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _arrWild=[NSArray arrayWithObjects:@"bird.png",@"small_owl.png",@"large_owl.png",@"fish.png",nil];
    
   
    
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];

  //  [self dataPlist];
    
    
    
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"IsTick"];
    
    if([str isEqualToString:@"YES"]){
        
        _SecondView.hidden = YES;
        [self performSelector:@selector(btnHomePage:) withObject:_mainView afterDelay:2.0];
    }
    else{
        
        [self performSelector:@selector(hideSplash:) withObject:_mainView afterDelay:2.0];
        
        
        [self.check addTarget:self action:@selector(checkboxDidChange:) forControlEvents:UIControlEventValueChanged];
        self.check.textLabel.text = @"Don't show again";
        [self.check setColor:[UIColor blackColor] forControlState:UIControlStateNormal];
        [self.check setColor:[UIColor redColor] forControlState:UIControlStateDisabled];
        self.check.textLabel.textAlignment = NSTextAlignmentCenter;
        [self checkboxDidChange:self.check];
        
        
        _SecondView.hidden = YES;
        
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
   
    [self AllJsonResponse];
//    NSString *str = [[NSUserDefaults  standardUserDefaults] objectForKey:@"IsSavedWelcome"];
//    
//    if([str isEqualToString: @"YES"]){
//        
//        [self GetWelcome];
//    }
//    else{
//        
//        [self AllJsonResponse];
//    }
//    
    
}
- (void)checkboxDidChange:(CTCheckbox *)checkbox
{
    if (checkbox.checked) {
        NSLog(@"checked:");
        
        
        NSString *strSave=@"YES";
        [[NSUserDefaults  standardUserDefaults]setObject:strSave forKey:@"IsTick"];
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"IsTick"]);
        
    } else {
        NSLog(@"Not checked:");

        NSString *strSave=@"NO";
        [[NSUserDefaults  standardUserDefaults]setObject:strSave forKey:@"IsTick"];

        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"IsTick"]);
    }
}
-(void)hideSplash:(id)object
{
    _SecondView.hidden= NO;
    _collectionView.hidden = YES;
    _pageControl.hidden = YES;
    _lblimg.hidden = YES;
    _btnSkip.hidden = NO;
    _check.hidden= NO;
    
}

#pragma CollectioView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_arrWild count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell
    ImageCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cellmain"
                                                                  forIndexPath:indexPath];
    
    
    //    CGRect frame = CGRectMake(0.0, 0.0, myCell.frame.size.width, myCell.frame.size.height);
    //    frame.origin = [myCell convertPoint:myCell.frame.origin toView:self.view];
    
    
    myCell.ItemImage.image=[UIImage imageNamed:[_arrWild objectAtIndex:indexPath.row]];
    myCell.ItemImage.contentMode = UIViewContentModeScaleAspectFit;
    
    //myCell.backgroundColor = [UIColor redColor];
    
    //   indexPath1 = [self.collectionView indexPathForCell:myCell];
    
    return myCell;
    
}

#pragma LOADAPI AND CHECK INTERNET COONECTION

-(void)AllJsonResponse
{
    
        
        responseData=[[NSMutableData alloc]init];
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:@"http://sccp.ca/mobileapp/SyncDatabase.php"]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [self ApiSaveData];
    
    
}

-(void)ApiSaveData{
    
    
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
    
    
#pragma ABOUT US APP
    
    NSArray *arrAbout=[JSON objectForKey:@"pages"];
    NSLog(@"%@",arrAbout);
    
    NSString *strWelcome=[[arrAbout valueForKey:@"body"]objectAtIndex:5];
    NSLog(@"%@",strWelcome);
    
    
    [[NSUserDefaults  standardUserDefaults]setObject:strWelcome forKey:@"Welcome"];
    
    [self GetWelcome];
    
    NSString *strSave=@"YES";
    [[NSUserDefaults  standardUserDefaults]setObject:strSave forKey:@"IsSavedWelcome"];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    
    
    [self GetWelcome];
    
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Welcome"];
    
    if(str.length == 0 || [str isEqualToString:@""] || str == nil){
        
        
        NSLog(@"%@", [NSString stringWithFormat:@"Connection failed: %@", [error description]]);
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"SCCP" message:@"The network connection was lost.Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt show];
        
    }
    
    

}

-(void)GetWelcome{
    
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Welcome"];
    
    NSString *htmlString =[NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='5'>%@", str];
    
    
    
    [_txtWebview loadHTMLString:htmlString baseURL:nil];

    
}
#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *objCell;
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    
    NSString *strImg = [_arrWild objectAtIndex:indexPath.row];
    
    imageInfo.image = [UIImage imageNamed:strImg];
    
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
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    return CGSizeMake(frame.size.width-20, _collectionView.frame.size.height);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _collectionView.frame.size.width;
    float currentPage = _collectionView.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f))
    {
        _pageControl.currentPage = currentPage + 1;
    }
    else
    {
        _pageControl.currentPage = currentPage;
    }
    
    NSLog(@"Page Number : %ld", (long)_pageControl.currentPage);
}

- (IBAction)btnHomePage:(id)sender {
    
    
    [self performSegueWithIdentifier:@"home" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
