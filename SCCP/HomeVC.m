//
//  HomeVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "HomeVC.h"
#import "NSString_stripHtml.h"
#import "QuartzCore/QuartzCore.h"
#import "SpeciesDetailVC.h"
#import "SpeciesCell.h"
#import "FvrVC.h"
#import "ObserVC.h"
#import "AboutVC.h"
#import "SearchVC.h"
#import "SideCell.h"
#import "MBProgressHUD.h"
#import "DGActivityIndicatorView.h"


@interface HomeVC ()<UIAlertViewDelegate>{
    BOOL isShown;
    IBOutlet UILabel *titleHeader;
    IBOutlet UIView *navigationView;
    IBOutlet UIView *mainView;
    BOOL isSlide;
    NSMutableData *responseData;
    int indexx;
    int allCount;
    int Count;
    NSString *strLastnid;
    DGActivityIndicatorView *activityIndicatorView;

}
@property (strong, nonatomic) IBOutlet UITableView *tblSideView;
@property(strong,nonatomic)NSArray *arrName,*arrImg;
@property (strong, nonatomic) IBOutlet UITableView *tblSpecies;


@property (strong, nonatomic) NSMutableArray *arrItem;

@property (strong, nonatomic) NSMutableArray *ArrCheck,*ArrSimCheck,*ArrAllCheck,*ArrLifeCheck,*ArrRangeCheck,*ArrObseCheck,*ArrSubCheck;

@property (strong, nonatomic) NSString *strAdd,*strUnixTime,*strAlertType;

@property (strong, nonatomic) NSArray *arrApiData;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    _arrName =[NSArray arrayWithObjects:@"About SCCP",@"Species",@"Search Species",@"Wildlife Tips",@"Amphibian ID Tips",@"Snail ID Tips",@"Conservation Status",@"My Observations",@"My Favourites",@"Sync",@"How To Use",@"Terms of Use",@"Sponsors", nil];
    _arrImg =[NSArray arrayWithObjects:@"About",@"Species",@"Search",@"WildLife",@"Amphibian",@"Snail",@"Conservation",@"Observation",@"favourite",@"Sync",@"HowToUse",@"TermsOfUse",@"Sponsors", nil];
    
    _LoadingMSgView.layer.cornerRadius = 10;
    
    titleHeader.text = @"Species";

    
    
        // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated{
    
    [self reloadView];
    
    
    
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"IsSaved"];
    
    if([str isEqualToString:@"YES"]){
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Date"];
        
        _lblAllDate.text =str;
        _lblLatestDate.text = str;
        
        
        _LoadingView.hidden = YES;
        _Activity.hidden = YES;
        _LoadingMSgView.hidden = YES;
        activityIndicatorView.hidden = YES;
        
        
        
        NSDate* sourceDate = [NSDate date];
        NSLog(@"Date is : %@", sourceDate);
        
        NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:@"IST"];
        NSLog(@"TimeZone is : %@", currentTimeZone);
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init]  ;
        [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm:ss zzz"];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        NSLog(@"%@",[dateFormatter stringFromDate:sourceDate]);
        
        NSString *strdate=[dateFormatter stringFromDate:sourceDate];
        
        _lblLatestDate.text =[dateFormatter stringFromDate:sourceDate];
        
        [[NSUserDefaults  standardUserDefaults]setObject:strdate forKey:@"Date"];
        
        
        NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        NSLog(@"%@",timestamp);
        
        _strUnixTime=timestamp;
        _strAdd =@"NewData";

        
        [self AllJsonResponse];
        
        [self loadData];
        
        
       
    }
    else{
        
        _LoadingView.hidden = NO;
        _Activity.hidden = YES;
        _LoadingMSgView.hidden = NO;

        
        activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor whiteColor] size:70.0f];
        activityIndicatorView.frame = CGRectMake(0.0f,0.0f,50.0f,50.0f);
        activityIndicatorView.center = self.view.center;


        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        
        NSDate* sourceDate = [NSDate date];
        NSLog(@"Date is : %@", sourceDate);
        
        NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:@"IST"];
        //    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
        NSLog(@"TimeZone is : %@", currentTimeZone);
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init]  ;
        [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm:ss zzz"];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        NSLog(@"%@",[dateFormatter stringFromDate:sourceDate]);
        
        
        NSString *strSave=[dateFormatter stringFromDate:sourceDate];
        [[NSUserDefaults  standardUserDefaults]setObject:strSave forKey:@"Date"];
        
        _lblAllDate.text=[dateFormatter stringFromDate:sourceDate];
        _lblLatestDate.text =[dateFormatter stringFromDate:sourceDate];

         [self AllJsonResponse];

    }
    
}

