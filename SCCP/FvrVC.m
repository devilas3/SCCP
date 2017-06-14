//
//  FvrVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "FvrVC.h"
#import "DBManager.h"
#import "SpeciesCell.h"
#import "HomeVC.h"
#import "SpeciesDetailVC.h"
#import "ObserVC.h"
#import "SearchVC.h"
#import "AboutVC.h"
#import "SideCell.h"
#import "AddObseVC.h"

@interface FvrVC (){
    
    BOOL isSlide;
    BOOL isShown;
    int indexx;
    
   
}

@property(strong,nonatomic)DBManager *dbManager;

@property(strong,nonatomic)NSArray *arrName,*arrImg;

@property(strong,nonatomic)NSMutableArray *arrItem;

@property (strong, nonatomic) NSMutableArray *arrFvrItem,*arrFvrOb;

@property (strong, nonatomic) NSString *strFvrPage;

@end

@implementation FvrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    _arrName =[NSArray arrayWithObjects:@"About SCCP",@"Species",@"Search Species",@"Wildlife Tips",@"Amphibian ID Tips",@"Snail ID Tips",@"Conservation Status",@"My Observations",@"My Favourites",@"Sync",@"How To Use",@"Terms of Use",@"Sponsors", nil];
    _arrImg =[NSArray arrayWithObjects:@"About",@"Species",@"Search",@"WildLife",@"Amphibian",@"Snail",@"Conservation",@"Observation",@"favourite",@"Sync",@"HowToUse",@"TermsOfUse",@"Sponsors", nil];
    

    _BtnFvrSpe.backgroundColor =[UIColor clearColor];
    _BtnFvrObs.backgroundColor =[UIColor lightGrayColor];
    
    _TblFvr.hidden= NO;
    _TblObser.hidden = YES;
    
    
    [self loadFavrOBData];

    [self loadFavrData];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"ChkTbl"];
    
    if([str isEqualToString:@"FvrSpe"]){
        
        _BtnFvrSpe.backgroundColor =[UIColor clearColor];
        _BtnFvrObs.backgroundColor =[UIColor lightGrayColor];
        
        [self loadFavrData];
        
    }
    else{
        
        _BtnFvrObs.backgroundColor=[UIColor clearColor];
        _BtnFvrSpe.backgroundColor =[UIColor lightGrayColor];
        
         [self loadFavrOBData];
        
    }
    
    
   
}
-(void)loadFavrData{
    // Form the query.
    // NSString *query = [NSString stringWithFormat:@"select distinct nid ,title, genus , species, favourites from TblSpecies where favourites=\'%@\'",@"1"];
    NSString *query =[NSString stringWithFormat:@"select distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName from TblSpecies Sp,  TblSpeciesImage Im where Sp.nid == Im.nid and favourites='1' and Im.ImageName like '%%%@'",@".0.png"];
    // Get the results.
    if (self.arrFvrItem != nil) {
        self.arrFvrItem = nil;
    }
    
    // For Category
    
    self.arrFvrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    NSLog(@"%@",_arrFvrItem);
    
    
    [_TblFvr reloadData];
   
    if([_arrFvrItem count] == 0){
        
        _BlankView.hidden = NO;
        _TblObser.hidden = YES;
        _TblFvr.hidden = YES;
    }
    else{
        _BlankView.hidden = YES;
        _TblObser.hidden = YES;
        _TblFvr.hidden = NO;
    }
    
}
-(void)loadFavrOBData{
    
    
     [self loadImage];
    
    // Form the query.
    // NSString *query = [NSString stringWithFormat:@"select distinct nid ,title, genus , species, favourites from TblSpecies where favourites=\'%@\'",@"1"];
    NSString *query =[NSString stringWithFormat:@"select * from Observation where favourite='1'"];
    // Get the results.
    if (self.arrFvrOb != nil) {
        self.arrFvrOb = nil;
    }
    
    // For Category
    
    self.arrFvrOb = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    NSLog(@"%@",_arrFvrOb);
    
    
    for(int i = 0; i<[_arrFvrOb count] ; i++){
        
        NSString *str=[[_arrFvrOb objectAtIndex:i]objectAtIndex:5];
        
        
        [[_arrFvrOb objectAtIndex:i] insertObject:@"NULL" atIndex:6];
        
        
        for (int j=0; j<[_arrItem count]; j++) {
            NSString *str1=[[_arrItem objectAtIndex:j]objectAtIndex:1];
            
            if([str isEqualToString:str1]){
                
                NSString *strImg=[[_arrItem objectAtIndex:j]objectAtIndex:0];
                
                
                [[_arrFvrOb objectAtIndex:i] replaceObjectAtIndex:6 withObject:strImg];
            }
            
        }
    }

    
    [_TblObser reloadData];
    
    
    if([_arrFvrOb count] == 0){
        
        _BlankView.hidden = NO;
        _TblObser.hidden = YES;
        _TblFvr.hidden = YES;
    }
    else{
        _BlankView.hidden = YES;
        _TblObser.hidden = NO;
        _TblFvr.hidden = YES;
    }

    
}

