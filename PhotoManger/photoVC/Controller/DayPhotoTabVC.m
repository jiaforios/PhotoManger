//
//  DayPhotoTabVC.m
//  PhotoManger
//
//  Created by zengjia on 16/6/19.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "DayPhotoTabVC.h"
#import "PhotoViewController.h"
#import "ImageInfoModel.h"
@interface DayPhotoTabVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DayPhotoTabVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = PmLocalizedString(@"Photos");
    self.title = @"Photos";
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    img.image = [UIImage imageNamed:@"main.jpg"];

    self.tableView.backgroundView = img;
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(photoAlbum)];
    
    self.navigationItem.rightBarButtonItem = addBtn;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _dataSource = [[ImageVideoFilesManger SubFilesInDirectoty:[ImageVideoFilesManger PhotoFilePath]] mutableCopy];
    
    [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableString *mStr =[[NSMutableString alloc] initWithString:(NSString *)obj];
        [mStr replaceCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
        [mStr replaceCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
        [mStr insertString:@"日" atIndex:10];
        
        [_dataSource replaceObjectAtIndex:idx withObject:mStr];
    }];

}

- (void)photoAlbum
{
    UIActionSheet *sheet;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"相机拍照",@"从相册选择",nil];
        
    }else{
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil ];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==255) {
        
        NSUInteger sourceType =0;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                    
                case 0:
                    
                    //cancel
                    
                    return;
                    
                case 1:
                    
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    break;
                    
                case 2:
                    
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                    break;
                    
            }
            
        }else
            
        {
            
            if (buttonIndex==0) {
                
                return;
                
            }else{
                
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
            }
            
        }
        
        
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
        
    }
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    // 获取到选中的图片
//    UIImage *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    

}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
    
}


#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.detailTextLabel.text = [self subArrCountFromPath:indexPath.row];
    
    ImageInfoModel *mdoel = [[self getImageDataFromRemarkInfoInArr:[self imageArrInPath:indexPath.row]] lastObject]; // 获取最新的一张图片显示
    
    cell.imageView.image = [UIImage imageWithContentsOfFile:mdoel.imageThumbFile];
    
    UIGraphicsBeginImageContext(CGSizeMake(70, 70));
    
    [cell.imageView.image drawInRect:CGRectMake(0, 0, 70, 70)];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 选中cell 根据当前天获取到当前cell 对应的所有的Remark_infomation
    PhotoViewController *pvc = [[PhotoViewController alloc] init];
    pvc.remarkDataSource =     [self imageArrInPath:indexPath.row];
    [self.navigationController pushViewController:pvc animated:YES];
    
}

/**
 *  选中天数后获取当天的全部图片信息数组
 *
 *  @param index 天
 *
 *  @return 图片数组
 */
- (NSArray *)imageArrInPath:(NSInteger)index
{
    // 2016_06_20
    NSString *str = [ImageVideoFilesManger SubFilesInDirectoty:[ImageVideoFilesManger PhotoFilePath]][index];
    // 根据日期筛选图片对应的 remarkInfomations;

    NSArray *arr = [ImageVideoFilesManger SubFilesInDirectoty:[ImageVideoFilesManger RemarkDataFilePath]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",str];
    arr = [arr filteredArrayUsingPredicate:predicate];

    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       return [obj1 compare:obj2];
    }];
    
    return arr;
    
}

- (NSMutableArray *)getImageDataFromRemarkInfoInArr:(NSArray *)arr
{
    NSMutableArray *imageInfoArr = [[NSMutableArray alloc] init];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = [ImageVideoFilesManger UnachiveFromFileWithName:obj];  // 解档数据
        ImageInfoModel *infoModel = [[ImageInfoModel alloc] init];
        [infoModel assginToPropertyWithDic:dic];
        infoModel.imageThumbFile = [ImageVideoFilesManger thumbPathFromName:dic[@"cameraTimes"]];
        infoModel.imageFile = [ImageVideoFilesManger imagePathFromName:dic[@"cameraTimes"]];

        [imageInfoArr addObject:infoModel];
        
    }];
    return imageInfoArr;
}


/**
 *  显示在detailTextLable 的数量
 *
 *  @param index 天
 *
 *  @return 图片数量
 */

- (NSString *)subArrCountFromPath:(NSInteger)index
{
    // path 2016_06_20
    NSString *path = [ImageVideoFilesManger SubFilesInDirectoty:[ImageVideoFilesManger PhotoFilePath]][index];
    
    // 2016_06_20_thumb
    NSString *imagePath = [path stringByAppendingString:@"_thumb"];
    
    
    // /var/mobile/Containers/Data/Application/9B9D2E93-65AF-4036-8ED3-38708550646F/Documents/photoFile/2016_06_20/2016_06_20_thumb 获取该目录下的文件数量
    
    NSArray *arr = [ImageVideoFilesManger SubFilesInDirectoty:[[[ImageVideoFilesManger PhotoFilePath] stringByAppendingPathComponent:path]stringByAppendingPathComponent:imagePath]];
    
    
    return [NSString stringWithFormat:@"%lu",(unsigned long)arr.count];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
