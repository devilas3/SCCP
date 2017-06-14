//
//  SpeciesDetailVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 20/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "SpeciesDetailVC.h"
#import "SpeciesCell.h"
#import "ImageCell.h"
#import "ImagesVC.h"
#import "DetailVC.h"
#import "DBManager.h"
#import "STCollapseTableView.h"
#import "HomeVC.h"

@interface SpeciesDetailVC ()<UIAlertViewDelegate>


@property (nonatomic) NSIndexPath *expandIndexPath;
    

@property (nonatomic, strong) DBManager *dbManager;

@property (strong, nonatomic) NSMutableArray *arrItem,*arrfv;

@property (strong,nonatomic) NSMutableArray *arrImages;

@property (strong,nonatomic) NSString *strfav;


@property (nonatomic) CGFloat lastContentOffset;



@property (weak, nonatomic) IBOutlet STCollapseTableView *tblView;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *subarr;
@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;
@property (nonatomic,strong) NSString *strType,*strHabitat,*strdiet,*strlife,*strrange,*strSimilar,*strThreat,*strConv,*strsourse,*strCredit,*strDesc;
@end

@implementation SpeciesDetailVC


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    
    
    NSLog(@"%@",_dicData);
    
    _lblMaintitle.text = _strMainTitle;
    
    

    
    [self loadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.tblView reloadData];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Initialize the dbManager property.
        self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];

       // [self temp];
        [self setupViewController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Initialize the dbManager property.
        self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];

       // [self temp];
        [self setupViewController];
    }
    return self;
}
/*-(void)temp{
    
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select title,nid from TblSpecies"];
    
    // Get the results.
    if (self.arr != nil) {
        self.arr = nil;
    }
    
    // For Category
    
    self.arr = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    NSLog(@"%@",_arr);
    
}
- (void)setupViewController
{

    
    NSString *strid;
    
    NSLog(@"%@",_arr);
    NSLog(@"%@",_subarr);
    
    self.data = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [_arr count] ; i++)
    {
        strid =[[_arr objectAtIndex:i]objectAtIndex:1];
        
        // Form the query.
        NSString *query = [NSString stringWithFormat:@"select ImageName, nid from TblSpeciesImage  where nid=\'%@\'",strid];
        
        // Get the results.
        if (self.subarr != nil) {
            self.subarr = nil;
        }
        
        // For Category
        
        self.subarr = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        // Reload the table view.
        

        NSMutableArray* section = [[NSMutableArray alloc] init];
        for (int j = 0 ; j < [_subarr count] ; j++)
        {
            //[section addObject:[NSString stringWithFormat:@"Cell n°%i", j]];
            [section addObject:[[_arr objectAtIndex:j]objectAtIndex:1]];
        }

        
        [self.data addObject:_subarr];
    }
    
    self.headers = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [_arr count] ; i++)
    {
       // UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
       // [header setBackgroundColor:[_arr objectAtIndex:i]];
        
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tblView.frame.size.width, 44)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 0, 0)];
                label.text = [[_arr objectAtIndex:i]objectAtIndex:0];
                label.font = [UIFont boldSystemFontOfSize:18];
                // label.textColor = [UIColor colorWithRed:159.0f/255.0f green:150.0f/255.0f blue:152.0f/255.0f alpha:1.0];
                label.textColor =[UIColor darkGrayColor];
                label.backgroundColor = [UIColor clearColor];
                [label sizeToFit];
                
                [header addSubview:label];

        [self.headers addObject:header];
    }

    
}*/

