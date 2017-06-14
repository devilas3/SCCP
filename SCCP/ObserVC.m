//
//  ObserVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "ObserVC.h"
#import "DBManager.h"
#import "FvrVC.h"
#import "SpeciesCell.h"
#import "HomeVC.h"
#import "SearchVC.h"
#import "AboutVC.h"
#import "AddObseVC.h"
#import "SideCell.h"


@interface ObserVC (){
    
    BOOL isSlide;
    BOOL isShown;
    int indexx;
    
}


@property(strong,nonatomic)NSArray *arrName,*arrImg;
@property(strong,nonatomic)DBManager *dbManager;
@property (strong, nonatomic) NSMutableArray *arrFvrItem,*arrItem;


@end

@implementation ObserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    _arrName =[NSArray arrayWithObjects:@"About SCCP",@"Species",@"Search Species",@"Wildlife Tips",@"Amphibian ID Tips",@"Snail ID Tips",@"Conservation Status",@"My Observations",@"My Favourites",@"Sync",@"How To Use",@"Terms of Use",@"Sponsors", nil];
    _arrImg =[NSArray arrayWithObjects:@"About",@"Species",@"Search",@"WildLife",@"Amphibian",@"Snail",@"Conservation",@"Observation",@"favourite",@"Sync",@"HowToUse",@"TermsOfUse",@"Sponsors", nil];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self loadFavrData];
    
    [self loadImage];
}
-(void)loadFavrData{
    // Form the query.
    
    [self loadImage];
    
//    NSString *query =[NSString stringWithFormat:@"select ob.*,Im.Image from Observation ob, ObsImages Im where ob.Ob_id == Im.Ob_id  group by ob.Ob_id"];
    
    
    
     NSString *query =[NSString stringWithFormat:@"select * from Observation"];
    // Get the results.
    if (self.arrFvrItem != nil) {
        self.arrFvrItem = nil;
    }
    
    // For Category
    _arrFvrItem=[[NSMutableArray alloc]init];
   
    
    self.arrFvrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    NSLog(@"%@",_arrFvrItem);
    
    
    
    for(int i = 0; i<[_arrFvrItem count] ; i++){
        
        NSString *str=[[_arrFvrItem objectAtIndex:i]objectAtIndex:5];
        
        
        [[_arrFvrItem objectAtIndex:i] insertObject:@"NULL" atIndex:6];

        
        for (int j=0; j<[_arrItem count]; j++) {
            NSString *str1=[[_arrItem objectAtIndex:j]objectAtIndex:1];
            
            if([str isEqualToString:str1]){
                
               NSString *strImg=[[_arrItem objectAtIndex:j]objectAtIndex:0];
                
                
                [[_arrFvrItem objectAtIndex:i] replaceObjectAtIndex:6 withObject:strImg];
            }
            
        }
    }
    
    
    [_TblObser reloadData];
    
    if([_arrFvrItem count] == 0){
        
        _BlankView.hidden = NO;
        _TblObser.hidden = YES;
    }
    else{
        
        _BlankView.hidden = YES;
        _TblObser.hidden = NO;
    }

}
-(void)loadImage{
    // Form the query.

    
    //    NSString *query =[NSString stringWithFormat:@"select ob.*,Im.Image from Observation ob, ObsImages Im where ob.Ob_id == Im.Ob_id  group by ob.Ob_id"];
   // select image,Ob_id from ObsImages group by Ob_id
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
    if(_TblObser == tableView){
        
        return _arrFvrItem.count;
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
    else{
        
        static NSString *Identifier = @"CellObse";
        
        SpeciesCell *objcell = [_TblObser dequeueReusableCellWithIdentifier:Identifier];
        
        if (objcell==nil) {
            objcell = [[SpeciesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        
        
       
        NSString *str=[[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:6];
        if([str isEqualToString:@"NULL"]){
            
             objcell.img.image = [UIImage imageNamed:@"ic_launcher.png"];
        }
        else{
            
            NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrFvrItem objectAtIndex:indexPath.row] objectAtIndex:6]];
            objcell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];

        }
        


        objcell.lblTitle.text = [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:0];
        objcell.lblsubtitle.text = [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:2];
        
        NSString *strdate= [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:1];
        
        NSArray *arr=[strdate componentsSeparatedByString:@" "];
        
        objcell.lblsubtitle2.text = [arr objectAtIndex:0];
        
        NSString *strfav =[[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:4];
        
        if([strfav isEqualToString:@"1"]){
            
            objcell.btnfav.hidden = NO;
        }
        else{
            
            objcell.btnfav.hidden = YES;
        }
        
        
        
        return objcell;
        
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
    if (_TblObser == tableView){
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
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            
            isShown = NO;

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
        
        AddObseVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseVC"];
        objVC.strID =[[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:5];
       NSString *str = [[_arrFvrItem objectAtIndex:indexPath.row]objectAtIndex:0];
        objVC.strMainTitle=str;
        objVC.ChkPage = @"ObserVC";
        [[NSUserDefaults standardUserDefaults] setObject:@"ObserVC" forKey:@"ChkPage"];
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

- (IBAction)BtnFvrObs:(id)sender {
    
    AddObseVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseVC"];
    objVC.strType=@"ADD";
    [[NSUserDefaults standardUserDefaults] setObject:@"ObserVC" forKey:@"ChkPage"];
    [self.navigationController pushViewController:objVC animated:YES];

    
   
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
