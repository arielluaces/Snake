//
//  LQSSnakeChunkSpawner.m
//  Snake
//
//  Created by Ariel School on 2014-01-07.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "LQSSnakeChunkSpawner.h"
#import "LQSRotationTransformation.h"
#import "LQSTranslationTransformation.h"
#import "LQSTransformationArray.h"
#import "LQSTransformationSet.h"
#import "LQSChildSpace.h"
#import "LQSDrawableSquareData.h"
#import "LQSDrawableSquare.h"
#import "LQSSnakeChunk.h"

@implementation LQSSnakeChunkSpawner

- (LQSSnakeChunk *)spawnSnakeChunk
{
    // Allocate components
    LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
    LQSTranslationTransformation *translationTransformation = [[LQSTranslationTransformation alloc] init];
    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
    LQSChildSpace *childSubSpace = [[LQSChildSpace alloc] init];
    LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
    LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
    LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
    LQSSnakeChunk *snakeChunk = [[LQSSnakeChunk alloc] init];
    {
        // Configure components
        childSubSpace.transformToParent = translationTransformation;
        childSpace.transformToParent = transformationSet;
        childSpace.parent = childSubSpace;
        drawableSquareData.space = childSpace;
        drawableSquare.squareData = drawableSquareData;
        // Save component access
        snakeChunk.space = childSpace;
        snakeChunk.subSpace = childSubSpace;
        snakeChunk.rotationTransformation = rotationTransformation;
        snakeChunk.translationTransformation = translationTransformation;
        snakeChunk.draw = drawableSquare;
        snakeChunk.drawData = drawableSquareData;
    }
    {
        // Outside inputs
        rotationTransformation.radians = 0*6.283185307f/8;
        rotationTransformation.x = 0;
        rotationTransformation.y = 0;
        rotationTransformation.z = 1;
        translationTransformation.x = 2;
        translationTransformation.y = 0;
        translationTransformation.z = 0;
        [transformationSet.transformationArray addObject:_pivotTransformation];
        [transformationSet.transformationArray addObject:_scaleTransformation];
        [transformationSet.transformationArray addObject:rotationTransformation];
        childSubSpace.parent = _parentSpace;
        drawableSquareData.program = _program;
        drawableSquareData.rootSpace = _cameraSpace;
        drawableSquareData.transformationResolver = _transformationResolver;
        drawableSquareData.colorR = 0.6f;
        drawableSquareData.colorG = 0.2f;
        drawableSquareData.colorB = 0.95f;
    }
    return snakeChunk;
}

@end
