//
//  SpeciesCell.h
//  SCCP
//
//  Created by Jimit Bagadiya on 20/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeciesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblsubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblsubtitle2;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btnfav;
@property (weak, nonatomic) IBOutlet UIButton *BtnEdit;

@end
