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
    return GLKMatrix4MakeScale(1.0f/_scaleX, 1.0f/_scaleY, 1.0f/_scaleZ);
}

@end