-(void)reloadView{
    
    if([_strType isEqualToString:@"Sync"]){
        
        titleHeader.text =@"Sync";
        
        _SepciesView.hidden= YES;
        _SyncView.hidden=NO;
    }
    else{
        
        titleHeader.text =@"Species";
        
        _SepciesView.hidden= NO;
        _SyncView.hidden=YES;
        
    }
    
}
#pragma LOADAPI AND CHECK INTERNET COONECTION

-(void)AllJsonResponse
{
    if([_strAdd isEqualToString:@"NewData"]){
        
        NSString *strURL=[NSString stringWithFormat:@"http://sccp.ca/mobileapp/SyncDatabase.php?d=%@",_strUnixTime];
        
        responseData=[[NSMutableData alloc]init];
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:strURL]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];

        
    }
    else{
        
        responseData=[[NSMutableData alloc]init];
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:@"http://sccp.ca/mobileapp/SyncDatabase.php"]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        NSFileManager *filemgr;
        
        filemgr = [NSFileManager defaultManager];
        
        if ([filemgr removeItemAtPath: [NSHomeDirectory() stringByAppendingString:@"/Library/Caches"] error: NULL]  == YES)
            NSLog (@"Remove successful");
        else
            NSLog (@"Remove failed");
        
        [filemgr createDirectoryAtPath: [NSHomeDirectory() stringByAppendingString:@"/Library/Caches"] withIntermediateDirectories:NO attributes:nil error:nil];

         [self CheckData];
    }
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
    
    NSString *strAbout=[[arrAbout valueForKey:@"body"]objectAtIndex:0];
    NSLog(@"%@",strAbout);
    NSString *strHowToUse=[[arrAbout valueForKey:@"body"]objectAtIndex:1];
    NSString *strCon=[[arrAbout valueForKey:@"body"]objectAtIndex:2];
    NSString *strSponser=[[arrAbout valueForKey:@"body"]objectAtIndex:3];
    NSString *strTerms=[[arrAbout valueForKey:@"body"]objectAtIndex:4];
    NSString *stramphibian=[[arrAbout valueForKey:@"body"]objectAtIndex:6];
    NSString *strsnail=[[arrAbout valueForKey:@"body"]objectAtIndex:7];
    
    
    
    [[NSUserDefaults  standardUserDefaults]setObject:strAbout forKey:@"AboutUs"];
    [[NSUserDefaults  standardUserDefaults]setObject:strHowToUse forKey:@"HowToUse"];
    [[NSUserDefaults  standardUserDefaults]setObject:strCon forKey:@"Conservation"];
    [[NSUserDefaults  standardUserDefaults]setObject:strSponser forKey:@"Sponsers"];
    [[NSUserDefaults  standardUserDefaults]setObject:strTerms forKey:@"Terms"];
    [[NSUserDefaults  standardUserDefaults]setObject:stramphibian forKey:@"Amphibian"];
    [[NSUserDefaults  standardUserDefaults]setObject:strsnail forKey:@"Snail"];
    
    
    
