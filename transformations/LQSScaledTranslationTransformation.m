//
//  LQSScaledTranslationTransformation.m
//  Snake
//
//  Created by Ariel on 2013-09-23.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSScaledTranslationTransformation.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSScaledTranslationTransformation

- (GLKMatrix4)transformationMatrix
{
    return GLKMatrix4MakeTranslation(_x*_scale, _y*_scale, _z*_scale);
}

- (GLKMatrix4)transformationMatrixInverse
{
    return GLKMatrix4MakeTranslation(-_x*_scale, -_y*_scale, -_z*_scale);
}

@end
