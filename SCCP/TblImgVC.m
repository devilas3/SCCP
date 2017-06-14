//
//  TblImgVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 04/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "TblImgVC.h"
#import "DBManager.h"
#import "SpeciesCell.h"
#import "ObserVC.h"
#import "AddObseImageVC.h"
#import "FvrVC.h"
#import "AddObseVC.h"

@interface TblImgVC (){
    
    int indexx;
}


@property(strong,nonatomic)DBManager *dbManager;
@property (strong,nonatomic) NSMutableArray *arrItem;

@end

@implementation TblImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self loadData];
    
    //[_BtnNewAddImg setToolTip:@"Sad face: Select this option for \"Very poor\""];
    
    
}

-(void)loadData{
    
    NSString *query = [NSString stringWithFormat:@"select * from ObsImages where Ob_id=\'%@\'",_strID];
    
    // Get the results.
    if (self.arrItem != nil) {
        self.arrItem = nil;
    }
    
    
    
    self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    
     [_TblImg reloadData];
    
    if([_arrItem count] == 0){
        
        _BlankView.hidden = NO;
        _TblImg.hidden = YES;
        
    }
    else{
        _BlankView.hidden = YES;
        _TblImg.hidden = NO;
    }

    
    
   
    
    
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma tableview method

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CellImg";
    
    SpeciesCell *objcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexPath.row] objectAtIndex:2]];
    objcell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    
    
    objcell.lblTitle.text = [[_arrItem objectAtIndex:indexPath.row]objectAtIndex:1];
    
    [objcell.btnfav addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
    [objcell.BtnEdit addTarget:self action:@selector(btnUpdate:) forControlEvents:UIControlEventTouchUpInside];
    
    return objcell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrItem.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
    return 120;
}
-(IBAction)btnUpdate:(UIButton *)btn{
    
    CGPoint touchPoint = [btn convertPoint:CGPointZero toView:_TblImg];
    NSIndexPath *clickedButtonIndexPath = [_TblImg indexPathForRowAtPoint:touchPoint];
    NSLog(@"index path.row ==%ld",(long)clickedButtonIndexPath.row);
    
    indexx = clickedButtonIndexPath.row;
    
    NSString *itemID;
    itemID=[NSString stringWithFormat:@"%@", [[self.arrItem objectAtIndex:indexx] objectAtIndex:0]];

    AddObseImageVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseImageVC"];
    objVC.ItemID=itemID;
    objVC.strID=_strID;
    objVC.strType=@"Edit";
    [self.navigationController pushViewController:objVC animated:YES];
    
    
    
   
    
}
-(IBAction)btnDelete:(UIButton *)btn{
    
    CGPoint touchPoint = [btn convertPoint:CGPointZero toView:_TblImg];
    NSIndexPath *clickedButtonIndexPath = [_TblImg indexPathForRowAtPoint:touchPoint];
    NSLog(@"index path.row ==%ld",(long)clickedButtonIndexPath.row);
    
    indexx = clickedButtonIndexPath.row;
    
    // NSInteger indexOfItemID = [self.dbManager.arrColumnNames indexOfObject:@"item_id"];
    NSString *strID;
    strID=[NSString stringWithFormat:@"%@", [[self.arrItem objectAtIndex:indexx] objectAtIndex:0]];
    
    int ItemID =[strID intValue];
    
    
    NSLog(@"%@",strID);
    
    
    for (indexx = 0; indexx < [_arrItem count]; indexx++) {
        
        if (ItemID == [[[_arrItem objectAtIndex:indexx]objectAtIndex:0] intValue]) {
            
            
            
            NSString *query;
            
            
            query = [NSString stringWithFormat:@"Delete from ObsImages where id=%d", ItemID];
            NSLog(@"query: %@", query);
            
            NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexx] objectAtIndex:2]];
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath: workSpacePath error: &error];
            
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
    
    [self loadData];
    
    
    
}
- (IBAction)BtnNewAddImg:(id)sender {
    
    AddObseImageVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseImageVC"];
    objVC.strID=_strID;
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

- (IBAction)BtnBack:(id)sender {
    
    if([_arrItem count] == 0){
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
    
 //   ObserVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ObserVC"];
//    [self.navigationController pushViewController:objVC animated:YES];
    
    AddObseVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddObseVC"];
    objVC.strID = [[_arrItem objectAtIndex:0]objectAtIndex:3];
    [self.navigationController pushViewController:objVC animated:YES];
    }
}


@end
