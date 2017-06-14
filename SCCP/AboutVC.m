//
//  AboutVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "AboutVC.h"
#import "DBManager.h"
#import "SpeciesCell.h"
#import "HomeVC.h"
#import "FvrVC.h"
#import "ObserVC.h"
#import "SearchVC.h"
#import "ImageCell.h"
#import "JTSImageInfo.h"
#import "JTSImageViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SideCell.h"


@interface AboutVC (){
    
    BOOL isSlide;
    BOOL isShown;
    
    
}

@property(strong,nonatomic)DBManager *dbManager;

@property(strong,nonatomic)NSArray *arrName,*arrImg,*arrWild;




@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    _arrName =[NSArray arrayWithObjects:@"About SCCP",@"Species",@"Search Species",@"Wildlife Tips",@"Amphibian ID Tips",@"Snail ID Tips",@"Conservation Status",@"My Observations",@"My Favourites",@"Sync",@"How To Use",@"Terms of Use",@"Sponsors", nil];
    _arrImg =[NSArray arrayWithObjects:@"About",@"Species",@"Search",@"WildLife",@"Amphibian",@"Snail",@"Conservation",@"Observation",@"favourite",@"Sync",@"HowToUse",@"TermsOfUse",@"Sponsors", nil];
    
    _arrWild=[NSArray arrayWithObjects:@"bird.png",@"small_owl.png",@"large_owl.png",@"fish.png",@"mammal.png",@"invertebrate.png", nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
//    [[NSUserDefaults  standardUserDefaults]setObject:strAbout forKey:@"AboutUs"];
//    [[NSUserDefaults  standardUserDefaults]setObject:strHowToUse forKey:@"HowToUse"];
//    [[NSUserDefaults  standardUserDefaults]setObject:strCon forKey:@"Conservation"];
//    [[NSUserDefaults  standardUserDefaults]setObject:strSponser forKey:@"Sponsers"];
//    [[NSUserDefaults  standardUserDefaults]setObject:strTerms forKey:@"Terms"];
//    [[NSUserDefaults  standardUserDefaults]setObject:stramphibian forKey:@"Amphibian"];
//    [[NSUserDefaults  standardUserDefaults]setObject:strsnail forKey:@"Snail"];
 
    [self reloadPage];
}

