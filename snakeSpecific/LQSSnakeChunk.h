//
//  LQSSnakeChunk.h
//  Snake
//
//  Created by Ariel School on 2013-12-16.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSSnakeChunk.h"
#import <Foundation/Foundation.h>

@interface LQSSnakeChunk : NSObject<ILQSSnakeChunk>

@property (nonatomic) NSObject<ILQSAdjacentSpace> *space;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *subSpace;
@property (nonatomic) LQSDrawableSquare *draw;
@property (nonatomic) LQSDrawableSquareData *drawData;
@property (nonatomic) LQSTranslationTransformation *translationTransformation;
@property (nonatomic) LQSRotationTransformation *rotationTransformation;

@end
