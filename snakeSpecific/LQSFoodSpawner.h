//
//  LQSFoodSpawner.h
//  Snake
//
//  Created by Ariel School on 2014-01-15.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "ILQSFoodSpawner.h"

@protocol ILQSTransformation;
@protocol ILQSAdjacentSpace;
@protocol ILQSColoredVerticesProgram;
@protocol ILQSTransformationResolver;

@interface LQSFoodSpawner : NSObject<ILQSFoodSpawner>

@property (nonatomic) NSObject<ILQSTransformation> *pivotTransformation;
@property (nonatomic) NSObject<ILQSTransformation> *scaleTransformation;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *parentSpace;
@property (nonatomic) NSObject<ILQSColoredVerticesProgram> *program;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *cameraSpace;
@property (nonatomic) NSObject<ILQSTransformationResolver> *transformationResolver;

@end
