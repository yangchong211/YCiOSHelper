//
//  Car.h
//  ObjCApp
//
//  Created by 杨充 on 2024/12/24.
//

#import <Foundation/Foundation.h>
#import "VehicleCar.h"
#import "Vehicle.h"

@interface VehicleCar : Vehicle

@property (nonatomic, assign) NSInteger numberOfDoors;

- (void) drive;

@end








