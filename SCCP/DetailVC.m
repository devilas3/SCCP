//
//  DetailVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 24/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "DetailVC.h"
#import "DBManager.h"
#import "ImageCell.h"
#import "ImagesVC.h"


@interface DetailVC ()

@property (strong, nonatomic) NSMutableArray *arrItem,*arrImg;
@property (nonatomic, strong) DBManager *dbManager;
@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    
    [self.txtTextView scrollRangeToVisible:NSMakeRange(0, 0)];

    
    _lbMainTitle.text = _strMainTitle;
    
   // [self GetData];
    
    [self loadData];
    
    [self GetImageData];
    [self GetText];
    
}
-(void)loadData{
    // Form the query.
    if([_strType isEqualToString:@"Status"]){
        
        NSString *query = [NSString stringWithFormat:@"select title, genus,species,globalStatus,provincialStatus, saraStatus,bclistStatus,nid from TblSpecies where nid=\'%@\'",_strID];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        // For Category
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
        _StatusView.hidden = NO;
        _ImageView.hidden = YES;
        _TxtView.hidden = YES;

        
        
        NSString *strTitle=[[_arrItem objectAtIndex:0]objectAtIndex:0];
        NSString *strgenus =[[_arrItem objectAtIndex:0]objectAtIndex:1];
        NSString *strspecies =[[_arrItem objectAtIndex:0]objectAtIndex:2];
        
        
        
        NSString *strSubTitle =[strgenus stringByAppendingString:[NSString stringWithFormat:@" %@",strspecies]];
        NSString *strBrace=[NSString stringWithFormat:@"(%@)",strSubTitle];
        
        NSString *str =[strTitle stringByAppendingString:[NSString stringWithFormat:@" %@",strBrace]];
        _Title.text = str;
        
        _lblGenus.text = strgenus;
        
        _lblspecies.text = strspecies;
        
        NSString *strGlobal =[[_arrItem objectAtIndex:0]objectAtIndex:3];
        
        _lbl1.text = strGlobal;
        
        NSString *strpro =[[_arrItem objectAtIndex:0]objectAtIndex:4];
        
        _lbl2.text = strpro;
        
        NSString *strSara =[[_arrItem objectAtIndex:0]objectAtIndex:5];
        
        _lbl3.text = strSara;
        
        NSString *strBC =[[_arrItem objectAtIndex:0]objectAtIndex:6];
        
        _lbl4.text = strBC;

                
    }
    else if([_strType isEqualToString:@"similarValue"]|| [_strType isEqualToString:@"life_cycle"] || [_strType isEqualToString:@"Range"] ){
        
        [self GetImageData];
        if(!([_arrImg count] == 0)){
            
            
            [self GetText];
            
            _StatusView.hidden = YES;
            _ImageView.hidden = NO;
            _TxtView.hidden = YES;
            NSString *str =[[_arrItem objectAtIndex:0]objectAtIndex:0];
            
            NSString *htmlString =
            [NSString stringWithFormat:@"<font face='GothamRounded-Bold' size='5'>%@", str];

            [_ImgWebText loadHTMLString:htmlString baseURL:nil];
            
        }
        else{
            [self GetText];
            _StatusView.hidden = YES;
            _ImageView.hidden = YES;
            _TxtView.hidden = NO;
            
            NSLog(@"%@",[[_arrItem objectAtIndex:0]objectAtIndex:0]);
            
            NSString *str =[[_arrItem objectAtIndex:0]objectAtIndex:0];
            
            
            [_txtWebView loadHTMLString:str baseURL:nil];
            _txtTextView.text=[self htmlEntityDecode:str];
            
            NSString * newReplacedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
            
            NSLog(@"%@",newReplacedString);
            
            NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"[ ]"];
            _txtTextView.text = [_txtTextView.text stringByTrimmingCharactersInSet:charsToTrim];
            NSLog(@"%@",_txtTextView.text);
            
            
        }

        
    }
    else{
        [self GetText];
        NSLog(@"%@",[[_arrItem objectAtIndex:0]objectAtIndex:0]);
        
        NSString *str =[[_arrItem objectAtIndex:0]objectAtIndex:0];
        
        
        _StatusView.hidden = YES;
        _ImageView.hidden = YES;
        _TxtView.hidden = NO;

        [_txtWebView loadHTMLString:str baseURL:nil];
        _txtTextView.text=[self htmlEntityDecode:str];
        
        NSString * newReplacedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        
        NSLog(@"%@",newReplacedString);
        
        NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"[ ]"];
        _txtTextView.text = [_txtTextView.text stringByTrimmingCharactersInSet:charsToTrim];
        NSLog(@"%@",_txtTextView.text);

        [self.txtTextView scrollRangeToVisible:NSMakeRange(0, 0)];
        
    }
    
        
    
        
        
    
    
}
-(void)GetText{
    
    //FOR ONLY TEXT
    
    NSString *querytxt = [NSString stringWithFormat:@"select %@, nid from TblSpecies where nid=\'%@\'",_strType,_strID];
    
    // Get the results.
    if (self.arrItem != nil) {
        self.arrItem = nil;
    }
    // For Category
    
    self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:querytxt]];
    // Reload the table view.
    

}
-(void)GetImageData{
    
    // FOR IMAGE ANAD TEXT
    NSString *query = [NSString stringWithFormat:@"select * from %@ where nid=\'%@\'",_strTbl,_strID];
    
    // Get the results.
    if (self.arrImg != nil) {
        self.arrImg = nil;
    }
    // For Category
    
    self.arrImg = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    
    if(_arrImg.count == 1 || _arrImg.count == 0){
        
        _BtnNext.hidden = YES;
        _BtnPrevious.hidden = YES;
    }
    else{
        
        _BtnNext.hidden = NO;
        _BtnPrevious.hidden = NO;
    }

    
    NSLog(@"%@",_arrImg);
    

}
#pragma CollectioView




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_arrImg count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell
    ImageCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                                                  forIndexPath:indexPath];
    
    
    CGRect frame = CGRectMake(0.0, 0.0, myCell.frame.size.width, myCell.frame.size.height);
    frame.origin = [myCell convertPoint:myCell.frame.origin toView:self.view];
    
    
    NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrImg objectAtIndex:indexPath.row] objectAtIndex:0]];
    myCell.ItemImage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    myCell.Title.text=[[_arrImg objectAtIndex:indexPath.row]objectAtIndex:1];
    
    
    myCell.ItemImage.contentMode = UIViewContentModeScaleAspectFit;
    //  myCell.ItemImage.image = [UIImage imageNamed:self.arrImage[indexPath.item]];
    //myCell.backgroundColor = [UIColor redColor];
    
    
    return myCell;
    
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImagesVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"ImagesVC"];
    objVC.strID=_strID;
    objVC.strType = _strTbl;
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSString *my=[NSString stringWithFormat:@"%lu",indexPath.row];
    
    [[NSUserDefaults  standardUserDefaults]setObject:my forKey:@"indexx"];

    
    [self.navigationController pushViewController:objVC animated:YES];
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
     long row = [indexPath row];
     
     NSString *string = [[_arrImg objectAtIndex:row]objectAtIndex:1];
    
