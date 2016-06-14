//
//  CameraControlView.m
//  PhotoManger
//
//  Created by zengjia on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "CameraControlView.h"

@interface CameraControlView()
@property(nonatomic, strong)UIButton *cancelButton;
@property(nonatomic, strong)UIButton *useButton;
@property(nonatomic, strong)UIButton *continePhotoButton;

@end
@implementation CameraControlView


- (void)layoutSubviews
{
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:self.cancelButton];
    [self addSubview:self.useButton];
    [self addSubview:self.continePhotoButton];

}
- (UIButton *)cancelButton
{
    if (_cancelButton ==  nil) {
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:PmLocalizedString(@"Cancel") forState:UIControlStateNormal];
        _cancelButton.frame = Frame(0, 0, 100, CGRectGetHeight(self.frame));
        _cancelButton.tag = Cancelbutton;
        
        AddAction(_cancelButton, btnAction:);

    }
    
    return _cancelButton;
}

- (UIButton *)useButton
{
    if (_useButton == nil) {
        _useButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_useButton setTitle:PmLocalizedString(@"UsePhoto") forState:UIControlStateNormal];
        _useButton.frame = Frame(SCREEN_WIDTH-100, 0, 100,CGRectGetHeight(self.frame));
        _useButton.tag = Usephotpbutton;
        AddAction(_useButton, btnAction:);
        
    }
    return _useButton;
}
- (UIButton *)continePhotoButton
{
    if (_continePhotoButton == nil) {
        
        _continePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_continePhotoButton setTitle:PmLocalizedString(@"Camera") forState:UIControlStateNormal];
        _continePhotoButton.frame = Frame(SCREEN_WIDTH/2-50, 0, 100,CGRectGetHeight(self.frame));
        _useButton.tag = Camerabutton;

        AddAction(_continePhotoButton, btnAction:);

    }
    return _continePhotoButton;
}

-(void)btnAction:(UIButton *)sender
{
    if (_btnActionBlock) {
        _btnActionBlock(sender);
    }
}

@end
