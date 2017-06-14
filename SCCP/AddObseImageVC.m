//
//  AddObseImageVC.m
//  SCCP
//
//  Created by Jimit Bagadiya on 03/02/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import "AddObseImageVC.h"
#import "ObserVC.h"
#import "DBManager.h"
#import "TblImgVC.h"
#import "MBProgressHUD.h"


@interface AddObseImageVC ()<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    
    BOOL IsImage;
    int Count;
    BOOL IsUpdate;
    
}


@property(strong,nonatomic)DBManager *dbManager;
@property (strong,nonatomic) NSMutableArray *arrItem,*arrCh;

@property(strong,nonatomic) NSString *savedImagePath,*strImageName;
@property(strong,nonatomic) NSString *strUpImgName;


@end

@implementation AddObseImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SCCPDB.sqlite"];

    _txtName.borderStyle = UITextBorderStyleNone;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    if([_strType isEqualToString:@"Edit"]){
        
        _BtnEdit.hidden = NO;
        _BtnSave.hidden = YES;
        _BtnAnotherImage.hidden = YES;
        
        [self UpdateData];
        
        
    }
    else{
        
        _BtnEdit.hidden = YES;
        _BtnSave.hidden = NO;
        _BtnAnotherImage.hidden = NO;
    }
    
    
}

-(void)CheckImage{
    
    NSString *query = [NSString stringWithFormat:@"select * from ObsImages where Ob_id=\'%@\'",_strID];
    
    // Get the results.
    if (self.arrCh != nil) {
        self.arrCh = nil;
    }
    
    self.arrCh = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    
    if([_arrCh count] == 0){
        
    }
    else{
        //last object of data show then cout nd update then add images
        
        
        int CountId = [_arrCh count];
      
        NSString*str=[[_arrCh objectAtIndex:CountId-1]objectAtIndex:2];
        
        
        NSArray *items = [str componentsSeparatedByString:@"."];   //take the one array for split the string
        
        //shows Description
        NSString *str1=[items objectAtIndex:1];   //Shows Data
        
        Count=[str1 intValue];

        IsImage = YES;
        
    }

}
-(void)UpdateData{
    
    
    NSString *query = [NSString stringWithFormat:@"select * from ObsImages where Ob_id=\'%@\' and id=\'%@\'",_strID,_ItemID];
    
    // Get the results.
    if (self.arrItem != nil) {
        self.arrItem = nil;
    }
    
    self.arrItem = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    // Reload the table view.
    
    [_BtnAddImage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    _txtName.text=[[_arrItem objectAtIndex:0]objectAtIndex:1];
    NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[[_arrItem objectAtIndex:0] objectAtIndex:2]];
    _imgView.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    
    _strUpImgName=[[_arrItem objectAtIndex:0]objectAtIndex:2];
    
    _strType=@"";
    
    IsUpdate = YES;
    
    
    
    
}

- (IBAction)BtnAddImage:(id)sender {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Select image from" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"From library",@"From camera", nil];
    
    [action showInView:self.view];
    
}

#pragma mark - ActionSheet delegates

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 0 ) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }else if( buttonIndex == 1 ) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:picker animated:YES completion:nil];

        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentModalViewController:pickerView animated:YES];
        
        
    }
}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    _imgView.image = image;
    
     [_BtnAddImage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    if(IsUpdate == YES){
        
        [self GetUpdateImg];
        
        _strType =@"Edit";
    }
    else{
          [self GetImage];
    }
  
    
    
}
-(void)GetUpdateImg{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    _strImageName=[NSString stringWithFormat:@"%@", _strUpImgName];
    _savedImagePath = [documentsDirectory stringByAppendingPathComponent:_strImageName];
    UIImage *Myimage = _imgView.image; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(Myimage);
    [imageData writeToFile:_savedImagePath atomically:NO];
    
    IsUpdate = YES;

}
-(void)GetImage{
    
    
    [self CheckImage];
    
    if(IsImage == YES){
    
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        _strImageName=[NSString stringWithFormat:@"Ob_%@.%d.png",_strID,Count+1];
        _savedImagePath = [documentsDirectory stringByAppendingPathComponent:_strImageName];
        UIImage *Myimage = _imgView.image; // imageView is my image from camera
        NSData *imageData = UIImagePNGRepresentation(Myimage);
        [imageData writeToFile:_savedImagePath atomically:NO];

        
    }else{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        _strImageName=[NSString stringWithFormat:@"Ob_%@.png",_strID ];
        _savedImagePath = [documentsDirectory stringByAppendingPathComponent:_strImageName];
        UIImage *Myimage = _imgView.image; // imageView is my image from camera
        NSData *imageData = UIImagePNGRepresentation(Myimage);
        [imageData writeToFile:_savedImagePath atomically:NO];

    }
    
   
}

