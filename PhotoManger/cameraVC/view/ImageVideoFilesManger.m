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
static NSString *const remarkFile = @"zemarkFile";

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
       [[NSFileManager defaultManager] createFileAtPath:patch contents:data attributes:nil];
        return patch;
    }
}


+ (NSString *)PhotoFilePath
{
    NSString *photoPath =  [[ImageVideoFilesManger documentPath] stringByAppendingString:photoFile];
    photoPath =[ImageVideoFilesManger createDirectoryPath:photoPath];
    return photoPath;
}

+ (NSString *)VideoFilePath
{
    NSString *videoPath =  [[ImageVideoFilesManger documentPath] stringByAppendingString:videoFile];
   videoPath = [ImageVideoFilesManger createDirectoryPath:videoPath];
    return videoPath;
}

+ (NSString *)RemarkDataFilePath
{
    NSString *remarkPath = [[ImageVideoFilesManger documentPath] stringByAppendingPathComponent:remarkFile];
    remarkPath = [ImageVideoFilesManger createDirectoryPath:remarkPath];
    return remarkPath;
}

+ (BOOL)AchvieToFileWithDic:(NSDictionary *)dictionry andName:(NSString *)name
{
  return [NSKeyedArchiver archiveRootObject:dictionry toFile:[[ImageVideoFilesManger RemarkDataFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_remark.markdata",name]]];
}

+ (NSDictionary *)UnachiveFromFileWithName:(NSString *)name
{
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:[[ImageVideoFilesManger RemarkDataFilePath] stringByAppendingPathComponent:name]];
    return dic;
}

+ (NSArray *)SubFilesInDirectoty:(NSString *)file
{
//    NSArray *subFileArr = [[NSFileManager defaultManager] subpathsAtPath:file]; // 能够遍历到当前路径下的全部路径，及子路径
//    
//    NSArray *subdirectoryArr = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:file error:nil];
    
    NSError *error;
    
   NSArray*  subdirectoryArr =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:file error:&error]; // 只遍历当前目录下的内容，不遍历 子文件夹的内容
    if (error) {
        
        NSLog(@"___%s___查询子目录结果失败",__func__);
        return nil;
    }
    return subdirectoryArr;
    
}
@end








