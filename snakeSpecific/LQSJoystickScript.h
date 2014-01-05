//
//  LQSJoystickScript.h
//  Snake
//
//  Created by Ariel School on 2014-01-04.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "ILQSTouchProcessor.h"

@protocol ILQSTransformationResolver;
@protocol ILQSAdjacentSpace;
@class LQSTranslationTransformation;

@interface LQSJoystickScript : NSObject<ILQSTouchProcessor>

@property (nonatomic) NSObject<ILQSTransformationResolver> *transformationResolver;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *viewSpace;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *rightButtonSpace;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *downButtonSpace;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *leftButtonSpace;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *upButtonSpace;
@property (nonatomic) LQSTranslationTransformation *nextFirstChunkPosition;
@property (nonatomic) LQSTranslationTransformation *firstChunkPosition;
@property (nonatomic) LQSTranslationTransformation *secondChunkPosition;

@end
