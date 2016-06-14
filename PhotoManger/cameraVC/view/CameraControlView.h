//
//  CameraControlView.h
//  PhotoManger
//
//  Created by zengjia on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Cancelbutton = 0xef001,
    Camerabutton,
    Usephotpbutton,
} buttonTag;

@interface CameraControlView : UIView
@property(nonatomic, strong)void(^btnActionBlock)(UIButton *btn);

@end
