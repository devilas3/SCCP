//
//  AddObseVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "AddObseVC.h"
#import "DBManager.h"
#import "AddObseImageVC.h"
#import "TblImgVC.h"
#import "ImageCell.h"
#import "ImagesVC.h"
#import "MBProgressHUD.h"
#import "ObserVC.h"
#import "FvrVC.h"

@interface AddObseVC ()<UIAlertViewDelegate,UIScrollViewDelegate>{
    
    BOOL IsUpdate;
}

@property(strong,nonatomic)DBManager *dbManager;
@property (strong,nonatomic) NSString *strfav;
@property (strong,nonatomic) NSMutableArray *arrItem,*arrId,*arrDelete;
@property (strong,nonatomic) NSMutableArray *arrImages;

@property (strong,nonatomic) NSString *strDate;

@end

@implementation AddObseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    _txtTextView.layer.borderWidth=1;
    _txtTextView.layer.cornerRadius=10;
    _txtLoca.borderStyle = UITextBorderStyleNone;
    _txtName.borderStyle = UITextBorderStyleNone;
    
    
    
    
    NSDateFormatter *dateTime=[[NSDateFormatter alloc] init];
    [dateTime setDateFormat:@"dd-MM-yyyy  hh:mm:ss a"];
    _strDate=[dateTime stringFromDate:[NSDate date]];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"dd-MM-yyyy"];
    _lblDate.text=[date stringFromDate:[NSDate date]];
    
    NSLog(@"%@",[date stringFromDate:[NSDate date]]);
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSDateFormatter *Time=[[NSDateFormatter alloc] init];
    [Time setDateFormat:@"hh:mm:ss a"];
    _lblTime.text=[Time stringFromDate:[NSDate date]];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if([_strType isEqualToString:@"ADD"]){
        
        _Scrollview.hidden = NO;
        _AddView.hidden = NO;
        _OBDeatilView.hidden = YES;
        _ObScroll.hidden = YES;
        
        _BtnContinue.hidden= NO;
        _btnEditOb.hidden = YES;
        
    }
    else{
        
        _Scrollview.hidden = YES;

        _AddView.hidden = YES;
        _OBDeatilView.hidden = NO;
        _ObScroll.hidden = NO;
        _lblMainTitle.text=_strMainTitle;
        [self loadData];
        [self LoadImages];
        
    }
    
}
-(void)loadData{
    // Form the query.
    
    _lblMainTitle.text=_strMainTitle;

    NSString *query = [NSString stringWithFormat:@"select * from Observation where Ob_id=\'%@\'",_strID];
    
    // Get the results.
    if (self.arrItem != nil) {
        self.arrItem = nil;
    }
    
    
    
    self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.

    
    _lblMainTitle.text=[[_arrItem objectAtIndex:0]objectAtIndex:0];
    _lblObTitle.text =[[_arrItem objectAtIndex:0]objectAtIndex:0];
    _lblObDate.text =[[_arrItem objectAtIndex:0]objectAtIndex:1];
    _lblObLocation.text=[[_arrItem objectAtIndex:0]objectAtIndex:2];
    _txtObDesc.text =[[_arrItem objectAtIndex:0]objectAtIndex:3];
    
    NSLog(@"%@",[[_arrItem objectAtIndex:0]objectAtIndex:4]);
    _strfav = [[_arrItem objectAtIndex:0]objectAtIndex:4];
    
    if([_strfav isEqualToString:@"1"]){
        
        _BtnAddFav.hidden = YES;
        _BtnRmoveFvr.hidden = NO;
    }
    else{
        
        _BtnRmoveFvr.hidden = YES;
        _BtnAddFav.hidden = NO;
    }
    
//    self.ObScroll.delegate = self;
//    _ObScroll.contentSize = CGSizeMake(0, 2000);
//    
    if(IsUpdate == YES){
        
        CGRect frame = _txtObDesc.frame;
        frame.size.height = _txtObDesc.contentSize.height;
        
        _txtObDesc.frame = frame;
        
        _ObScroll.contentSize = CGSizeMake(_ObScroll.frame.size.width, _ObScroll.frame.size.height+frame.size.height+150);

    }
    else{
        CGRect frame = _txtObDesc.frame;
        frame.size.height = _txtObDesc.contentSize.height;
        
        _txtObDesc.frame = frame;
        
        _ObScroll.contentSize = CGSizeMake(_ObScroll.frame.size.width, _ObScroll.frame.size.height+frame.size.height);
    }
    
}

