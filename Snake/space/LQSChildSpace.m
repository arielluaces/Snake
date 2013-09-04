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

- (bool)isAdjacentSpace:(NSObject<ILQSAdjacentSpace> *)adjacentSpace
{
    // Should be equivalent to "adjacentObject" being in the set of adjacent objects of "self"
    // This function is just used of optimizations so that the adjacent objects set doesn't need
    // to be constructed in order to determine if an "adjacentObject" is in the set
    return adjacentSpace == _parent;
}

- (NSObject<ILQSTransformation> *)transformationObjectToSpace:(NSObject<ILQSAdjacentSpace> *)adjacentSpace
{
    NSAssert(adjacentSpace == _parent, @"Adjacent space:<%@: %p> is not adjacent to self:<%@: %p>", [adjacentSpace class], adjacentSpace, [self class], self);
    return _transformToParent;
}

@end
