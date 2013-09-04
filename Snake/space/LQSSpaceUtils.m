//
//  LQSSpaceUtils.m
//  Snake
//
//  Created by Ariel on 2013-09-04.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSSpaceUtils.h"
#import "ILQSAdjacentSpace.h"
#import "ILQSTransformation.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSSpaceUtils

+ (GLKMatrix4)transformationMatrixFromSpace:(NSObject<ILQSAdjacentSpace> *)space1 toSpace:(NSObject<ILQSAdjacentSpace> *)space2
{
    if (space1 == space2)
    {
        return GLKMatrix4Identity;
    }
    else if ([space1 isAdjacentSpace:space2])
    {
        return [[space1 transformationObjectToSpace:space2] transformationMatrix];
    }
    else if ([space2 isAdjacentSpace:space1])
    {
        // We can either ask the object for the matrix already ionverted or we could invert the matrix ourselves
        // The matrices can be inverted individually or a large set of matrices that need to be inverted can
        // be inverted one chunk after being multiplied together
        return [[space2 transformationObjectToSpace:space1] transformationMatrixInverse];
    }
    else
    {
        // Start looking for longer chains in the directed graph to end up with a path from space1 to space2
        NSAssert(FALSE, @"Not implemented yet");
        return GLKMatrix4Identity;
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return GLKMatrix4Identity;
}

@end
