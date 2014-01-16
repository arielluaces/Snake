//
//  ILQSFood.h
//  Snake
//
//  Created by Ariel School on 2014-01-15.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSAdjacentSpace;
@class LQSDrawableSquare;
@class LQSDrawableSquareData;
@class LQSTranslationTransformation;
@class LQSRotationTransformation;

@protocol ILQSFood <NSObject>

- (NSObject<ILQSAdjacentSpace> *)space;
- (NSObject<ILQSAdjacentSpace> *)subSpace;
- (LQSDrawableSquare *)draw;
- (LQSDrawableSquareData *)drawData;
- (LQSTranslationTransformation *)translationTransformation;
- (LQSRotationTransformation *)rotationTransformation;

@end
