//
//  LQSTransformationSet.m
//  Snake
//
//  Created by Ariel on 2013-09-20.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSTransformationSet.h"
#import "LQSTransformationArray.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSTransformationSet

- (id)init
{
    self = [super init];
    if (self) {
        _transformationArray = [[LQSTransformationArray alloc] init];
    }
    return self;
}

- (GLKMatrix4)transformationMatrix
{
    GLKMatrix4 resultingMatrix = GLKMatrix4Identity;
    for (NSObject<ILQSTransformation> *transformation in _transformationArray)
    {
        resultingMatrix = GLKMatrix4Multiply(transformation.transformationMatrix, resultingMatrix);
    }
    return resultingMatrix;
}

- (GLKMatrix4)transformationMatrixInverse
{
    GLKMatrix4 resultingMatrix = GLKMatrix4Identity;
    for (NSObject<ILQSTransformation> *transformation in _transformationArray)
    {
        resultingMatrix = GLKMatrix4Multiply(resultingMatrix, transformation.transformationMatrixInverse);
    }
    return resultingMatrix;
}

@end
