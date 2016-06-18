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

    });
    _manger.locablock = block;  // _manger.locablock  的 实现等于 传递过来的实现

    [_manger.currentLocation startUpdatingLocation];
}
- (instancetype)init
{
    if (self = [super init]) {
        self.currentLocation = [[CLLocationManager alloc] init];
        _currentLocation.delegate = self;
        [_currentLocation requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [_currentLocation requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription

    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    CLLocation *lacations = [locations lastObject];
    CLLocationCoordinate2D cur = lacations.coordinate;
    LocationInfo lo = {cur.longitude,cur.latitude};

    NSLog(@"latitude: %f, longitude: %f", cur.latitude, cur.longitude);
    CLGeocoder *ged = [[CLGeocoder alloc] init];

    [ged reverseGeocodeLocation:lacations completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count>0) {
            CLPlacemark *clp = [[CLPlacemark alloc] initWithPlacemark:placemarks[0]];
//            NSDictionary *addreDic = [clp addressDictionary];
            NSString *name = clp.name;
            
            if (_locablock) {
                _locablock(name,lo);
                _locablock = nil;
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
