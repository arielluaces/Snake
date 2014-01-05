//
//  LQSScaleTransformation.m
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSScaleTransformation.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSScaleTransformation

- (GLKMatrix4)transformationMatrix
{
    return GLKMatrix4MakeScale(_scaleX, _scaleY, _scaleZ);
}

- (GLKMatrix4)transformationMatrixInverse
{
    NSAssert(_scaleX!=0 && _scaleY!=0 && _scaleZ!=0, @"None of the x,y, and z components should be zero");
    return GLKMatrix4MakeScale(1.0f/_scaleX, 1.0f/_scaleY, 1.0f/_scaleZ);
}

@end