-(void)InsertImageData{
    
        NSString *query = [NSString stringWithFormat:@"insert into ObsImages (Name, Image, Ob_id) values(\"%@\", \"%@\", \"%@\")",_txtName.text,_strImageName,_strID];
        // Execute the query.
        [self.dbManager executeQuery:query];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Image Successfully added" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Image Saved";
            hud.margin = 10.f;
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hideAnimated:YES afterDelay:1.5];

            
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    
    
}
-(void)insertUpdateData{
    
    NSString *query;
    query = [NSString stringWithFormat:@"update ObsImages set Name=\'%@\',Image=\'%@\' where Ob_id=%@ and id=%@", _txtName.text,_strUpImgName,_strID,_ItemID];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        //[self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        //[self.navigationController popViewControllerAnimated:YES];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Image Successfully Updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Image Updated";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:1.5];

    }
    else{
        NSLog(@"Could not execute the query.");
    }
    

}
- (IBAction)BtnSave:(id)sender {
    
    NSString *errorMessage = [self validateForm];
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return;
    }
    else{
//        if(IsUpdate == YES){
//            
//            [self insertUpdateData];
//            TblImgVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblImgVC"];
//            objVC.strID=_strID;
//            [self.navigationController pushViewController:objVC animated:YES];
//
//        }
//        else{
    
            [self InsertImageData];
        
        _imgView.image=[UIImage imageNamed:@""];
        _txtName.text =@"";
        
            TblImgVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblImgVC"];
            objVC.strID=_strID;
            [self.navigationController pushViewController:objVC animated:YES];
        
        
       

    }
}

- (IBAction)BtnAnotherImage:(id)sender {
    
    NSString *errorMessage = [self validateForm];
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return;
    }
    else{
        
//        if(IsUpdate == YES){
//            [self insertUpdateData];
//            
//            [_BtnAddImage setImage:[UIImage imageNamed:@"AddImage"] forState:UIControlStateNormal];
//            
//            _imgView.image=[UIImage imageNamed:@""];
//            _txtName.text =@"";
//            IsImage = YES;
//            IsUpdate = NO;
//        }
//        else{
        
            [self InsertImageData];
            
             [_BtnAddImage setImage:[UIImage imageNamed:@"AddImage"] forState:UIControlStateNormal];
            
            _imgView.image=[UIImage imageNamed:@""];
            _txtName.text =@"";
            IsImage = YES;
        }
        
    
}

- (NSString *)validateForm {
    NSString *errorMessage;
    
    if (!(self.txtName.text.length >= 1)){
        errorMessage = @"Please enter name";
    } else if (_imgView.image == nil && _imgView.image == NULL){
        errorMessage = @"Please select image";
    }
    return errorMessage;
}

-(void) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (IBAction)BtnBack:(id)sender {
    
    
    ObserVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ObserVC"];
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



- (IBAction)BtnEdit:(id)sender {
    
    [self GetUpdateImg];
    
    [self insertUpdateData];
    TblImgVC *objVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TblImgVC"];
    objVC.strID=_strID;
    [self.navigationController pushViewController:objVC animated:YES];
}
@end
