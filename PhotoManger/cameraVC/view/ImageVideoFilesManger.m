//
//  PhotoManger.m
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "ImageVideoFilesManger.h"

static NSString *const photoFile = @"/photoFile";
static NSString *const videoFile = @"/videoFile";

@implementation ImageVideoFilesManger

+ (NSString *)homePath
{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    return NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)documentPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
+ (NSString *)liberaryPath
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}
+ (NSString *)libprePath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/Preference"];
}
+ (NSString *)libCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/Cache"];   
}

+ (NSString *)tempPath
{
    return [NSHomeDirectory() stringByAppendingString:@"/tmp"];
}


+ (BOOL)haveDirectoryPath:(NSString *)path
{
    BOOL isdirectory = YES;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isdirectory];
}

+ (BOOL)haveFilePath:(NSString *)path
{
    BOOL isdirectory = NO;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isdirectory];
}


+ (NSString *)createDirectoryPath:(NSString *)path
{
    if ([ImageVideoFilesManger haveDirectoryPath:path]) {
        return path;
    }else
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
        return path;
    }
}

+ (NSString *)cerateFilePath:(NSString *)patch WithContentData:(NSData *)data
{
    
    if ([ImageVideoFilesManger haveFilePath:patch]) {
        return patch;
    }else
    {
      BOOL isss =  [[NSFileManager defaultManager] createFileAtPath:patch contents:data attributes:nil];
        return patch;
    }
}


+ (NSString *)PhotoFilePath
{
    NSString *photoPath =  [[ImageVideoFilesManger documentPath] stringByAppendingString:photoFile];
    [ImageVideoFilesManger createDirectoryPath:photoPath];
    return photoPath;
}

+ (NSString *)VideoFilePath
{
    NSString *videoPath =  [[ImageVideoFilesManger documentPath] stringByAppendingString:videoFile];
    [ImageVideoFilesManger createDirectoryPath:videoPath];
    return videoPath;
}
@end