//    ImageCell *myCell;
//    
//    myCell.Title.text=[[_arrImg objectAtIndex:indexPath.row]objectAtIndex:1];
    
    if(string == 0 || string == nil || [string isEqualToString:@""]){
        
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        return CGSizeMake(frame.size.width, 160);
        
    }
    else{
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        return CGSizeMake(frame.size.width, 210);

    }
    

}

- (IBAction)BtnNext:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSLog(@"%lu",(unsigned long)[_arrImg count]);
    
    
    NSInteger Count = [_arrImg count];
    if(Count > indexPath.row+1){
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0];
        NSLog(@"%ld", (long)indexPath.row+1);
        
        
        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }else{
        
    }
    
}

- (IBAction)BtnPrevious:(id)sender {
    
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
-(void)GetData{
    
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    
    
    arr = [[_dicData objectForKey:@"details" ] valueForKey:@"nid"];
    for (int i = 0; i< [arr count]; i++) {
        
        // NSLog(@"%@",[[parentdict valueForKey:@"name"] objectAtIndex:y]);
        
        NSString *strId = [[[_dicData objectForKey:@"details" ] valueForKey:@"nid"] objectAtIndex:i];
        //  NSString *str = [[[_dicData objectForKey:@"details" ] valueForKey:@"description"] objectAtIndex:i];
        
        NSString *str =[[[_dicData objectForKey:@"details" ] valueForKey:[NSString stringWithFormat:@"%@",_strType]] objectAtIndex:i];
        NSLog(@"%@",str);
        NSLog(@"%@",strId);
        if ([strId isEqualToString:_strID]){
            
            NSLog(@"%@",str);
            [_txtWebView loadHTMLString:str baseURL:nil];
            _txtWebView.hidden = NO;
            
            _txtTextView.hidden = YES;
            _txtTextView.text =[self htmlEntityDecode:str];
            
            NSLog(@"%@",_txtTextView.text);
            
            NSString * newReplacedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
            
            NSLog(@"%@",newReplacedString);
            
            NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"[ ]"];
            _txtTextView.text = [_txtTextView.text stringByTrimmingCharactersInSet:charsToTrim];
            NSLog(@"%@",_txtTextView.text);
            
            
            
            break;
        }
        
    }
    
    
}

-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r\n\r\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];// Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

- (IBAction)btnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