- (IBAction)BtnBack:(id)sender {
    
    NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"ChkPage"];
    
    if([str isEqualToString:@"ObserVC"]){
        
        ObserVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ObserVC"];
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else if([str isEqualToString:@"FvrVC"]){
        
        FvrVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FvrVC"];
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (IBAction)BtnContinue:(id)sender {
    
        
        NSString *errorMessage = [self validateForm];
        if (errorMessage) {
            [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
            return;
        }
        else{
            
            NSString *query = [NSString stringWithFormat:@"insert into Observation (Name,Date, Location, Description,favourite) values(\"%@\", \"%@\", \"%@\",\"%@\",\"%@\")",_txtName.text,_strDate,_txtLoca.text,_txtDesc.text,@"NULL"];
            // Execute the query.
            [self.dbManager executeQuery:query];
            
            // If the query was successfully executed then pop the view controller.
            if (self.dbManager.affectedRows != 0) {
                NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"your Observation has successfully added" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                [alert show];
                
                
                
                
            }
            else{
                NSLog(@"Could not execute the query.");
            }
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Observation Saved";
            hud.margin = 10.f;
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            
            _txtName.text=@"";
            _txtLoca.text=@"";
            _txtDesc.text=@"";
            
            AddObseImageVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseImageVC"];
            NSString *str=[NSString stringWithFormat:@"select MAX(Ob_id) from Observation"];
            self.arrId = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:str]];
            // Reload the table view.
            
            NSLog(@"%@",_arrId);
            
            objVC.strID=[[_arrId objectAtIndex:0]objectAtIndex:0];
            [self.navigationController pushViewController:objVC animated:YES];
        }
    
    
}

- (IBAction)btnEditOb:(id)sender {
    
    if(IsUpdate == YES){
        
        NSString *query;
        query = [NSString stringWithFormat:@"update Observation set Name=\'%@\', Date=\'%@\', Location=\'%@\',Description=\'%@\' where Ob_id=%@",_txtName.text,_strDate,_txtLoca.text,_txtDesc.text, _strID];
        
        // Execute the query.
        [self.dbManager executeQuery:query];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
            
            // Inform the delegate that the editing was finished.
            //[self.delegate editingInfoWasFinished];
            
            // Pop the view controller.
            //[self.navigationController popViewControllerAnimated:YES];
            
            
            
        }
        else{
            NSLog(@"Could not execute the query.");
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Successfully Updated";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:1.5];
        
        
        _txtName.text=@"";
        _txtLoca.text=@"";
        _txtDesc.text=@"";

        _OBDeatilView.hidden = NO;
        _ObScroll.hidden = NO;
        _AddView.hidden = YES;
        _Scrollview.hidden = YES;
        
        
        [self loadData];
        
        IsUpdate = YES;
        
        [_txtDesc resignFirstResponder];
       
//        [self viewDidLoad];
//        [self viewWillAppear:YES];
        
//        AddObseVC *ObjVC =[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseVC"];
//        [ObjVC.navigationController pushViewController:ObjVC animated:YES];
        
    }

}


- (NSString *)validateForm {
    NSString *errorMessage;
    
    if (!(self.txtName.text.length >= 1)){
        errorMessage = @"Please enter name";
    } else if (!(self.txtLoca.text.length >= 1)){
        errorMessage = @"Please enter location";
    }     
    return errorMessage;
}
-(void) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    //[textView resignFirstResponder];

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
   return YES;
}
/*- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _AddView.frame = CGRectMake(_AddView.frame.origin.x , (_AddView.frame.origin.y-200), _AddView.frame.size.width, _AddView.frame.size.height);
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _AddView.frame = CGRectMake(_AddView.frame.origin.x , (_AddView.frame.origin.y+200), _AddView.frame.size.width, _AddView.frame.size.height);
}*/
- (IBAction)BtnAddFav:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to add this observation as a favourite?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
    [alert show];
    
    _strfav = @"1";
    

    
}
- (IBAction)BtnRmoveFvr:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to remove this observation as your favourite?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
    [alert show];
    
    _strfav = @"0";
    
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
        
        [self GetFavourite];
        
        
    }
}
-(void)GetFavourite{
    
    if([_strfav isEqualToString:@"0"]){
        
        _BtnRmoveFvr.hidden = YES;
        _BtnAddFav.hidden = NO;

    }
    else{
        
        _BtnAddFav.hidden = YES;
        _BtnRmoveFvr.hidden = NO;

    }
    
    NSString *query;
    query = [NSString stringWithFormat:@"update Observation set favourite=\'%@\' where Ob_id=%@",_strfav, _strID];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        //[self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        //[self.navigationController popViewControllerAnimated:YES];
        
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}