- (void)setupViewController
{
    _subarr =[NSArray arrayWithObjects:@"Habitat",@"Diet", @"Life Cycle",@"Range", nil];
    _arr =[NSArray arrayWithObjects:@"Status",@"Characteristics",@"Ecology",@"Similar Species",@"Threats",@"Conservation & Management",@"Sources",@"Credits",@"Go to Website", nil];
    
        self.data = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [_arr count] ; i++)
    {
        
        
        [self.data addObject:_subarr];
    }
    
    self.headers = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [_arr count] ; i++)
    {
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tblView.frame.size.width, 44)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 0, 0)];
        label.text = [_arr objectAtIndex:i];
        label.font = [UIFont boldSystemFontOfSize:18];
        // label.textColor = [UIColor colorWithRed:159.0f/255.0f green:150.0f/255.0f blue:152.0f/255.0f alpha:1.0];
        label.textColor =[UIColor darkGrayColor];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        

        if(i == 2){
            
            [header addSubview:label];
            
        }
        else{
   
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        
       // [button setTitle:@"Show View" forState:UIControlStateNormal];
        button.frame = CGRectMake(0.0, 0.0, 420.0, 40.0);
        button.backgroundColor=[UIColor clearColor];
        
        
        [header addSubview:label];
        [header addSubview:button];
        
        }
        
        [self.headers addObject:header];
    }
}
-(void) aMethod:(UIButton*)sender
{
    NSLog(@"you clicked on button %ld", (long)sender.tag);
    
    if(sender.tag == 0){
        
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strID = _strID;
            objVC.strMainTitle = @"Status";
            objVC.strType = @"Status";
            
            [self.navigationController pushViewController:objVC animated:YES];
    }
    else if(sender.tag == 1){
        
        if([_strDesc isEqualToString:@"<null>"] || [_strDesc isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry no current data exists for this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strID = _strID;
            objVC.strMainTitle = @"Characteristics";
            objVC.strType = @"description";
            
            [self.navigationController pushViewController:objVC animated:YES];
            
        }
    }
    else if(sender.tag == 3){
        
        if([_strSimilar isEqualToString:@"<null>"] || [_strSimilar isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry no current data exists for this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strID = _strID;
            objVC.strMainTitle = @"Similar Species";
            objVC.strType = @"similarValue";
            objVC.strTbl = @"SimilarImage";
            [self.navigationController pushViewController:objVC animated:YES];

            
        }
        
        
    }
    else if(sender.tag == 4){
        
        NSLog(@"%@",_strThreat);
        
        
        if([_strThreat isEqualToString:@"<null>"] || [_strThreat isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry no current data exists for this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strID = _strID;
            objVC.strMainTitle = @"Threats";
            objVC.strType = @"threats";
            
            [self.navigationController pushViewController:objVC animated:YES];

            
        }
        
    }
    else if(sender.tag == 5){
        
        
        if([_strConv isEqualToString:@"<null>"] || [_strConv isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry no current data exists for this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strID = _strID;
            objVC.strMainTitle = @"Conservation & Management";
            objVC.strType = @"conservation";
            
            [self.navigationController pushViewController:objVC animated:YES];

            
        }
        
    }
    
    else if(sender.tag == 6){
        
        if([_strsourse isEqualToString:@"<null>"] || [_strsourse isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry no current data exists for this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strID = _strID;
            objVC.strMainTitle = @"Sources";
            objVC.strType = @"sources";
            
            [self.navigationController pushViewController:objVC animated:YES];

        }
        
    }
    else if(sender.tag == 7){
        
        if([_strCredit isEqualToString:@"<null>"] || [_strCredit isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry no current data exists for this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strID = _strID;
            objVC.strMainTitle = @"Credits";
            objVC.strType = @"credits";
            
            [self.navigationController pushViewController:objVC animated:YES];

            
        }
        
    }
    else if(sender.tag == 8){
        
        NSLog(@"Website Open");
        
        NSString* str = [_lblMaintitle.text stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        NSString* str1 = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSString *strUrl =[NSString stringWithFormat:@"http://sccp.ca/species-habitat/%@",str1];

        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    }

    
    
}
-(void)loadData{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select ImageName, Title , nid from TblSpeciesImage where nid=\'%@\'",_strID];
    
    // Get the results.
    if (self.arrItem != nil) {
        self.arrItem = nil;
    }
    
    // For Category
    
    self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    
    if(_arrItem.count == 1 || _arrItem.count == 0){
        
        _BtnNext.hidden = YES;
        _BtnPrevious.hidden = YES;
    }
    else{
        
        _BtnNext.hidden = NO;
        _BtnPrevious.hidden = NO;
    }

    
    NSString *query1 = [NSString stringWithFormat:@"select favourites,Habitat,diet,life_cycle,Range,similarValue,threats,conservation,sources,credits,description from TblSpecies where nid=\'%@\'",_strID];
    
    // Get the results.
    if (self.arrfv != nil) {
        self.arrfv = nil;
    }
    
    // For Category
    
    self.arrfv = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query1]];
    // Reload the table view.
    
    NSLog(@"%@",[[_arrfv objectAtIndex:0]objectAtIndex:0]);
    _strfav = [[_arrfv objectAtIndex:0]objectAtIndex:0];
    
    if([_strfav isEqualToString:@"1"]){
        
        _BtnAddFav.hidden = YES;
        _BtnRemoveFav.hidden = NO;
    }
    else{
        
        _BtnRemoveFav.hidden = YES;
        _BtnAddFav.hidden = NO;
    }
    
    _strHabitat =[[_arrfv objectAtIndex:0]objectAtIndex:1];
    _strdiet =[[_arrfv objectAtIndex:0]objectAtIndex:2];
    _strlife =[[_arrfv objectAtIndex:0]objectAtIndex:3];
    _strrange =[[_arrfv objectAtIndex:0]objectAtIndex:4];
    _strSimilar =[[_arrfv objectAtIndex:0]objectAtIndex:5];
    _strThreat =[[_arrfv objectAtIndex:0]objectAtIndex:6];
    _strConv =[[_arrfv objectAtIndex:0]objectAtIndex:7];
    _strsourse =[[_arrfv objectAtIndex:0]objectAtIndex:8];
    _strCredit =[[_arrfv objectAtIndex:0]objectAtIndex:9];
    _strDesc =[[_arrfv objectAtIndex:0]objectAtIndex:10];
    
    [_tblView reloadData];
    
}
#pragma :- Table Methods



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *footerView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    footerView.contentView.backgroundColor = [UIColor colorWithRed:222.0f/255.0f green:222.0f/255.0f blue:222.0f/255.0f alpha:1.0f];
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

#pragma tableview method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CellItem";
    
    SpeciesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    
//    if (!cell)
//    {
//        cell = [[SpeciesCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//    }
    
    
    
   // NSString* text = [[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]objectAtIndex:0];
    //cell.textLabel.text = text;
    NSString* text = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.lblTitle.text = text;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 //    return [[self.data objectAtIndex:section] count];
    if(section == 2){
        
        return 4;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    return [self.headers objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    

    if(indexPath.row == 0){
        
        if([_strHabitat isEqualToString:@"<null>"] || [_strHabitat isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The Habitat data is not available for this species" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];

        }
        else{
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strMainTitle = @"Habitat";
            objVC.strID = _strID;
            
            objVC.strType = @"Habitat";
            
            [self.navigationController pushViewController:objVC animated:YES];
        }
    }
    if(indexPath.row == 1){
        
        if([_strdiet isEqualToString:@"<null>"] || [_strdiet isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The Diet data is not available for this species" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strMainTitle = @"Diet";
            objVC.strID = _strID;
            
            objVC.strType = @"diet";
            [self.navigationController pushViewController:objVC animated:YES];

        }
    }
    
    else if(indexPath.row == 2){
        
        if([_strlife isEqualToString:@"<null>"] || [_strlife isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The Life Cycle data is not available for this species" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strMainTitle = @"Life Cycle";
            objVC.strID = _strID;
            
            objVC.strType = @"life_cycle";
            objVC.strTbl = @"LifeImage";
            [self.navigationController pushViewController:objVC animated:YES];
            
        }
        
    }
    else if(indexPath.row == 3){
        
        if([_strrange isEqualToString:@"<null>"] || [_strrange isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The Range data is not available for this species" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        
        else{
        
            DetailVC *objVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            objVC.strMainTitle = @"Range";
            objVC.strID = _strID;
            
            objVC.strType = @"Range";
            objVC.strTbl = @"RangeImage";
            [self.navigationController pushViewController:objVC animated:YES];
        }
    }
    
    
}



#pragma CollectioView




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_arrItem count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell
    ImageCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                                                          forIndexPath:indexPath];
    
    
    CGRect frame = CGRectMake(0.0, 0.0, myCell.frame.size.width, myCell.frame.size.height);
    frame.origin = [myCell convertPoint:myCell.frame.origin toView:self.view];
    
    
    NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:indexPath.row] objectAtIndex:0]];
    myCell.ItemImage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    myCell.Title.text=[[_arrItem objectAtIndex:indexPath.row]objectAtIndex:1];
    myCell.ItemImage.contentMode = UIViewContentModeScaleAspectFit;
    /* UIImage *image;
     long row = [indexPath row];
     
     image = [UIImage imageNamed:_arrimage[row]];
     
     myCell.img.image = image;*/
    
  //  myCell.ItemImage.image = [UIImage imageNamed:self.arrImage[indexPath.item]];
    //myCell.backgroundColor = [UIColor redColor];
    
//   indexPath1 = [self.collectionView indexPathForCell:myCell];
    
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
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSString *my=[NSString stringWithFormat:@"%lu",indexPath.row];
    
    [[NSUserDefaults  standardUserDefaults]setObject:my forKey:@"indexx"];
    
    
    [self.navigationController pushViewController:objVC animated:YES];
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*UIImage *image;
     long row = [indexPath row];
     
     image = [UIImage imageNamed:arrimage1[row]];*/
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    return CGSizeMake(frame.size.width, 200);
    
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


- (IBAction)BtnAddFav:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to add this species as a favourite?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
    [alert show];
    
    _strfav = @"1";

    
}

-(void)GetFavourite{
    
    if([_strfav isEqualToString:@"0"]){
        
        _BtnRemoveFav.hidden = YES;
        _BtnAddFav.hidden = NO;

    }
    else{
        
        _BtnAddFav.hidden = YES;
        _BtnRemoveFav.hidden = NO;

        
    }
    NSString *query;
    query = [NSString stringWithFormat:@"update TblSpecies set favourites=\'%@\' where nid=%@",_strfav, self.strID];
    
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
- (IBAction)BtnRemoveFav:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to remove this species as your favourite?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
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
//- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath
//               atScrollPosition:(UICollectionViewScrollPosition)scrollPosition
//                       animated:(BOOL)animated;{
//    
//    
//    
//    NSLog(@"%ld", (long)indexPath.row);
//    
//    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0];
//    NSLog(@"%ld", (long)indexPath.row+1);
//
//    
//    [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
//    
//}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [_tblView reloadSectionIndexTitles];
}
//- (void)scrollViewDidScroll:(UICollectionView *)scrollView
//{
//    if (scrollView == self.tblView)
//    {
//        
//        NSLog(@"manali");
//        
//        [_tblView reloadSectionIndexTitles];
//        
//     //   [self.tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//          //  [self.tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//
//        
//    }
//    
//    if (self.lastContentOffset > scrollView.contentOffset.x)
//    {
//        NSLog(@"Scrolling left");
//    }
//    else if (self.lastContentOffset < scrollView.contentOffset.x)
//    {
//        NSLog(@"Scrolling right");
//    }
//    self.lastContentOffset = scrollView.contentOffset.x;
//}

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

- (IBAction)BtnNext:(id)sender {
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSLog(@"%lu",(unsigned long)[_arrItem count]);
    
    
    NSInteger Count = [_arrItem count];
    if(Count > indexPath.row+1){
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0];
    NSLog(@"%ld", (long)indexPath.row+1);
    
    
    [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }else{
        
    }

}

- (IBAction)BtnShare:(id)sender {
    
    NSLog(@"shareButton pressed");
    
    NSString* str = [_lblMaintitle.text stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSString* str1 = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *texttoshare =[NSString stringWithFormat:@"Please check out this species-%@ \nlink- http://sccp.ca/species-habitat/%@",_lblMaintitle.text,str1];
    
    // UIImage *imagetoshare = @"image";
    NSArray *activityItems = @[texttoshare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    
    [activityVC setValue:@"SCCP iOS Application" forKey:@"subject"];
    
    activityVC.popoverPresentationController.sourceView = self.view;
    activityVC.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height-50, 1.0, 1.0);
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    

}
@end
