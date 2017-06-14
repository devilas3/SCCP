//
//  TblSearchVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 02/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "TblSearchVC.h"
#import "DBManager.h"
#import "SpeciesCell.h"
#import "SpeciesDetailVC.h"


@interface TblSearchVC ()<UIAlertViewDelegate>


@property(strong,nonatomic)DBManager *dbManager;
@property (strong, nonatomic) NSMutableArray *arrItem;

@end

@implementation TblSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];

    if([_StrItem isEqualToString:@"TYPE"]){
        
        [self LoadKey];
    }
    else if([_StrItem isEqualToString:@"TYPE2"]){
        
        [self LoadKey2];
    }
    else if([_StrItem isEqualToString:@"TYPE3"]){
        
        [self LoadKey3];
    }
    else{
        
         [self LoadData];
    }
   
}

-(void)LoadKey3{
    
    if([_strTypeSub isEqualToString:@"ALL"]){
        
        NSString *query = [NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName, Sub.Name  from TblSpecies Sp,  TblSpeciesImage Im, SubSpecies1 Sub where Sp.nid == Im.nid  and Sp.nid == Sub.nid and  Im.ImageName like '%%.0.png' and Sp.%@ like '%%%@%%' and Sp.%@ like '%%%@%%' and Sp.%@ like '%%%@%%' group by Sp.nid order by Sp.title asc",_strType,_strKey,_strType2,_strKey2,_strType3,_strKey3];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
    }
    else{
        
        NSString *query = [NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName, Sub.Name  from TblSpecies Sp,  TblSpeciesImage Im, SubSpecies1 Sub where Sp.nid == Im.nid  and Sp.nid == Sub.nid and  Im.ImageName like '%%.0.png' and Sp.%@ like '%%%@%%' and Sp.%@ like '%%%@%%' and Sub.Name LIKE '%%%@' group by Sp.nid order by Sp.title asc",_strType,_strKey,_strType2,_strKey2,_strTypeSub];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
    }
    
    
    if([_arrItem count] == 0){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No Species found.Please try changing search filters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
}

-(void)LoadKey2{
    
    if([_strTypeSub isEqualToString:@"ALL"]){
        
        NSString *query = [NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName, Sub.Name  from TblSpecies Sp,  TblSpeciesImage Im, SubSpecies1 Sub where Sp.nid == Im.nid  and Sp.nid == Sub.nid and  Im.ImageName like '%%.0.png' and Sp.%@ like '%%%@%%' and Sp.%@ like '%%%@%%' group by Sp.nid order by Sp.title asc",_strType,_strKey,_strType2,_strKey2];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
    }
    else{
        
        NSString *query = [NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName, Sub.Name  from TblSpecies Sp,  TblSpeciesImage Im, SubSpecies1 Sub where Sp.nid == Im.nid  and Sp.nid == Sub.nid and  Im.ImageName like '%%.0.png' and Sp.%@ like '%%%@%%' and Sp.%@ like '%%%@%%' and Sub.Name LIKE '%%%@' group by Sp.nid order by Sp.title asc",_strType,_strKey,_strType2,_strKey2,_strTypeSub];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
    }
    
    
    if([_arrItem count] == 0){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No Species found.Please try changing search filters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    

}

-(void)LoadKey{
    
    if([_strTypeSub isEqualToString:@"ALL"]){
        
        NSString *query = [NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName, Sub.Name  from TblSpecies Sp,  TblSpeciesImage Im, SubSpecies1 Sub where Sp.nid == Im.nid  and Sp.nid == Sub.nid and  Im.ImageName like '%%.0.png' and Sp.%@ like '%%%@%%' group by Sp.nid order by Sp.title asc",_strType,_strKey];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        
    }
    else{
        
        NSString *query = [NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName, Sub.Name  from TblSpecies Sp,  TblSpeciesImage Im, SubSpecies1 Sub where Sp.nid == Im.nid  and Sp.nid == Sub.nid and  Im.ImageName like '%%.0.png' and Sp.%@ like '%%%@%%' and Sub.Name LIKE '%%%@' group by Sp.nid order by Sp.title asc",_strType,_strKey,_strTypeSub];
        
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);

    }
    
    
    if([_arrItem count] == 0){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No Species found.Please try changing search filters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    

}
-(void)LoadData{

        // Form the query.
    if([_strType isEqualToString:@"ALL"]){
        
        NSString *query = [NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName  from TblSpecies Sp,  TblSpeciesImage Im where Sp.nid == Im.nid  and  Im.ImageName like '%%.0.png' order by Sp.title asc"];
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
    }
    else{
        
        NSString *query =[NSString stringWithFormat:@"select Distinct Sp.nid ,Sp.title, Sp.genus , Sp.species, Sp.favourites, Im.ImageName , Sub.Name from TblSpecies Sp,  TblSpeciesImage Im , SubSpecies1 Sub where Sp.nid == Im.nid  and Sp.nid == Sub.nid and trim(Sub.Name) like '%@'  and Im.ImageName like '%%.0.png' group by Sp.nid order by Sp.title asc",_strType];
        // Get the results.
        if (self.arrItem != nil) {
            self.arrItem = nil;
        }
        
        // For Category
        _arrItem=[[NSMutableArray alloc]init];
        
        
        self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        
        NSLog(@"%@",_arrItem);
        

    }
        
    
}
#pragma tableview method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        static NSString *Identifier = @"MyCell";
        
        SpeciesCell *objcell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        
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

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SpeciesDetailVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SpeciesDetailVC"];
    objVC.strID=[[_arrItem objectAtIndex:indexPath.row]objectAtIndex:0];
    objVC.strMainTitle=[[_arrItem objectAtIndex:indexPath.row]objectAtIndex:1];
    [self.navigationController pushViewController:objVC animated:YES];
    
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Code for OK button
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (buttonIndex == 1)
    {
        //Code for download button
    }
}
- (IBAction)BtnBack:(id)sender {
    
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
