//
//  ImageCell.h
//  SCCP
//
//  Created by Jimit Bagadiya on 20/01/17.
//  Copyright © 2017 Jimit Bagadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ItemImage;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@end
