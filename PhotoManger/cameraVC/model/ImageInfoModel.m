//
//  ImageInfoModel.m
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "ImageInfoModel.h"
@implementation ImageInfoModel

- (instancetype)init
{
    if (self = [super init]) {
        // 初始化部分信息
        self.imageSource = @"PhotoManger";
        self.isImageEncrypted = NO;
        self.imageName = [self getCurrentTime];
        self.cameraTimes = [self getCurrentTime];
        self.imageClass = others;
        self.imageNameSufix = @"jpg";
    }
    return self;
}

- (NSString *)getCurrentTime
{
    
    NSString *times;
    return times;
}

@end
