//
//  LocationManger.h
//  PhotoManger
//
//  Created by foscom on 16/6/16.
//  Copyright © 2016年 zengjia. All rights reserved.
//

typedef void(^locationBlock)(NSString *name,LocationInfo imglocation);
#import <Foundation/Foundation.h>
@interface LocationManger : NSObject

+ (void)shareLoacationWithLocationBlock:(locationBlock)block;
@property(nonatomic,strong)NSString *name;
@property(nonatomic, strong)locationBlock locablock;

@end
