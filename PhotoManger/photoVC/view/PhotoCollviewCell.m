//
//  PhotoCollviewCell.m
//  PhotoManger
//
//  Created by foscom on 16/6/18.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "PhotoCollviewCell.h"

@implementation PhotoCollviewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _infoBtn.hidden = YES;
    _editView.hidden = YES;
    
    
}

// 点击 右下角 info 事件
- (IBAction)infoAction:(id)sender {
    
    
}

// 单击图片事件
- (IBAction)oneTapPicAction:(id)sender {
    
    // 非编辑模式下 单击事件进入大图浏览
    
    
    // 编辑模式下单击事件控制选中状态
    

}

// 双击图片事件
- (IBAction)doubleTapAction:(id)sender {
    
    
}

// 长按事件

- (IBAction)longTaoAction:(id)sender {
  // 长按显示图片相关信息 属性信息等
    
    
}


- (void)setImageRemarkPath:(NSString *)imageRemarkPath
{
    // 根据图片配置信息找到 图片路径，缩略图路径
}


@end
