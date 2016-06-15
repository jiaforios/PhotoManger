//
//  ImageFileModel.h
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageFileModel : NSObject
@property(nonatomic,strong)NSString *filePassWorld;  // 文件夹加密密码
@property(nonatomic,assign)BOOL isFileEncrypted;   // 文件夹是否加密
@property(nonatomic,assign)BOOL isShowAllInfo;    // 显示文件夹下图片的全部信息
@property(nonatomic,assign)BOOL isJustShowImageName;  // 仅仅显示文件夹下图片的名称
@property(nonatomic,strong)NSArray *encryptedImagearr;  // 加密的图片
@property(nonatomic,strong)NSArray *unEncryptedImagearr;  // 没有加密的图片


@end
