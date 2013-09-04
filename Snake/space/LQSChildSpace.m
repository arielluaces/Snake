//
//  LQSChildSpace.m
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSChildSpace.h"
#import "LQSSpaceCollection.h"

@implementation LQSChildSpace

- (NSObject<ILQSSpaceCollection> *)adjacentSpaces
{
    LQSSpaceCollection *spaceCollection = [[LQSSpaceCollection alloc] init];
    [spaceCollection addSpace:_parent];
    return spaceCollection;
}

@end
