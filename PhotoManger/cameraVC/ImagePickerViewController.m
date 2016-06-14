//
//  ImagePickerViewController.m
//  PhotoManger
//
//  Created by foscom on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ImagePickerViewController


+ (instancetype)sharePickeManger
{
    static ImagePickerViewController *pickerManger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        pickerManger = [[ImagePickerViewController alloc] init];
        
    });
    
    return pickerManger;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSArray *mediatypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        self.mediaTypes = mediatypes;
        self.allowsEditing = YES;
        self.delegate = self;
    }
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    continueBtn.frame = CGRectMake(70, SCREEN_HEIGHT-57, 80, 20);
    [continueBtn setTitle:PmLocalizedString(@"继续拍照") forState:UIControlStateNormal];
    
    continueBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:continueBtn];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
                UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        // 将image 转化为data 数据
        //        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        //        UIImage *image1 = [UIImage imageWithData:imageData];
        
        NSLog(@"find a image");
        _imageBlock(image);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
