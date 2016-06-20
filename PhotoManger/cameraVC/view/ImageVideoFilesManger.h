//
//  PhotoManger.h
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//


/**
 支持选中全部压缩，方便导出
 */


#import <Foundation/Foundation.h>

@interface ImageVideoFilesManger : NSObject

+ (NSString *)homePath;  // 根目录
+ (NSString *)appPath;  // 程序路径
+ (NSString *)documentPath;  // 文件管理路径
+ (NSString *)liberaryPath;  // 配置信息路径
+ (NSString *)libprePath;  // 配置偏好路径
+ (NSString *)libCachePath;  // 配置缓存路径
+ (NSString *)tempPath;  // 程序缓存路径  ，程序结束会清除
+ (BOOL)haveDirectoryPath:(NSString *)path;
+ (BOOL)haveFilePath:(NSString *)path;
+ (NSString *)createDirectoryPath:(NSString *)path;  // 创建目录路径
+ (NSString *)cerateFilePath:(NSString *)patch WithContentData:(NSData *)data; // 创建文件路径

+ (NSString *)PhotoFilePath;  // 当前程序图片文件夹的根目录

+ (NSString *)VideoFilePath;  // 当前程序视频文件的根目录

+ (NSString *)RemarkDataFilePath;  // 存储图片，录像相关配置信息，文件格式定为 对应的图片名称_remark.markdata

// 保存图片的配置信息
+ (BOOL)AchvieToFileWithDic:(NSDictionary *)dictionry andName:(NSString *)name;

// 解档图片的配置信息
+ (NSDictionary *)UnachiveFromFileWithName:(NSString *)name;

+ (NSArray *)SubFilesInDirectoty:(NSString *)file;

+ (NSString *)thumbPathFromName:(NSString *)imageName;
+ (NSString *)imagePathFromName:(NSString *)imageName;


@end
