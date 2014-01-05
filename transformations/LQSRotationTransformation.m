//
//  LQSRotationTransformation.m
//  Snake
//
//  Created by Ariel on 2013-09-20.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSRotationTransformation.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSRotationTransformation

- (GLKMatrix4)transformationMatrix
{
    NSAssert(_x!=0 && _y!=0 && _z!=0, @"The x,y, and z components of this rotation transformation can't all be zero");
    return GLKMatrix4MakeRotation(_radians, _x, _y, _z);
}

- (GLKMatrix4)transformationMatrixInverse
{
    NSAssert(_x!=0 && _y!=0 && _z!=0, @"The x,y, and z components of this rotation transformation can't all be zero");
    return GLKMatrix4MakeRotation(-_radians, _x, _y, _z);
}

@end