#pragma FORDATABASE SAVE
    
    
    //    NSArray *arrPage=[JSON objectForKey:@"pages"];
    _arrApiData =[JSON objectForKey:@"details"];
    
    allCount = [_arrApiData count];
    
    Count = 1;

    indexx = [_arrApiData count]-1;
 //   strLastnid=[[_arrApiData valueForKey:@"nid"]objectAtIndex:indexx];
  //  NSLog(@"%@",strLastnid);
    
    for (int i=0; i<_arrApiData.count; i++) {
        
           strLastnid=[[_arrApiData valueForKey:@"nid"]objectAtIndex:indexx];
          NSLog(@"%@",strLastnid);
        
        strID=[[_arrApiData valueForKey:@"nid"]objectAtIndex:i];
        idNo=[strID integerValue];
        title=[[_arrApiData valueForKey:@"title"]objectAtIndex:i];
        genus=[[_arrApiData valueForKey:@"genus"]objectAtIndex:i];
        species=[[_arrApiData valueForKey:@"species"]objectAtIndex:i];
        globalStatus=[[_arrApiData valueForKey:@"globalStatus"]objectAtIndex:i];
        provincialStatus=[[_arrApiData valueForKey:@"provincialStatus"]objectAtIndex:i];
        saraStatus=[[_arrApiData valueForKey:@"saraStatus"]objectAtIndex:i];
        bclistStatus=[[_arrApiData valueForKey:@"bclistStatus"]objectAtIndex:i];
        NSArray* image1=[[[JSON objectForKey:@"details"]valueForKey:@"images"]objectAtIndex:i];
        arrAllImg=[[NSMutableArray alloc]init];
        dicAllImg=[[NSMutableDictionary alloc]init];
        
        
        //FOR IMAGES GET
        
        for (int j=0; j<image1.count; j++) {
            dicImg=[[NSMutableDictionary alloc]init];
            strImage=[[image1 valueForKey:@"imagename"]objectAtIndex:j];
            NSString *strtemp=[[image1 valueForKey:@"title"]objectAtIndex:j];
            strImgTitle=[strtemp stringByReplacingOccurrencesOfString: @"\"" withString: @""];
            NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *si=[NSString stringWithFormat:@"%ld",(long)idNo];
            NSString *str=[si stringByAppendingString:[NSString stringWithFormat:@".%i",j]];
            strimageName = [NSString stringWithFormat:@"%@.png",str];
            
            [dicImg setValue:strimageName forKey:@"ImageName"];
            [dicImg setValue:strImgTitle forKey:@"title"];
            [arrAllImg addObject:dicImg];
            dicImg=nil;
            
            //Save Image In DocumentDirectory User
            
            NSString *filePath = [documentDir stringByAppendingPathComponent:strimageName];
            strImage = [strImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strImage]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    NSLog(@"Download Error:%@",error.description);
                }
                if (data) {
                    [data writeToFile:filePath atomically:YES];
                    NSLog(@"File is saved to %@",filePath);
                    
                    
                    float result = (Count*100)/allCount;
                    
                    _LblPerce.text=[NSString stringWithFormat:@"%d %@",(int)result,@"% Completed"];
                    NSString *strTempCount=[NSString stringWithFormat:@"%@",[documentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.0.png",si]]];
                    
                    
                    if([filePath isEqualToString:strTempCount]){
                        
                        Count++;
                        
                    }
                    
                    
                    
                    NSString *strid=[NSString stringWithFormat:@"%@.0.png",strLastnid];
                    NSString *strpath=[documentDir stringByAppendingPathComponent:strid];
                    if([filePath isEqualToString:strpath]){
                        NSLog(@"");
                        
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                        
                        // Configure for text only and offset down
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text = @"Successfully Sync Data";
                        hud.margin = 10.f;
                        hud.yOffset = 150.f;
                        hud.removeFromSuperViewOnHide = YES;
                        
                        [hud hideAnimated:YES afterDelay:2.0];
                        
                        _LoadingView.hidden = YES;
                        _Activity.hidden = YES;
                        _LoadingMSgView.hidden = YES;
                        activityIndicatorView.hidden = YES;
                        
                        [self loadData];
                    }
                    
                }
            }];
            
            [self SaveImageData];
            
    

        }
        
        [dicAllImg setValue:arrAllImg forKey:@"Images"];
        NSArray *aa=[dicAllImg valueForKey:@"Images"];
        NSError *writeError = nil;
        jsonData1 = [NSJSONSerialization dataWithJSONObject:aa options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        strAllImg = mutableJsonString;
        dicAllImg=nil;
        arrAllImg=nil;
        jsonData=nil;
        mutableJsonString=nil;
        
        
        
        
        //FOR SIMILAR IMAGES GET
        dicSimilarImg=[[NSMutableDictionary alloc]init];
        arrSimAllImg=[[NSMutableArray alloc]init];
        NSArray* Simimage=[[[JSON objectForKey:@"details"]valueForKey:@"similarImages"]objectAtIndex:i];
        jsonData1 = [NSJSONSerialization dataWithJSONObject:Simimage options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        for (int k=0; k<Simimage.count; k++) {
            dicSimilarImg=[[NSMutableDictionary alloc]init];
            strSimImage=[[Simimage valueForKey:@"imagename"]objectAtIndex:k];
            NSString *string = [[Simimage valueForKey:@"title"]objectAtIndex:k];
            strSimImgTitle=[string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *si=[NSString stringWithFormat:@"%ld",(long)idNo];
            NSString *str=[si stringByAppendingString:[NSString stringWithFormat:@".%i",k]];
            strSimimageName = [NSString stringWithFormat:@"Sim_%@.png",str];
            
            [dicSimilarImg setValue:strSimimageName forKey:@"ImageName"];
            [dicSimilarImg setValue:strSimImgTitle forKey:@"title"];
            [arrSimAllImg addObject:dicSimilarImg];
            dicSimilarImg=nil;
            
            //Save Image In DocumentDirectory User
            
            NSString *filePath = [documentDir stringByAppendingPathComponent:strSimimageName];
            strSimImage = [strSimImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strSimImage]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    NSLog(@"Download Error:%@",error.description);
                }
                if (data) {
                    [data writeToFile:filePath atomically:YES];
                    NSLog(@"File is saved to %@",filePath);
                    
                    
                }
            }];
            
            [self SaveSimImageData];
        }
        
        
        
        similarValue=[[_arrApiData valueForKey:@"similarValue"]objectAtIndex:i];
        //        NSArray* similarImages1=[[[JSON objectForKey:@"details"]valueForKey:@"similarImages"]objectAtIndex:i];
        //        jsonData1 = [NSJSONSerialization dataWithJSONObject:similarImages1 options:NSJSONWritingPrettyPrinted error:&writeError];
        //        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        //        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        //        similarImages = mutableJsonString;
        //        jsonData=nil;
        //        mutableJsonString=nil;
        NSArray* threats1=[[[JSON objectForKey:@"details"]valueForKey:@"threats"]objectAtIndex:i];
        jsonData1 = [NSJSONSerialization dataWithJSONObject:threats1 options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        
        NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"[ ]"];
        NSString *str = [mutableJsonString stringByTrimmingCharactersInSet:charsToTrim];
        
        NSLog(@"%@",str);
        NSString *string = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        threats = string;
        jsonData=nil;
        mutableJsonString=nil;
        
        NSArray* conservation1=[[[JSON objectForKey:@"details"]valueForKey:@"conservation"]objectAtIndex:i];
        jsonData1 = [NSJSONSerialization dataWithJSONObject:conservation1 options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        
        NSCharacterSet *charsToTrimCon = [NSCharacterSet characterSetWithCharactersInString:@"[ ]"];
        NSString *strCon = [mutableJsonString stringByTrimmingCharactersInSet:charsToTrimCon];
        
        NSLog(@"%@",str);
        NSString *stringCon = [strCon stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        conservation = stringCon;
        jsonData=nil;
        mutableJsonString=nil;
        
        NSArray* subspecies1=[[[JSON objectForKey:@"details"]valueForKey:@"subspecies"]objectAtIndex:i];
        jsonData1 = [NSJSONSerialization dataWithJSONObject:subspecies1 options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        
        NSCharacterSet *charsToTrimSub = [NSCharacterSet characterSetWithCharactersInString:@"[ ]"];
        NSString *stritems = [mutableJsonString stringByTrimmingCharactersInSet:charsToTrimSub];
        NSString *stringSub = [stritems stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSArray *items = [stringSub componentsSeparatedByString:@","];   //take the one array for split the string
        
        //shows Description
        //        NSString *strSub=[items objectAtIndex:0];
        //        NSString *strSub1=[items objectAtIndex:1];   //Shows Data
        
        for(int i=0 ; i<[items count] ; i++){
            strSub=[items objectAtIndex:i];
            [self SaveSubSpecies];
        }
        subspecies = mutableJsonString;
        jsonData=nil;
        mutableJsonString=nil;
        
        
        NSDictionary* ecology1=[[[JSON objectForKey:@"details"]valueForKey:@"ecology"]objectAtIndex:i];
        NSString *strhab = [[[[JSON objectForKey:@"details"]valueForKey:@"ecology"] valueForKey:@"habitat"] objectAtIndex:i];
        if(![strhab isEqual:[NSNull null]] && ![strhab isEqualToString:@""] && !([strhab length]<=0)){
            
            Habitat =[strhab stringByReplacingOccurrencesOfString: @"\"" withString: @""];
            
            
        }
        else{
            Habitat = strhab;
        }
        // Habitat =[[[[JSON objectForKey:@"details"]valueForKey:@"ecology"] valueForKey:@"habitat"] objectAtIndex:i];
        
        diet = [[[[JSON objectForKey:@"details"]valueForKey:@"ecology"] valueForKey:@"diet"] objectAtIndex:i];
        life_cycle=[[[[JSON objectForKey:@"details"]valueForKey:@"ecology"] valueForKey:@"life_cycle"] objectAtIndex:i];
        Range=[[[[JSON objectForKey:@"details"]valueForKey:@"ecology"] valueForKey:@"range"] objectAtIndex:i];
        
        
        
        //FOR LIFE IMAGES SAVE
        
        
        diclifeImg=[[NSMutableDictionary alloc]init];
        arrlifeImg=[[NSMutableArray alloc]init];
        NSArray* lifeimage=[[[[JSON objectForKey:@"details"]valueForKey:@"ecology"] valueForKey:@"life_cycle_images"]objectAtIndex:i];
        jsonData1 = [NSJSONSerialization dataWithJSONObject:Simimage options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        for (int k=0; k<lifeimage.count; k++) {
            diclifeImg=[[NSMutableDictionary alloc]init];
            strlifeImage=[[lifeimage valueForKey:@"imagename"]objectAtIndex:k];
            NSString *string = [[lifeimage valueForKey:@"title"]objectAtIndex:k];
            strlifeImgTitle=[string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *si=[NSString stringWithFormat:@"%ld",(long)idNo];
            NSString *str=[si stringByAppendingString:[NSString stringWithFormat:@".%i",k]];
            strlifeimageName = [NSString stringWithFormat:@"Life_%@.png",str];
            
            [diclifeImg setValue:strlifeimageName forKey:@"ImageName"];
            [diclifeImg setValue:strlifeImgTitle forKey:@"title"];
            [arrlifeImg addObject:diclifeImg];
            diclifeImg=nil;
            
            //Save Image In DocumentDirectory User
            
            NSString *filePath = [documentDir stringByAppendingPathComponent:strlifeimageName];
            strlifeImage = [strlifeImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strlifeImage]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    NSLog(@"Download Error:%@",error.description);
                }
                if (data) {
                    [data writeToFile:filePath atomically:YES];
                    NSLog(@"File is saved to %@",filePath);
                    
                    
                }
            }];
            
            [self SaveLifeImageData];
        }
        
        
        //FOR LIFE IMAGES SAVE
        
        
        dicRangeImg=[[NSMutableDictionary alloc]init];
        arrRangeImg=[[NSMutableArray alloc]init];
        NSArray* Rangeimage=[[[[JSON objectForKey:@"details"]valueForKey:@"ecology"] valueForKey:@"range_images"]objectAtIndex:i];
        jsonData1 = [NSJSONSerialization dataWithJSONObject:Simimage options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        for (int k=0; k<Rangeimage.count; k++) {
            dicRangeImg=[[NSMutableDictionary alloc]init];
            strRangeImage=[[Rangeimage valueForKey:@"imagename"]objectAtIndex:k];
            NSString *string = [[Rangeimage valueForKey:@"title"]objectAtIndex:k];
            strRangeImgTitle=[string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *si=[NSString stringWithFormat:@"%ld",(long)idNo];
            NSString *str=[si stringByAppendingString:[NSString stringWithFormat:@".%i",k]];
            strRangeimageName = [NSString stringWithFormat:@"Range_%@.png",str];
            
            [dicRangeImg setValue:strRangeimageName forKey:@"ImageName"];
            [dicRangeImg setValue:strRangeImgTitle forKey:@"title"];
            [arrRangeImg addObject:dicRangeImg];
            dicRangeImg=nil;
            
            //Save Image In DocumentDirectory User
            
            NSString *filePath = [documentDir stringByAppendingPathComponent:strRangeimageName];
            strRangeImage = [strRangeImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strRangeImage]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    NSLog(@"Download Error:%@",error.description);
                }
                if (data) {
                    [data writeToFile:filePath atomically:YES];
                    NSLog(@"File is saved to %@",filePath);
                    
                    
                }
            }];
            
            [self SaveRangeImageData];
        }
        
        
        
        
        jsonData1 = [NSJSONSerialization dataWithJSONObject:ecology1 options:NSJSONWritingPrettyPrinted error:&writeError];
        mutableJsonString = [[NSMutableString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        [mutableJsonString replaceOccurrencesOfString:@"\""  withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableJsonString length])];
        ecology = mutableJsonString;
        jsonData=nil;
        mutableJsonString=nil;
        
        description=[[[JSON objectForKey:@"details"]valueForKey:@"description"]objectAtIndex:i];
        
        sources=[[[JSON objectForKey:@"details"]valueForKey:@"sources"]objectAtIndex:i];
        
        credits=[[[JSON objectForKey:@"details"]valueForKey:@"credits"]objectAtIndex:i];
        
        
        if(![description isEqual:[NSNull null]] && ![description isEqualToString:@""] && !([description length]<=0))
        {
            description=[description stringByReplacingOccurrencesOfString: @"\"" withString: @""];
        }else{
            
        }
        if(![sources isEqual:[NSNull null]] && ![sources isEqualToString:@""] && !([sources length]<=0))
        {
            sources=[sources stringByReplacingOccurrencesOfString: @"\"" withString: @""];
        }else{
            
        }
        if(![credits isEqual:[NSNull null]] && ![credits isEqualToString:@""] && !([credits length]<=0))
        {
            credits=[credits stringByReplacingOccurrencesOfString: @"\"" withString: @""];
        }else{
            
        }
        
        //bellow Save Data in Local Sqlite Database:-
        
        [self SaveData];
        
        
        
        NSString *strSave=@"YES";
        [[NSUserDefaults  standardUserDefaults]setObject:strSave forKey:@"IsSaved"];
        
    }
    
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    _Activity.hidden = YES;
    _LoadingMSgView.hidden = YES;
    activityIndicatorView.hidden = YES;
    
    NSLog(@"%@", [NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"SCCP" message:@"The network connection was lost.Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alt show];
}


-(void)SaveData{
    NSString *query;
    
    NSString *strfav= @"NULL";
    
    
    //   Habitat = @"k";
    
    
    query = [NSString stringWithFormat:@"insert into Tblspecies (nid,title, genus, species,globalStatus,provincialStatus,saraStatus,bclistStatus,images,similarValue,similarImages,ecology,threats,conservation,subspecies,description,sources,credits,favourites,Habitat,diet,life_cycle,Range) values(\"%ld\",\"%@\", \"%@\", \"%@\",\"%@\",\"%@\", \"%@\", \"%@\",\"%@\",\"%@\", \"%@\",\"%@\",\"%@\", \"%@\", \"%@\",\"%@\",\"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",(long)idNo,title,genus, species,globalStatus,provincialStatus,saraStatus,bclistStatus,strAllImg,similarValue,similarImages,ecology,threats,conservation,subspecies,description,sources,credits,strfav,Habitat,diet,life_cycle,Range];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
    

}
-(void)CheckData{
    
    
    NSString *queryCheck = [NSString stringWithFormat:@"select * from TblSpeciesImage"];
    
    // Get the results.
    if (self.ArrCheck != nil) {
        self.ArrCheck = nil;
    }
    
    // For Category
    
    self.ArrCheck = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryCheck]];
    // Reload the table view.
    
    if([_ArrCheck count] == 0){
        
        
    }
    else{
        
        NSString *StrDelete=[NSString stringWithFormat:@"DELETE FROM TblspeciesImage"];
        
        [self.dbManager executeQuery:StrDelete];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }
    
    //CHECK SIMILAR IMAGE
    
    NSString *querySimCheck = [NSString stringWithFormat:@"select * from SimilarImage"];
    
    // Get the results.
    if (self.ArrSimCheck != nil) {
        self.ArrSimCheck = nil;
    }
    
    // For Category
    
    self.ArrSimCheck = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:querySimCheck]];
    // Reload the table view.
    
    if([_ArrSimCheck count] == 0){
        
        
    }
    else{
        
        NSString *StrDelete=[NSString stringWithFormat:@"DELETE FROM SimilarImage"];
        
        [self.dbManager executeQuery:StrDelete];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }
    
    
    //CHECK LIFE IMAGEDATA
    
    
    NSString *querylifeCheck = [NSString stringWithFormat:@"select * from LifeImage"];
    
    // Get the results.
    if (self.ArrLifeCheck != nil) {
        self.ArrLifeCheck = nil;
    }
    
    // For Category
    
    self.ArrLifeCheck = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:querylifeCheck]];
    // Reload the table view.
    
    if([_ArrLifeCheck count] == 0){
        
        
    }
    else{
        
        NSString *StrDelete=[NSString stringWithFormat:@"DELETE FROM LifeImage"];
        
        [self.dbManager executeQuery:StrDelete];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }
    
    
    
    //CHECK LIFE RANGEIMAGE
    
    
    NSString *queryRangeCheck = [NSString stringWithFormat:@"select * from RangeImage"];
    
    // Get the results.
    if (self.ArrRangeCheck != nil) {
        self.ArrRangeCheck = nil;
    }
    
    // For Category
    
    self.ArrRangeCheck = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryRangeCheck]];
    // Reload the table view.
    
    if([_ArrRangeCheck count] == 0){
        
        
    }
    else{
        
        NSString *StrDelete=[NSString stringWithFormat:@"DELETE FROM RangeImage"];
        
        [self.dbManager executeQuery:StrDelete];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }
    
    
    //CHECK SUBSPECIES
    
    
    NSString *querySubCheck = [NSString stringWithFormat:@"select * from SubSpecies1"];
    
    // Get the results.
    if (self.ArrSubCheck != nil) {
        self.ArrSubCheck = nil;
    }
    
    // For Category
    
    self.ArrSubCheck = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:querySubCheck]];
    // Reload the table view.
    
    if([_ArrSubCheck count] == 0){
        
        
    }
    else{
        
        NSString *StrDelete=[NSString stringWithFormat:@"DELETE FROM SubSpecies1"];
        
        [self.dbManager executeQuery:StrDelete];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }
    
    
    
    
    
    //CHECK All Data
    
    NSString *queryAllCheck = [NSString stringWithFormat:@"select * from Tblspecies"];
    
    // Get the results.
    if (self.ArrAllCheck != nil) {
        self.ArrAllCheck = nil;
    }
    
    // For Category
    
    self.ArrAllCheck = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryAllCheck]];
    // Reload the table view.
    
    if([_ArrAllCheck count] == 0){
        
        
    }
    else{
        
        NSString *StrDelete=[NSString stringWithFormat:@"DELETE FROM Tblspecies"];
        
        [self.dbManager executeQuery:StrDelete];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }
    
    
    //CHECK OBSERVATION DATA
    
    
 /*   NSString *queryOBCheck = [NSString stringWithFormat:@"select * from Observation"];
    
    // Get the results.
    if (self.ArrObseCheck != nil) {
        self.ArrObseCheck = nil;
    }
    
    // For Category
    
    self.ArrObseCheck = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryOBCheck]];
    // Reload the table view.
    
    if([_ArrObseCheck count] == 0){
        
        
    }
    else{
        
        NSString *StrDelete=[NSString stringWithFormat:@"DELETE FROM Observation"];
        
        [self.dbManager executeQuery:StrDelete];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }*/
    
    
}
-(void)SaveRangeImageData{
    
    
    
    NSString *query;
    query = [NSString stringWithFormat:@"insert into RangeImage (ImageName,Title,nid) values(\"%@\",\"%@\",\"%ld\")",strRangeimageName,strRangeImgTitle,(long)idNo];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}


