//
//  ILQSSnakeChunk.h
//  Snake
//
//  Created by Ariel School on 2013-12-16.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSAdjacentSpace;
@class LQSDrawableSquareData;
@class LQSTranslationTransformation;
@class LQSRotationTransformation;

@protocol ILQSSnakeChunk <NSObject>

- (NSObject<ILQSAdjacentSpace> *)space;
- (NSObject<ILQSAdjacentSpace> *)subSpace;
- (LQSDrawableSquareData *)drawData;
- (LQSTranslationTransformation *)translationTransformation;
- (LQSRotationTransformation *)rotationTransformation;

@end
