//
//  LQSTransformationFactory.h
//  Snake
//
//  Created by Ariel on 2013-09-12.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LQSScaleTransformation;
@class LQSUniformScaleTransformation;
@class LQSTranslationTransformation;

@interface LQSTransformationFactory : NSObject

+ (LQSScaleTransformation *)scaleTransformationWithScaleX:(float)scaleX scaleY:(float)scaleY scaleZ:(float)scaleZ;
+ (LQSUniformScaleTransformation *)uniformScaleTransformationWithScale:(float)scale;
+ (LQSTranslationTransformation *)translationTransformationWithX:(float)x y:(float)y z:(float)z;

@end
