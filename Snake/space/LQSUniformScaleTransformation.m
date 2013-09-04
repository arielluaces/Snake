//
//  LQSUniformScaleTransformation.m
//  Snake
//
//  Created by Ariel on 2013-09-04.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSUniformScaleTransformation.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSUniformScaleTransformation

- (GLKMatrix4)transformationMatrix
{
    return GLKMatrix4MakeScale(_scale, _scale, _scale);
}

- (GLKMatrix4)transformationMatrixInverse
{
    float scaleInv = 1.0f/_scale;
    return GLKMatrix4MakeScale(scaleInv, scaleInv, scaleInv);
}

@end
