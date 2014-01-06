//
//  LQSSnakeScript.h
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSUpdatable.h"

@protocol ILQSTimeKeeper;
@protocol ILQSTransformationResolver;
@protocol ILQSSnakeChunk;
@protocol ILQSAdjacentSpace;
@class LQSTranslationTransformation;

@interface LQSSnakeScript : NSObject<ILQSUpdatable>

@property (nonatomic) NSObject<ILQSTimeKeeper> *timeKeeper;
@property (nonatomic) NSObject<ILQSTransformationResolver> *transformationResolver;
@property (nonatomic) NSObject<ILQSSnakeChunk> *snakeChunk1;
@property (nonatomic) NSObject<ILQSSnakeChunk> *snakeChunk2;
@property (nonatomic) NSObject<ILQSSnakeChunk> *snakeChunk3;
@property (nonatomic) NSObject<ILQSSnakeChunk> *snakeChunk4;
@property (nonatomic) NSObject<ILQSSnakeChunk> *snakeChunk5;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *parent;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *directionSpace;
@property (nonatomic) LQSTranslationTransformation *directionTransformation;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *viewSpace;

@end
