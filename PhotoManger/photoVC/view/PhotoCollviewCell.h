//
//  PhotoCollviewCell.h
//  PhotoManger
//
//  Created by foscom on 16/6/18.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollviewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UIImageView *editView;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (nonatomic, copy) NSString *imageRemarkPath;

@end
