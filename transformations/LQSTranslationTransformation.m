//
//  LQSTranslationTransformation.m
//  Snake
//
//  Created by Ariel on 2013-09-04.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSTranslationTransformation.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSTranslationTransformation

- (GLKMatrix4)transformationMatrix
{
    return GLKMatrix4MakeTranslation(_x, _y, _z);
}

- (GLKMatrix4)transformationMatrixInverse
{
    return GLKMatrix4MakeTranslation(-_x, -_y, -_z);
}

@end
