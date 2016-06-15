//
//  NSObject+modelConvertDic.m
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "NSObject+modelConvertDic.h"
#import <objc/runtime.h>
@implementation NSObject (modelConvertDic)

- (void)dictionaryFromModel
{
    if (self == nil) {
        
        NSLog(@"%@ To dic = nil",NSStringFromClass([self class]));
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([self class]);
    id classObject = objc_getClass([className UTF8String]);
    
    // 获取所有属性
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    // 遍历所有属性
    for (int i = 0; i < count; i++) {
        // 取得属性
        objc_property_t property = properties[i];
        // 取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        // 取得属性值
        id propertyValue = nil;
        id valueObject = [self valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [self valueForKey:propertyName]];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    NSLog(@"%@ To dic = %@",NSStringFromClass([self class]),dict);
    
}

@end
