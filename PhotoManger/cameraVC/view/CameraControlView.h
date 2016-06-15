//
//  CameraControlView.h
//  PhotoManger
//
//  Created by zengjia on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CurrentImageBlock)(UIImage *);
typedef enum : NSUInteger {
    Cancelbutton = 0xef001,
    Camerabutton,
    Usephotpbutton,
} buttonTag;

@interface CameraControlView : UIView
@property(nonatomic, strong)void(^btnActionBlock)(UIButton *btn);
@property(nonatomic, strong)CurrentImageBlock imageBlcok; // 获取到刚抓拍的图片显示到拍照的右下角
@end
