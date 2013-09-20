//
//  LQSTransformationFactory.m
//  Snake
//
//  Created by Ariel on 2013-09-12.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSTransformationFactory.h"
#import "LQSScaleTransformation.h"
#import "LQSUniformScaleTransformation.h"
#import "LQSTranslationTransformation.h"
#import "LQSRotationTransformation.h"

@implementation LQSTransformationFactory

+ (LQSScaleTransformation *)scaleTransformationWithScaleX:(float)scaleX scaleY:(float)scaleY scaleZ:(float)scaleZ
{
    LQSScaleTransformation *scaleTransformation = [[LQSScaleTransformation alloc] init];
    scaleTransformation.scaleX = scaleX;
    scaleTransformation.scaleY = scaleY;
    scaleTransformation.scaleZ = scaleZ;
    return scaleTransformation;
}

+ (LQSUniformScaleTransformation *)uniformScaleTransformationWithScale:(float)scale
{
    LQSUniformScaleTransformation *uniformScaleTransformation = [[LQSUniformScaleTransformation alloc] init];
    uniformScaleTransformation.scale = scale;
    return uniformScaleTransformation;
}

+ (LQSTranslationTransformation *)translationTransformationWithX:(float)x y:(float)y z:(float)z
{
    LQSTranslationTransformation *translationTransformation = [[LQSTranslationTransformation alloc] init];
    translationTransformation.x = x;
    translationTransformation.y = y;
    translationTransformation.z = z;
    return translationTransformation;
}

+ (LQSRotationTransformation *)rotationTransformationWithRadians:(float)radians x:(float)x y:(float)y z:(float)z
{
    LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
    rotationTransformation.radians = radians;
    rotationTransformation.x = x;
    rotationTransformation.y = y;
    rotationTransformation.z = z;
    return rotationTransformation;
}

@end