- (IBAction)BtnEditObser:(id)sender {
    
    
    
    _txtName.text =_lblObTitle.text ;
    _txtLoca.text = _lblObLocation.text;
    _txtDesc.text = _txtObDesc.text;
    
    _ObScroll.hidden= YES;
    _AddView.hidden= NO;
    _Scrollview.hidden = NO;
    
    _BtnContinue.hidden= YES;
    _btnEditOb.hidden = NO;
    
    
    IsUpdate = YES;
    
}

- (IBAction)BtnEditObImage:(id)sender {
    
    TblImgVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblImgVC"];
    objVC.strID =_strID;
    [self.navigationController pushViewController:objVC animated:YES];
    
}

- (IBAction)BtnObDelete:(id)sender {
    NSString *queryDelete = [NSString stringWithFormat:@"select * from ObsImages where Ob_id=\'%@\'",_strID];
    
    // Get the results.
    if (self.arrDelete != nil) {
        self.arrDelete = nil;
    }
    
    
    
    self.arrDelete = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryDelete]];
    
    
    
    NSString *query;
    query = [NSString stringWithFormat:@"Delete from Observation where Ob_id=%@", _strID];
    
    NSString *query1;
    query1 = [NSString stringWithFormat:@"Delete from ObsImages where Ob_id=%@", _strID];
    
    for(int i=0; i<[_arrDelete count] ; i++){
        
        NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrDelete objectAtIndex:i] objectAtIndex:2]];
        NSError *error;
        
        [[NSFileManager defaultManager] removeItemAtPath: workSpacePath error: &error];
    }
    
    
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    [self.dbManager executeQuery:query1];

    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        //[self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
      //  [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    ObserVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"ObserVC"];
    [self.navigationController pushViewController:objVC animated:YES];
    
    
    
}
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
-(void)LoadImages{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select * from ObsImages where Ob_id=\'%@\'",_strID];
    
    // Get the results.
    if (self.arrImages != nil) {
        self.arrImages = nil;
    }
    
    
    
    self.arrImages = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    
    if(_arrImages.count == 1 || _arrImages.count == 0){
        
        _BtnNext.hidden = YES;
        _BtnPrevious.hidden = YES;
    }
    else{
        
        _BtnNext.hidden = NO;
        _BtnPrevious.hidden = NO;
    }
    
    
    if(_arrImages.count == 0){
        
        _lblNote.hidden = NO;
        
    }
    else{
        
        _lblNote.hidden = YES;
        
    }
    [_OBcollectionView reloadData];
    
    
}

#pragma CollectioView




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_arrImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell
    ImageCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellOb"
                                                                  forIndexPath:indexPath];
    
    
    CGRect frame = CGRectMake(0.0, 0.0, myCell.frame.size.width, myCell.frame.size.height);
    frame.origin = [myCell convertPoint:myCell.frame.origin toView:self.view];
    
    
    NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrImages objectAtIndex:indexPath.row] objectAtIndex:2]];
    myCell.ItemImage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    myCell.Title.text=[[_arrImages objectAtIndex:indexPath.row]objectAtIndex:1];
    
   
    //myCell.backgroundColor = [UIColor redColor];
    
    //   indexPath1 = [self.collectionView indexPathForCell:myCell];
    
    return myCell;
    
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImagesVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"ImagesVC"];
    objVC.strID=_strID;
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSString *my=[NSString stringWithFormat:@"%lu",indexPath.row];
    
    [[NSUserDefaults  standardUserDefaults]setObject:my forKey:@"indexx"];
    objVC.strType = @"ObsImages";
    
    [self.navigationController pushViewController:objVC animated:YES];
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*UIImage *image;
     long row = [indexPath row];
     
     image = [UIImage imageNamed:arrimage1[row]];*/
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    return CGSizeMake(frame.size.width, 280);
    
}
- (IBAction)BtnNext:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.OBcollectionView];
    NSIndexPath *indexPath = [self.OBcollectionView indexPathForItemAtPoint:buttonPosition];
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSLog(@"%lu",(unsigned long)[_arrImages count]);
    
    
    NSInteger Count = [_arrImages count];
    if(Count > indexPath.row+1){
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0];
        NSLog(@"%ld", (long)indexPath.row+1);
        
        
        [self.OBcollectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }else{
        
    }

}

- (IBAction)BtnPrevious:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.OBcollectionView];
    NSIndexPath *indexPath = [self.OBcollectionView indexPathForItemAtPoint:buttonPosition];
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    if(indexPath.row == 0)
    {
        
    }
    else{
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:0];
        NSLog(@"%ld", (long)indexPath.row-1);
        
        
        [self.OBcollectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
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
