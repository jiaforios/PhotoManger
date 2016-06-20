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
        self.imageNameSufix = @".jpg";
        self.bSelected = NO;  // 默认都是没选中状态
    }
    return self;
}

- (NSString *)getCurrentTime
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY_MM_dd_HH_mm_ss_SS"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    //    NSDate *date = [dateformatter dateFromString:locationString];
    return locationString;
}

@end
