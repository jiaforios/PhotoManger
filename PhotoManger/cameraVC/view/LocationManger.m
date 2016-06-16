//
//  LocationManger.m
//  PhotoManger
//
//  Created by foscom on 16/6/16.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "LocationManger.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManger ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *currentLocation;

@end

@implementation LocationManger


+ (void)shareLoacationWithLocationBlock:(locationBlock)block
{
    static LocationManger *_manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manger = [[LocationManger alloc] init];
        _manger.locablock = block;  // _manger.locablock  的 实现等于 传递过来的实现

    });
    
}
- (instancetype)init
{
    if (self = [super init]) {
        self.currentLocation = [[CLLocationManager alloc] init];
        _currentLocation.delegate = self;
        [_currentLocation requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [_currentLocation requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        [_currentLocation startUpdatingLocation];

    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *lacations = [locations lastObject];
    CLLocationCoordinate2D cur = lacations.coordinate;
    
    NSLog(@"latitude: %f, longitude: %f", cur.latitude, cur.longitude);
    CLGeocoder *ged = [[CLGeocoder alloc] init];
    
    [ged reverseGeocodeLocation:lacations completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count>0) {
            NSDictionary *addreDic = [placemarks[0] addressDictionary];
            NSString *name = placemarks[0].name;
            
            if (_locablock) {
                
                _locablock(name);
            }
        }
    }];
    
    [_currentLocation stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"location error = %@ ",error);
}


@end
