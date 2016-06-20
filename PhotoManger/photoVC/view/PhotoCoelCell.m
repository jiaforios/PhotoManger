//
//  PhotoCoelCell.m
//  PhotoManger
//
//  Created by foscom on 16/6/20.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "PhotoCoelCell.h"

@implementation PhotoCoelCell


- (UIImageView *)photoView
{
    if (_photoView == nil) {
        
        _photoView = [[UIImageView alloc] initWithFrame:Frame(0, 0, 80, 80)];
        
    }
    
 [self.contentView addSubview:_photoView];
    
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    return _photoView;
    
    
}


@end
