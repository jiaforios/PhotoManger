//
//  ImageInfoModel.h
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//
/**
 *  该数据模型用于存储拍照后的图片的全部信息
 */

typedef enum : NSUInteger {
    people,
    landscape,
    others,
}imageType;

typedef struct LocationInfo {
    float imageLongitude;  // 经度
    float imageLatitude;   // 纬度
}LocationInfo;
#import <Foundation/Foundation.h>

@interface ImageInfoModel : NSObject
@property(nonatomic, assign)LocationInfo rect;     // 拍照位置
@property(nonatomic, strong)NSString * cameraTimes;      // 拍照时间 年 月 日 时 分 秒 毫秒
@property(nonatomic, strong)NSString *imageFile;   // 图片存储路径
@property(nonatomic, strong)NSString *imageThump;  // 图片对应缩略图
@property(nonatomic, assign)BOOL isImageEncrypted;      // 图片是否被加密
@property(nonatomic, strong)NSString *currenTime_cameraTimes;  // 拍摄时间距离当前时间的长度 用于给图片排序 及统计过期时间
@property(nonatomic, strong)NSString *passworld;   // 图片的密码
@property(nonatomic, strong)NSString *imageNameSufix;  // 图片格式后缀
@property(nonatomic, assign)CGSize imageSize;    // 图片的尺寸
@property(nonatomic, strong)NSString *imageRemark; // 图片信息备注
@property(nonatomic, assign)imageType imageClass;  // 图片类型 人物，风景等
@property(nonatomic, strong)NSString *imageName;  // 图片重命名   默认是当时的时间作为名称
@property(nonatomic, strong)NSString *imageSource;  // 图片来源 如果不是本程序拍摄，就将这些单独放到一个文建夹命名为其他  程序中默认imageSource  = @"PhotoManger"
@end
