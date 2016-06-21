//
//  PhotosBrowserView.h
//  PhotoManger
//
//  Created by foscom on 16/6/21.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapBlock)(NSInteger count);
@interface PhotosBrowserView : UIView


@property(nonatomic,strong)tapBlock tapblock;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger tapIndex;

@end