-(void)SaveLifeImageData{
    
    NSString *query;
    query = [NSString stringWithFormat:@"insert into LifeImage (ImageName,Title,nid) values(\"%@\",\"%@\",\"%ld\")",strlifeimageName,strlifeImgTitle,(long)idNo];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}

-(void)SaveSimImageData{
    
    //strSimimageName =@"manali";
    //strSimImgTitle = @"Abc";
    
    NSString *query;
    query = [NSString stringWithFormat:@"insert into SimilarImage (ImageName,Title,nid) values(\"%@\",\"%@\",\"%ld\")",strSimimageName,strSimImgTitle,(long)idNo];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}
-(void)SaveImageData{
    
    NSString *query;
    query = [NSString stringWithFormat:@"insert into TblspeciesImage (ImageName,Title,nid) values(\"%@\",\"%@\",\"%ld\")",strimageName,strImgTitle,(long)idNo];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}
-(void)SaveSubSpecies{
    
    NSString *query;
    query = [NSString stringWithFormat:@"insert into SubSpecies1 (Name,nid) values(\"%@\",\"%ld\")",strSub,(long)idNo];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}


#pragma HOME PAGE

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma LoadDATA

-(void)loadData{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName from TblSpecies sp,  TblSpeciesImage Im where Sp.nid == Im.nid and Im.ImageName like '%%.0.png' order by Sp.title asc"];
    
    // Get the results.
    if (self.arrItem != nil) {
        self.arrItem = nil;
    }
    
    // For Category
    
    self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    NSLog(@"%@",_arrItem);
    
    [_tblSpecies reloadData];
    [_tblSideView reloadData];
    
    
}