-(void)reloadPage{
    
    if([_strType isEqualToString:@"AboutUs"]){
        
        _titleHeader.text=@"About SCCP";
        
        _txtWebView.hidden= NO;
        _txtWebView2.hidden= YES;
        _TxtTextView.hidden=NO;
        _CollView.hidden = YES;
    
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"AboutUs"];
        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='12'>%@", str];

        
        [_txtWebView loadHTMLString:str baseURL:nil];
        
    }
    else if([_strType isEqualToString:@"HowToUse"]){
        
        _titleHeader.text=@"How To Use";
        
        _TxtTextView.hidden=NO;
        _CollView.hidden = YES;
        
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"HowToUse"];
        NSString *strBaseurl =@"http://www.sccp.ca/";
        
       // NSString *htmlString = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue-Thin;font-size:100\">%@</span>",str];
        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"[NSString stringWithFormat:@"<span style=\"font-family: YOUR_FONT_NAME; font-size: SIZE\">%@</span>%@", str];
        
        _txtWebView.hidden= NO;
        _txtWebView2.hidden = YES;
        
        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
        
        [self viewDidLoad];
    }
    else if([_strType isEqualToString:@"Conservation"]){
        
        _titleHeader.text=@"Conservation Status";
        
        _txtWebView2.hidden = YES;
        _txtWebView.hidden= NO;
        _TxtTextView.hidden=NO;
        _CollView.hidden = YES;
        
        NSString *strBaseurl =@"http://www.sccp.ca/";
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Conservation"];
        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='5.5'>%@", str];

        
        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
    }
    else if([_strType isEqualToString:@"Sponsers"]){
        
        _titleHeader.text=@"Sponsors";
        
        _txtWebView.hidden= NO;
        _txtWebView2.hidden = YES;
        _TxtTextView.hidden=NO;
        _CollView.hidden = YES;
        
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Sponsers"];
        
        NSString *strBaseurl =@"http://www.sccp.ca/";
//        
//        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
        
        
        
//        NSArray* Array = [str componentsSeparatedByString: @"src="];
//        
//        NSLog(@"%@",Array);
//        NSString *temp=[Array objectAtIndex:1];
//        
//        NSArray* Array2 = [temp componentsSeparatedByString: @" "];
//        
//        NSLog(@"%@",[Array2 objectAtIndex:0]);
//        
//        NSString *temp2=[Array2 objectAtIndex:0];
//        
//        NSCharacterSet *quoteCharset = [NSCharacterSet characterSetWithCharactersInString:@"\""];
//        NSString *trimmedString = [temp2 stringByTrimmingCharactersInSet:quoteCharset];
//        
//        NSString *path = [NSString stringWithFormat:@"http://www.sccp.ca%@",trimmedString];
//        
//
//        
//        //SecondImage
//        
//        NSString *TempImg=[Array objectAtIndex:2];
//        
//        NSArray* ArrayImg2 = [TempImg componentsSeparatedByString: @" "];
//        
//        NSString *tempImg2=[ArrayImg2 objectAtIndex:0];
//        
//        NSCharacterSet *quoteCharset2 = [NSCharacterSet characterSetWithCharactersInString:@"\""];
//        NSString *trimmedString2 = [tempImg2 stringByTrimmingCharactersInSet:quoteCharset2];
//        
//        NSString *path2 = [NSString stringWithFormat:@"http://www.sccp.ca%@",trimmedString2];
//        
//        
//        //Description
//        
//        
//        NSArray* ArrayDisc = [TempImg componentsSeparatedByString: @"<p>"];
//        NSString *strDesc=[ArrayDisc objectAtIndex:1];
//        
//
//        
//        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<p><img src=""%@"" height=\"150\" width=\"500\"/><p/><p><img src=""%@"" height=\"150\" width=\"500\"/><p/><p><font face='GothamRounded-Bold' size='20'>%@</p>",path, path2,strDesc];
        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<html><head><style>img{max-width:100%%;height:auto !important;width:auto !important;};</style></head><body style='margin:8px; padding:0;'>%@</body></html>",str];
        
//        NSString *htmlString1 =
//        [NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='5.5'>%@", str];

        
        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
       
        
    }
    else if([_strType isEqualToString:@"Terms"]){
        
        _titleHeader.text=@"Terms of Use";
        
        _txtWebView.hidden= NO;
        _txtWebView2.hidden = YES;
        _TxtTextView.hidden=NO;
        _CollView.hidden = YES;
       
        NSString *strBaseurl =@"http://www.sccp.ca/";
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Terms"];
        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='5.5 '>%@", str];

        
        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
    }
    else if([_strType isEqualToString:@"Amphibian"]){
        
        _titleHeader.text=@"Amphibian Tips";
        
        _txtWebView.hidden= NO;
        _txtWebView2.hidden = YES;
        _TxtTextView.hidden=NO;
        _CollView.hidden = YES;
        
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Amphibian"];
        
        NSString *strBaseurl =@"http://www.sccp.ca/";
//        
//        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
        
        
        
//        NSArray* Array = [str componentsSeparatedByString: @"src="];
//        
//        NSLog(@"%@",Array);
//        NSString *temp=[Array objectAtIndex:1];
//        
//        NSArray* Array2 = [temp componentsSeparatedByString: @" "];
//        
//        NSLog(@"%@",[Array2 objectAtIndex:0]);
//        
//        NSString *temp2=[Array2 objectAtIndex:0];
//        
//        NSCharacterSet *quoteCharset = [NSCharacterSet characterSetWithCharactersInString:@"\""];
//        NSString *trimmedString = [temp2 stringByTrimmingCharactersInSet:quoteCharset];
//        
//        NSString *path = [NSString stringWithFormat:@"http://www.sccp.ca%@",trimmedString];
//        
//        
//        NSArray* ArrayDisc = [temp componentsSeparatedByString: @"<p>"];
//        
//        NSLog(@"%@",[ArrayDisc objectAtIndex:1]);
//        
//        NSString *strDesc=[ArrayDisc objectAtIndex:1];
//        
//        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<p><img src=""%@"" height=\"600\" width=\"600\"/><p/><p><font face='GothamRounded-Bold' size='20'>%@</p>", path,strDesc];
        
        
/*        NSString *htmlString =
        [NSString stringWithFormat:@"<html><head><style>img{max-width:100%%;height:auto !important;width:auto !important;};</style></head><body style='margin:8px; padding:0;'>%@</body></html>",str];
      //  NSString *htmlString1 =
        [NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='12'>%@", htmlString];
       // NSString *htmlString1 = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue-Thin;font-size:30\">%@</span>",htmlString];*/
        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
        
        
    }
    else if([_strType isEqualToString:@"Snail"]){
        
        _titleHeader.text=@"Snail ID Tips";
        
        _txtWebView.hidden= NO;
        _txtWebView2.hidden = YES;
        _TxtTextView.hidden=NO;
        _CollView.hidden = YES;
        
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Snail"];
        
        NSString *strBaseurl =@"http://www.sccp.ca/";
        
        
       // [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
        
//        NSArray* Array = [str componentsSeparatedByString: @"src="];
//        
//        NSLog(@"%@",Array);
//        NSString *temp=[Array objectAtIndex:1];
//        
//        NSArray* Array2 = [temp componentsSeparatedByString: @" "];
//        
//        NSLog(@"%@",[Array2 objectAtIndex:0]);
//        
//        NSString *temp2=[Array2 objectAtIndex:0];
//        
//        NSCharacterSet *quoteCharset = [NSCharacterSet characterSetWithCharactersInString:@"\""];
//        NSString *trimmedString = [temp2 stringByTrimmingCharactersInSet:quoteCharset];
//        
//        NSString *path = [NSString stringWithFormat:@"http://www.sccp.ca%@",trimmedString];
//        
//        
//        NSArray* ArrayDisc = [temp componentsSeparatedByString: @"<p>"];
//        
//        NSLog(@"%@",[ArrayDisc objectAtIndex:1]);
//        
//        NSString *strDesc=[ArrayDisc objectAtIndex:1];
//        
//        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<p><img src=""%@"" height=\"600\" width=\"600\"/><p/><p><font face='GothamRounded-Bold' size='20'>%@</p>", path,strDesc];
        
        
//        NSString *htmlString =
//        [NSString stringWithFormat:@"<html><head><style>img{max-width:100%%;height:auto !important;width:auto !important;};</style></head><body style='margin:8px; padding:0;'>%@</body></html>",str];
//        
//        NSString *htmlString1 =
//        [NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='12'>%@", htmlString];

        [_txtWebView loadHTMLString:str baseURL:[NSURL URLWithString:strBaseurl]];
        
        
    }
    else if([_strType isEqualToString:@"WildLife"]){
        
        _titleHeader.text=@"Wildlife ID Tips";
        
        _txtWebView.hidden= NO;
        _txtWebView2.hidden = YES;
        _TxtTextView.hidden=YES;
        _CollView.hidden = NO;
       
        
        
    }
    

    

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.daledietrich.com"]];
        return NO;
    }
    
    return YES;
}
//- (void) webViewDidFinishLoad:(UIWebView *)webView
//{
//    
//    
//    webView.scrollView.delegate = self; // set delegate method of UISrollView
//    webView.scrollView.maximumZoomScale = 30; // set as you want.
//    webView.scrollView.minimumZoomScale = 2; // set as you want.
//    
//    //// Below two line is for iOS 6, If your app only supported iOS 7 then no need to write this.
//    webView.scrollView.zoomScale = 2;
//    webView.scrollView.zoomScale = 1;
//    
//    
//
//}


