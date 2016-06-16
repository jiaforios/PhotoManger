//
//  Define.h
//  PhotoManger
//
//  Created by foscom on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define PmCommonColor RGBCOLOR(5,175,235)

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7orLater IOS_VERSION>=7.0
#define IOS9orLater IOS_VERSION>=9.0
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define PmLocalizedString(key) ([[[NSLocale preferredLanguages] objectAtIndex:0] rangeOfString:@"zh-Hans"].length)? ([[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil]):([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil])
//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define IsChinese [CurrentLanguage rangeOfString:@"zh-Hans"].length// 简体zh-Hans
#define IsChineseHant [CurrentLanguage rangeOfString:@"zh-Hant"].length// 繁体zh-Hant
#define AddAction(btn,actions) [btn addTarget:self action:@selector(actions) forControlEvents:UIControlEventTouchUpInside]

#define Frame(a,b,c,d) CGRectMake(a, b, c, d)
#define  showModelContent(model)[model dictionaryFromModelWithShowLog:YES]


#endif /* Define_h */