#pragma tableview method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tblSpecies==tableView) {
       return  _arrItem.count;
    }
    else{
        return [_arrName count];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_tblSideView==tableView) {
        
    static NSString *simpleTableIdentifier = @"CellSide";
        
        
    SideCell *objcell = [_tblSideView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
//        
//        UIImageView *img=[[UIImageView alloc]initWithFrame:(CGRectMake(15, 12, 30, 30))];
//        UILabel *lblName=[[UILabel alloc]initWithFrame:(CGRectMake(55, 12, 200, 30))];
//        lblName.text = [_arrName objectAtIndex:indexPath.row];
//        img.image=[UIImage imageNamed:[_arrImg objectAtIndex:indexPath.row]];
//        img.contentMode = UIViewContentModeScaleAspectFit;
//        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//        [objcell.contentView addSubview:img];
//        [objcell.contentView addSubview:lblName];
//        UIView *bgColorView = [[UIView alloc] init];
//        bgColorView.backgroundColor = [UIColor blackColor];
//        [objcell setSelectedBackgroundView:bgColorView];
//        objcell.textLabel.highlightedTextColor = [UIColor whiteColor];
//        lblName.highlightedTextColor=[UIColor whiteColor];
        
        objcell.img.image=[UIImage imageNamed:[_arrImg objectAtIndex:indexPath.row]];
        objcell.title.text=[_arrName objectAtIndex:indexPath.row];
               
        
        return objcell;
    }
    else {
        
        static NSString *Identifier = @"MyCell";
        
        SpeciesCell *objcell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        if (objcell==nil) {
            objcell = [[SpeciesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        

        
        NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexPath.row] objectAtIndex:5]];
        objcell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        
        
        
        objcell.lblTitle.text = [[_arrItem objectAtIndex:indexPath.row]objectAtIndex:1];
        objcell.lblsubtitle.text = [[_arrItem objectAtIndex:indexPath.row]objectAtIndex:2];
        objcell.lblsubtitle2.text = [[_arrItem objectAtIndex:indexPath.row]objectAtIndex:3];
        
        NSString *strfav =[[_arrItem objectAtIndex:indexPath.row]objectAtIndex:4];
        
        if([strfav isEqualToString:@"1"]){
            
            objcell.btnfav.hidden = NO;
        }
        else{
            
            objcell.btnfav.hidden = YES;
        }
        
        
        return objcell;
    }
    
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
    if (_tblSpecies==tableView) {
        return 120;
    }
        return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if(tableView == _tblSideView)
    {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        if (indexPath.row==0) {
            
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType=@"AboutUs";
            [self.navigationController pushViewController:objVC animated:YES];
            
            
        }
        else if (indexPath.row==1){
            
            _strType =@"";
            
            [self reloadView];
            
            [self viewWillAppear:YES];
            
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;
            
            
        }
        else if (indexPath.row==2){
            
            
            SearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            [self.navigationController pushViewController:objVC animated:YES];
        }
        else if (indexPath.row==3){
            
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType=@"WildLife";
            [self.navigationController pushViewController:objVC animated:YES];
            
        }else if (indexPath.row==4){
            
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType =@"Amphibian";
            [self.navigationController pushViewController:objVC animated:YES];
            
            
        }else if (indexPath.row==5){
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType =@"Snail";
            [self.navigationController pushViewController:objVC animated:YES];
            
            
        }else if (indexPath.row==6){
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType=@"Conservation";
            [self.navigationController pushViewController:objVC animated:YES];
            
            
        }else if (indexPath.row==7){
            
            ObserVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ObserVC"];
            [self.navigationController pushViewController:objVC animated:YES];
        }
        else if (indexPath.row==8){
            FvrVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FvrVC"];
            [self.navigationController pushViewController:objVC animated:YES];
            
        }
        else if (indexPath.row==9){
            _strType =@"Sync";
            
            [self reloadView];
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            isShown = NO;
            
            
        }
        else if (indexPath.row==10){
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType=@"HowToUse";
            [self.navigationController pushViewController:objVC animated:YES];
            
        }
        else if (indexPath.row==11){
            
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType = @"Terms";
            [self.navigationController pushViewController:objVC animated:YES];
            
        }
        else if (indexPath.row==12){
            
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType=@"Sponsers";
            [self.navigationController pushViewController:objVC animated:YES];
        }
    }

    else{
        
        SpeciesDetailVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SpeciesDetailVC"];
        //objVC.strMainTitle=[[[dicallData objectForKey:@"details"]valueForKey:@"title"]objectAtIndex:indexPath.row];
        //objVC.strID=[[[dicallData objectForKey:@"details"]valueForKey:@"nid"]objectAtIndex:indexPath.row];
        objVC.strMainTitle = [[_arrItem objectAtIndex:indexPath.row]objectAtIndex:1];
        objVC.strID =[[_arrItem objectAtIndex:indexPath.row]objectAtIndex:0];
        [self.navigationController pushViewController:objVC animated:YES];
        
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
        
     
        isSlide = YES;
      
    }else{
        [UIView animateWithDuration:.25f delay:0.0 options:0
                         animations:^{
                             [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                         }];
        isShown = false;
      



        }
    
}
- (IBAction)BtnSyncLatest:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"This operation may take considerable time. Are you sure you want to continue?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
    [alert show];
    
    _strAlertType=@"NewData";
    
    
}
- (IBAction)btnReSync:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"This operation may take considerable time. Are you sure you want to continue?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
    [alert show];
    
    
    _strAlertType=@"";
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Code for OK button
    }
    if (buttonIndex == 1)
    {
        //Code for download button
        
        if([_strAlertType isEqualToString:@"NewData"]){
            
            NSDate* sourceDate = [NSDate date];
            NSLog(@"Date is : %@", sourceDate);
            
            NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:@"IST"];
            //    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
            NSLog(@"TimeZone is : %@", currentTimeZone);
            
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init]  ;
            [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm:ss zzz"];
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            
            NSLog(@"%@",[dateFormatter stringFromDate:sourceDate]);
            
            NSString *str=[dateFormatter stringFromDate:sourceDate];
            
            _lblLatestDate.text =[dateFormatter stringFromDate:sourceDate];
            
            [[NSUserDefaults  standardUserDefaults]setObject:str forKey:@"Date"];

            
            NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
            NSLog(@"%@",timestamp);
            
            _strUnixTime=timestamp;
            _strAdd =@"NewData";
            
            [self AllJsonResponse];
        }
        else{
            
            NSDate* sourceDate = [NSDate date];
            NSLog(@"Date is : %@", sourceDate);
            
            NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:@"IST"];
            //    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
            NSLog(@"TimeZone is : %@", currentTimeZone);
            
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init]  ;
            [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm:ss zzz"];
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            
            NSLog(@"%@",[dateFormatter stringFromDate:sourceDate]);
            
            NSString *str=[dateFormatter stringFromDate:sourceDate];
            [[NSUserDefaults  standardUserDefaults]setObject:str forKey:@"Date"];

            
            _lblAllDate.text=[dateFormatter stringFromDate:sourceDate];
            
            
            _strAdd =@"";
            
            [self AllJsonResponse];

            
        }
        
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
  
        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
        //Save Image In DocumentDirectory User
        
        NSString *filePath = [documentDir stringByAppendingPathComponent:strimageName];
        strImage = [strImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strImage]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error) {
                NSLog(@"Download Error:%@",error.description);
            }
            if (data) {
                [data writeToFile:filePath atomically:YES];
                NSLog(@"File is saved to %@",filePath);
                NSString *strpath=[documentDir stringByAppendingPathComponent:filePath];
            
                NSLog(@"%@",strpath);
            }
        }];
    
    
        
        
        

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
