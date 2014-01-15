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
@protocol ILQSSnakeChunkArray;
@protocol ILQSAdjacentSpace;
@class LQSTranslationTransformation;
@protocol ILQSSnakeChunkSpawner;
@class LQSDrawableParent;

@interface LQSSnakeScript : NSObject<ILQSUpdatable>

@property (nonatomic) NSObject<ILQSTimeKeeper> *timeKeeper;
@property (nonatomic) NSObject<ILQSTransformationResolver> *transformationResolver;
@property (nonatomic) NSObject<ILQSSnakeChunkArray> *snakeChunkArray;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *parent;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *directionSpace;
@property (nonatomic) LQSTranslationTransformation *directionTransformation;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *viewSpace;
@property (nonatomic) NSObject<ILQSSnakeChunkSpawner> *snakeChunkSpawner;
@property (nonatomic) LQSDrawableParent *drawableParent;
@property (nonatomic, readonly) bool paused;

@end
