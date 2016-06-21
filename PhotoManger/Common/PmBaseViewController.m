//
//  PmBaseViewController.m
//  PhotoManger
//
//  Created by foscom on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "PmBaseViewController.h"

@interface PmBaseViewController ()

@end

@implementation PmBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    img.image = [UIImage imageNamed:@"main.jpg"];
    [self.view addSubview:img];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
