//
//  SearchVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "SearchVC.h"
#import "DBManager.h"
#import "SpeciesCell.h"
#import "HomeVC.h"
#import "FvrVC.h"
#import "ObserVC.h"
#import "AboutVC.h"
#import "NIDropDown.h"
#import "SideCell.h"
#import "TblSearchVC.h"


@interface SearchVC ()<NIDropDownDelegate>{
    
    BOOL isSlide;
    BOOL isShown;
    NIDropDown *dropDown;
    IBOutlet UIButton *btnDropDown;

}

@property(strong,nonatomic)DBManager *dbManager;

@property(strong,nonatomic)NSArray *arrName,*arrImg;

@property (weak, nonatomic) IBOutlet UIView *mainView;



@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    _arrName =[NSArray arrayWithObjects:@"About SCCP",@"Species",@"Search Species",@"Wildlife Tips",@"Amphibian ID Tips",@"Snail ID Tips",@"Conservation Status",@"My Observations",@"My Favourites",@"Sync",@"How To Use",@"Terms of Use",@"Sponsors", nil];
    _arrImg =[NSArray arrayWithObjects:@"About",@"Species",@"Search",@"WildLife",@"Amphibian",@"Snail",@"Conservation",@"Observation",@"favourite",@"Sync",@"HowToUse",@"TermsOfUse",@"Sponsors", nil];
    
    
    _txtKeyword.borderStyle=UITextBorderStyleNone;
    _txtCommon.borderStyle=UITextBorderStyleNone;
    _txtGenus.borderStyle=UITextBorderStyleNone;
    
    btnDropDown.layer.borderWidth = 1.0f;
    btnDropDown.layer.cornerRadius=10.0f;
    
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
            
            AboutVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
            objVC.strType=@"AboutUs";
            [self.navigationController pushViewController:objVC animated:YES];
            
            
        }
        else if (indexPath.row==1){
            
            HomeVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            [self.navigationController pushViewController:objVC animated:YES];
            
            
        }
        else if (indexPath.row==2){
            
            
            [UIView animateWithDuration:.25f delay:0.0 options:0
                             animations:^{
                                 [_tblSideView setFrame:CGRectMake(-screenRect.size.width-45, _tblSideView.frame.origin.y, _tblSideView.frame.size.width, _tblSideView.frame.size.height)];
                             }
                             completion:^(BOOL finished){
                             }];
            
            isShown = NO;

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
//SearchView
- (IBAction)btnSelectCategory:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"ALL", @"Vertebrates", @"Mammals", @"Birds",@"Fish",@"Reptiles", @"Amphibians",@"Invertebrates",@"Molluscs",@"Insects",@"Plants",@"Vascular plants",@"Non-vascular plants",@"Crustaceans",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    NSLog(@"%@", btnDropDown.titleLabel.text);
}

-(void)rel{
    dropDown = nil;
}

-(void)checkField{
    
    if(_txtKeyword.text.length > 0 && _txtCommon.text.length > 0 && _txtGenus.text.length > 0){
        
        /* not empty - do something */
        
        NSLog(@"ALL Query");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.StrItem = @"TYPE3";
        objVC.strType = @"title";
        objVC.strTypeSub=btnDropDown.titleLabel.text;
        objVC.strKey = _txtCommon.text;
        objVC.strKey2 = _txtGenus.text;
        objVC.strType2 = @"genus";
        objVC.strKey3 = _txtKeyword.text;
        objVC.strType3 = @"title";
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else if([_txtKeyword.text isEqualToString:@""] && [_txtCommon.text isEqualToString:@""] && ![_txtGenus.text isEqualToString:@""]){
        
        NSLog(@"Only Genus");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.StrItem = @"TYPE";
        objVC.strType = @"genus";
        objVC.strTypeSub=btnDropDown.titleLabel.text;
        objVC.strKey = _txtGenus.text;
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else if([_txtKeyword.text isEqualToString:@""] && ![_txtCommon.text isEqualToString:@""] && [_txtGenus.text isEqualToString:@""]){
        
        NSLog(@"Only Common");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.StrItem = @"TYPE";
        objVC.strType = @"title";
        objVC.strTypeSub=btnDropDown.titleLabel.text;
        objVC.strKey = _txtCommon.text;
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else if(![_txtKeyword.text isEqualToString:@""] && [_txtCommon.text isEqualToString:@""] && [_txtGenus.text isEqualToString:@""]){
        
        NSLog(@"Only Keyword");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.StrItem = @"TYPE";
        objVC.strType = @"title";
        objVC.strTypeSub=btnDropDown.titleLabel.text;
        objVC.strKey = _txtCommon.text;
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else if([_txtKeyword.text isEqualToString:@""] && [_txtCommon.text isEqualToString:@""] && [_txtGenus.text isEqualToString:@""]){
        
        NSLog(@"Only DropDown ");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.strType = btnDropDown.titleLabel.text;
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else if ([_txtKeyword.text isEqualToString:@""] && ![_txtCommon.text isEqualToString:@""] && ![_txtGenus.text isEqualToString:@""]){
        
        NSLog(@"Common nd Genus");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.StrItem = @"TYPE2";
        objVC.strType = @"title";
        objVC.strTypeSub=btnDropDown.titleLabel.text;
        objVC.strKey = _txtCommon.text;
        objVC.strKey2 = _txtGenus.text;
        objVC.strType2 = @"genus";
        [self.navigationController pushViewController:objVC animated:YES];
        
    }
    else if (![_txtKeyword.text isEqualToString:@""] && [_txtCommon.text isEqualToString:@""] && ![_txtGenus.text isEqualToString:@""]){
        
        NSLog(@"Keyword nd Genus");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.StrItem = @"TYPE2";
        objVC.strType = @"title";
        objVC.strTypeSub=btnDropDown.titleLabel.text;
        objVC.strKey = _txtKeyword.text;
        objVC.strKey2 = _txtGenus.text;
        objVC.strType2 = @"genus";
        [self.navigationController pushViewController:objVC animated:YES];
        
    }
    else if (![_txtKeyword.text isEqualToString:@""] && ![_txtCommon.text isEqualToString:@""] && [_txtGenus.text isEqualToString:@""]){
        
        NSLog(@"Common nd Keyword");
        
        TblSearchVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblSearchVC"];
        objVC.StrItem = @"TYPE2";
        objVC.strType = @"title";
        objVC.strTypeSub=btnDropDown.titleLabel.text;
        objVC.strKey = _txtKeyword.text;
        objVC.strKey2 = _txtCommon.text;
        objVC.strType2 = @"title";
        [self.navigationController pushViewController:objVC animated:YES];
        
    }


    
}

- (IBAction)BtnSearch:(id)sender {
    
    [self checkField];
    
}
-(void) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}
//- (BOOL)textFieldDidBeginEditing:(UITextField *)textField
//{
//            _mainView.frame = CGRectMake(_mainView.frame.origin.x , (_mainView.frame.origin.y-120), _mainView.frame.size.width, _mainView.frame.size.height);
//
//    return YES;
//}
//
//- (BOOL)textFieldDidEndEditing:(UITextField *)textField
//{
//    
//    _mainView.frame = CGRectMake(_mainView.frame.origin.x , (_mainView.frame.origin.y+120), _mainView.frame.size.width, _mainView.frame.size.height);
//    
//    return YES;
//}
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
