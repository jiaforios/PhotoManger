//
//  ImagePickerViewController.m
//  PhotoManger
//
//  Created by foscom on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "CameraControlView.h"
#import "ImageVideoFilesManger.h"
#import "ImageInfoModel.h"
@interface ImagePickerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong)CameraControlView *cameraControlView;
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

-(CameraControlView *)cameraControlView
{
    if (_cameraControlView == nil) {
        
        _cameraControlView = [[CameraControlView alloc] initWithFrame:Frame(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 80)];
    }
    
    return _cameraControlView;
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
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actions)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapFullScreen)];
    tap2.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap2];
    
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    continueBtn.frame = CGRectMake(70, SCREEN_HEIGHT-57, 80, 20);
    [continueBtn setTitle:PmLocalizedString(@"继续拍照") forState:UIControlStateNormal];
    continueBtn.backgroundColor = [UIColor clearColor];
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor blueColor];
    view.alpha = 0.2;
    self.showsCameraControls = NO;
    
    self.cameraViewTransform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    self.cameraOverlayView = self.cameraControlView;
    __block ImagePickerViewController *weakself = self;
    _cameraControlView.btnActionBlock = ^(UIButton *btn){
    
        switch (btn.tag) {
            case Cancelbutton:
            {
                
                [weakself dismissViewControllerAnimated:YES completion:nil];
            }
                break;
            case Camerabutton:
            {
                [weakself takePicture]; // 拍照
                
            }
                break;
            case Usephotpbutton:
            {
                weakself.cameraViewTransform = CGAffineTransformMakeScale(1.7, 1.7);
            }
                break;
  
            default:
                break;
        }
    };
}

- (void)doubleTapFullScreen
{
    static BOOL isfull = NO;
    isfull = !isfull;
    
    if (isfull) {
        self.cameraViewTransform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    }else
    {
        self.cameraViewTransform = CGAffineTransformScale(CGAffineTransformIdentity, 1.7, 1.7);

    }
}
-(void)actions
{
    NSLog(@"22");
}

- (void)createImageInfoModelWithimage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    ImageInfoModel *model = [[ImageInfoModel alloc] init];
    model.imageData = imageData;
    model.imageSize=  image.size;
    model.imageSizeStr = [NSString stringWithFormat:@"%.f*%.f",image.size.width,image.size.height];
    // 根据拍摄时间创建文件路径
    NSArray *timeArr = [model.cameraTimes componentsSeparatedByString:@"_"];
    NSString*dayFilename = [[timeArr subarrayWithRange:NSMakeRange(0, 3)] componentsJoinedByString:@""];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        

      NSString *dayFile = [ImageVideoFilesManger createDirectoryPath:[NSString stringWithFormat:@"%@/%@",[ImageVideoFilesManger PhotoFilePath],dayFilename]];
        
        [ImageVideoFilesManger cerateFilePath:[NSString stringWithFormat:@"%@/%@.jpg",dayFile,model.cameraTimes] WithContentData:model.imageData];
        
//       [ImageVideoFilesManger cerateFilePath:[NSString stringWithFormat:@"%@/%@/%@.jpg",[ImageVideoFilesManger PhotoFilePath],dayFile,model.cameraTimes] WithContentData:model.imageData];
    });
    
//    showModelContent(model);
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
                UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSLog(@"size = %@",NSStringFromCGSize(image.size));
        
        NSDictionary *imageInfoDictionry = [info objectForKey:@"UIImagePickerControllerMediaMetadata"];
        
        NSLog(@"imageinfo = %@ ",imageInfoDictionry);
        // 将image 转化为data 数据
        //        UIImage *image1 = [UIImage imageWithData:imageData];
        NSLog(@"find a image");
        _cameraControlView.imageBlcok(image);

        [self createImageInfoModelWithimage:image];
        
        
        
        //        [self dismissViewControllerAnimated:YES completion:nil];
        
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