#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    self.txtWebView.scrollView.maximumZoomScale = 30; // set similar to previous.
}

#pragma tableview method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_arrName count];
    
}
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"CellSide";
    
    
    SideCell *objcell = [_tblSideView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    objcell.img.image=[UIImage imageNamed:[_arrImg objectAtIndex:indexPath.row]];
    objcell.title.text=[_arrName objectAtIndex:indexPath.row];
    
    return objcell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(tableView == _tblSideView)
    {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        if (indexPath.row==0) {
            
            
            _strType=@"AboutUs";
            
            [self reloadPage];
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;

            
            
        }
        else if (indexPath.row==1){
            
            HomeVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            [self.navigationController pushViewController:objVC animated:YES];

       
        }
        else if (indexPath.row==2){
            
            
            SearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            [self.navigationController pushViewController:objVC animated:YES];
            
        }
        else if (indexPath.row==3){
            
            _strType=@"WildLife";
            [self reloadPage];
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;

            
            _strType = @"Sync";
            
            [self reloadPage];
            
            
        }else if (indexPath.row==4){
            
            _strType =@"Amphibian";
            
            [self reloadPage];
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;

            
            
        }else if (indexPath.row==5){
            
            _strType =@"Snail";
            
            [self reloadPage];
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;
            
            
        }else if (indexPath.row==6){
            
            _strType=@"Conservation";
            
            [self reloadPage];
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;
            
           
            
        }else if (indexPath.row==7){
            
            ObserVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ObserVC"];
            [self.navigationController pushViewController:objVC animated:YES];
            
       
        }
        else if (indexPath.row==8){
            
            
            FvrVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FvrVC"];
            [self.navigationController pushViewController:objVC animated:YES];
            

        }
        else if (indexPath.row==9){
            
            HomeVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            objVC.strType=@"Sync";
            [self.navigationController pushViewController:objVC animated:YES];


        }
        else if (indexPath.row==10){
            
            _strType=@"HowToUse";
            
            [self reloadPage];
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            isShown = NO;

            
        }
        else if (indexPath.row==11){
            
            _strType = @"Terms";
            
            [self reloadPage];
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;
     
            
        }
        else if (indexPath.row==12){
            
            _strType=@"Sponsers";
            
            [self reloadPage];
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;

        }
    }
    
    
}
- (IBAction)btnSideMenu:(id)sender {
    _tblSideView.hidden=NO;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (!isShown)
    {
        [UIView animateWithDuration:.25f delay:0.0 options:0
                         animations:^{
                             [_tblSideView setFrame:CGRectMake(0, _tblSideView.frame.origin.y,screenRect.size.width-100, _tblSideView.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                             
                             [_tblSideView setFrame:CGRectMake(0, _tblSideView.frame.origin.y,screenRect.size.width-100, _tblSideView.frame.size.height)];
                         }];
        
        isShown = true;
        
        //        recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        //        [recognizer setNumberOfTapsRequired:1];
        //        [mainView addGestureRecognizer:recognizer];
        
        isSlide = YES;
        
    }else{
        [UIView animateWithDuration:.25f delay:0.0 options:0
                         animations:^{
                             [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                         }];
        isShown = false;
        
        //        Dissmiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        //        [mainView addGestureRecognizer:Dissmiss];
        
        
    }
    
}
#pragma CollectioView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_arrWild count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell
    ImageCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellWild"
                                                                  forIndexPath:indexPath];
    
    
//    CGRect frame = CGRectMake(0.0, 0.0, myCell.frame.size.width, myCell.frame.size.height);
//    frame.origin = [myCell convertPoint:myCell.frame.origin toView:self.view];

    
    myCell.ItemImage.image=[UIImage imageNamed:[_arrWild objectAtIndex:indexPath.row]];
    
    myCell.ItemImage.contentMode = UIViewContentModeScaleAspectFit;
   // myCell.backgroundColor = [UIColor redColor];
    
    //   indexPath1 = [self.collectionView indexPathForCell:myCell];
    
    return myCell;
    
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
    /*UIImage *image;
     long row = [indexPath row];
     
     image = [UIImage imageNamed:arrimage1[row]];*/
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    return CGSizeMake(frame.size.width-16, _collectionView.frame.size.height);
    
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
