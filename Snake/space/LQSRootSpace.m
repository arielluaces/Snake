//
//  LQSRootSpace.m
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSRootSpace.h"
#import "LQSSpaceCollection.h"

@implementation LQSRootSpace

- (NSObject<ILQSSpaceCollection> *)adjacentSpaces
{
    return [[LQSSpaceCollection alloc] init];
}

- (bool)isAdjacentSpace:(NSObject<ILQSAdjacentSpace> *)adjacentSpace
{
    return false;
}

@end