-(void)loadImage{
    // Form the query.
    
    
    //    NSString *query =[NSString stringWithFormat:@"select ob.*,Im.Image from Observation ob, ObsImages Im where ob.Ob_id == Im.Ob_id  group by ob.Ob_id"];
    NSString *query =[NSString stringWithFormat:@"select image,Ob_id from ObsImages order by rowid desc"];
    // Get the results.
    if (self.arrItem != nil) {
        self.arrItem = nil;
    }
    
    // For Category
    
    
    self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    NSLog(@"%@",_arrItem);
    
    
    [_TblObser reloadData];
    
    
}

#pragma tableview method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_TblFvr == tableView){
        return _arrFvrItem.count;
    }
    else if(_TblObser == tableView){
        
        return _arrFvrOb.count;
    }
    else{
        return [_arrName count];
    }
    
}
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_tblSideView==tableView) {
        
        static NSString *simpleTableIdentifier = @"CellSide";
        
        
        SideCell *objcell = [_tblSideView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        objcell.img.image=[UIImage imageNamed:[_arrImg objectAtIndex:indexPath.row]];
        objcell.title.text=[_arrName objectAtIndex:indexPath.row];

        
        
        return objcell;
    }
    else if(tableView == _TblFvr){
        
        static NSString *Identifier = @"CellFvr";
        
        SpeciesCell *objcell = [_TblFvr dequeueReusableCellWithIdentifier:Identifier];
        
        if (objcell==nil) {
            objcell = [[SpeciesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        
                
        
        
        NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrFvrItem objectAtIndex:indexPath.row] objectAtIndex:5]];
        objcell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        
        
        
        objcell.lblTitle.text = [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:1];
        objcell.lblsubtitle.text = [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:2];
        objcell.lblsubtitle2.text = [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:3];
        
        NSString *strfav =[[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:4];
        
        if([strfav isEqualToString:@"1"]){
            
            objcell.btnfav.hidden = NO;
        }
        else{
            
            objcell.btnfav.hidden = YES;
        }
        
        [objcell.btnfav addTarget:self action:@selector(btnmyFvr:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return objcell;
        
    }
    else{
        
        static NSString *Identifier = @"CellObse";
        
        SpeciesCell *objcell = [_TblObser dequeueReusableCellWithIdentifier:Identifier];
        
        if (objcell==nil) {
            objcell = [[SpeciesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        
        
        
        
//        NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrFvrItem objectAtIndex:indexPath.row] objectAtIndex:5]];
//        objcell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        
        NSString *str=[[_arrFvrOb objectAtIndex:indexPath.row]objectAtIndex:6];
        if([str isEqualToString:@"NULL"]){
            
            objcell.img.image = [UIImage imageNamed:@"ic_launcher.png"];
        }
        else{
            
            NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrFvrOb objectAtIndex:indexPath.row] objectAtIndex:6]];
            objcell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
            
        }

    
        
        objcell.lblTitle.text = [[_arrFvrOb objectAtIndex:indexPath.row]objectAtIndex:0];
        objcell.lblsubtitle.text = [[_arrFvrOb objectAtIndex:indexPath.row]objectAtIndex:1];
        
        
        NSString *strfav =[[_arrFvrOb objectAtIndex:indexPath.row]objectAtIndex:4];
        
        if([strfav isEqualToString:@"1"]){
            
            objcell.btnfav.hidden = NO;
        }
        else{
            
            objcell.btnfav.hidden = YES;
        }
        
        [objcell.btnfav addTarget:self action:@selector(btnmyObFvr:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return objcell;

    }
    
   
    
}

-(IBAction)btnmyObFvr:(UIButton *)btn{
    
    CGPoint touchPoint = [btn convertPoint:CGPointZero toView:_TblObser];
    NSIndexPath *clickedButtonIndexPath = [_TblObser indexPathForRowAtPoint:touchPoint];
    NSLog(@"index path.row ==%ld",(long)clickedButtonIndexPath.row);
    
    indexx = clickedButtonIndexPath.row;
    
    // NSInteger indexOfItemID = [self.dbManager.arrColumnNames indexOfObject:@"item_id"];
    NSString *strID;
    strID=[NSString stringWithFormat:@"%@", [[self.arrFvrOb objectAtIndex:indexx] objectAtIndex:5]];
    
    int ItemID =[strID intValue];
    
    
    NSLog(@"%@",strID);
    
    
    for (indexx = 0; indexx < [_arrFvrOb count]; indexx++) {
        
        if (ItemID == [[[_arrFvrOb objectAtIndex:indexx]objectAtIndex:5] intValue]) {
            
            
            
            NSString *query;
            
            
            query = [NSString stringWithFormat:@"update Observation set favourite=\'%@\' where Ob_id=%d",@"0", ItemID];
            NSLog(@"query: %@", query);
            // Execute the query.
            [self.dbManager executeQuery:query];
            
            // If the query was successfully executed then pop the view controller.
            if (self.dbManager.affectedRows != 0) {
                NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
                
                // Pop the view controller.
                //[self.navigationController popViewControllerAnimated:YES];
            }
            else{
                NSLog(@"Could not execute the query.");
            }
        }
    }
    
    [self loadFavrOBData];
    
    
    
}

-(IBAction)btnmyFvr:(UIButton *)btn{
    
    CGPoint touchPoint = [btn convertPoint:CGPointZero toView:_TblFvr];
    NSIndexPath *clickedButtonIndexPath = [_TblFvr indexPathForRowAtPoint:touchPoint];
    NSLog(@"index path.row ==%ld",(long)clickedButtonIndexPath.row);
    
    indexx = clickedButtonIndexPath.row;
    
    // NSInteger indexOfItemID = [self.dbManager.arrColumnNames indexOfObject:@"item_id"];
    NSString *strID;
    strID=[NSString stringWithFormat:@"%@", [[self.arrFvrItem objectAtIndex:indexx] objectAtIndex:0]];
    
    int ItemID =[strID intValue];
    
    
    NSLog(@"%@",strID);
    
    
    for (indexx = 0; indexx < [_arrFvrItem count]; indexx++) {
        
        if (ItemID == [[[_arrFvrItem objectAtIndex:indexx]objectAtIndex:0] intValue]) {
            
            
            
            NSString *query;
            
            
            query = [NSString stringWithFormat:@"update TblSpecies set favourites=\'%@\' where nid=%d",@"0", ItemID];
            NSLog(@"query: %@", query);
            // Execute the query.
            [self.dbManager executeQuery:query];
            
            // If the query was successfully executed then pop the view controller.
            if (self.dbManager.affectedRows != 0) {
                NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
                
                // Pop the view controller.
                //[self.navigationController popViewControllerAnimated:YES];
            }
            else{
                NSLog(@"Could not execute the query.");
            }
        }
    }
    
    [self loadFavrData];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
    if (_TblFvr == tableView){
        return 120;
    }
    else if (_TblObser == tableView){
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
            
            HomeVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            [self.navigationController pushViewController:objVC animated:YES];

            
            
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
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            
            _TblFvr.hidden = NO;
            _TblObser.hidden = YES;
            
            [self loadFavrOBData];
            [self loadFavrData];
            
            
            isShown = NO;

        }
        else if (indexPath.row==9){
            HomeVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            objVC.strType=@"Sync";
            [self.navigationController pushViewController:objVC animated:YES];
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
    else if(tableView == _TblFvr){
        
        SpeciesDetailVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SpeciesDetailVC"];
        objVC.strID =[[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:0];
        objVC.strMainTitle = [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:1];
       
        [self.navigationController pushViewController:objVC animated:YES];
        
    }
    else{
        
        AddObseVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseVC"];
        objVC.strID =[[_arrFvrOb objectAtIndex:indexPath.row]objectAtIndex:5];
        objVC.strMainTitle = [[_arrFvrOb objectAtIndex:indexPath.row]objectAtIndex:0];
        objVC.ChkPage=@"FvrVC";
        [[NSUserDefaults standardUserDefaults] setObject:@"FvrVC" forKey:@"ChkPage"];
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
- (IBAction)BtnFvrSpe:(id)sender {
    
    _BtnFvrSpe.backgroundColor =[UIColor clearColor];
    _BtnFvrObs.backgroundColor =[UIColor lightGrayColor];
    _TblFvr.hidden = NO;
    _TblObser.hidden = YES;
   
    [self loadFavrData];
   
    
    NSString *str = @"FvrSpe";
    
    [[NSUserDefaults  standardUserDefaults]setObject:str forKey:@"ChkTbl"];
}
- (IBAction)BtnFvrObs:(id)sender {
    
    _BtnFvrObs.backgroundColor=[UIColor clearColor];
    _BtnFvrSpe.backgroundColor =[UIColor lightGrayColor];
    
    _TblFvr.hidden = YES;
    _TblObser.hidden = NO;
    
    [self loadFavrOBData];
    
    
    NSString *str = @"FvrObs";
    
    [[NSUserDefaults  standardUserDefaults]setObject:str forKey:@"ChkTbl"];
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
