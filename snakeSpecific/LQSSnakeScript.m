//
//  LQSSnakeScript.m
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSSnakeScript.h"
#import "ILQSTransformationResolver.h"
#import "ILQSTimeKeeper.h"
#import "ILQSSnakeChunk.h"
#import "ILQSAdjacentSpace.h"
#import "LQSTranslationTransformation.h"
#import "LQSDrawableSquareData.h"
#import "ILQSSnakeChunkArray.h"
#import "ILQSSnakeChunkSpawner.h"
#import "LQSSnakeChunk.h"
#import "LQSDrawableParent.h"
#import "LQSDrawableArray.h"
#import "LQSDrawableSquare.h"
#import <GLKit/GLKMath.h>
#import <UIKit/UITouch.h>

@implementation LQSSnakeScript

- (id)init
{
    self = [super init];
    if (self) {
        _paused = false;
    }
    return self;
}

- (void)update
{
    if (!_paused)
    {
        if (_timeKeeper.timeSinceFirstResume>5)
        {
            if (floor((_timeKeeper.timeSinceFirstResume)*4)!=floor((_timeKeeper.timeSinceFirstResume-_timeKeeper.timeSinceLastUpdate)*4))
            {
                if (rand()%5 < 2)
                {
                    NSObject<ILQSSnakeChunk> *snakeChunk = [_snakeChunkSpawner spawnSnakeChunk];
                    [_drawableParent.drawableArray addDrawableObject:snakeChunk.draw];
                    [_snakeChunkArray addObject:snakeChunk];
                }
                for (uint i=([_snakeChunkArray size]-1); i>=1; i--)
                {
                    [_snakeChunkArray objectAtIndex:i].translationTransformation.x = [_snakeChunkArray objectAtIndex:i-1].translationTransformation.x;
                    [_snakeChunkArray objectAtIndex:i].translationTransformation.y = [_snakeChunkArray objectAtIndex:i-1].translationTransformation.y;
                }
                {
                    GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_directionSpace toSpace:_parent];
                    GLKVector4 point1 = GLKVector4Make(0, 0, 0, 1);
                    GLKVector4 point2 = GLKMatrix4MultiplyVector4(matrix, point1);
                    [_snakeChunkArray objectAtIndex:0].translationTransformation.x = point2.x;
                    [_snakeChunkArray objectAtIndex:0].translationTransformation.y = point2.y;
                }
                for (uint i=1; i<[_snakeChunkArray size]; i++)
                {
                    LQSTranslationTransformation *snakeHeadPos = [_snakeChunkArray objectAtIndex:0].translationTransformation;
                    LQSTranslationTransformation *snakeChunkPos = [_snakeChunkArray objectAtIndex:i].translationTransformation;
                    if (snakeHeadPos.x == snakeChunkPos.x && snakeHeadPos.y == snakeChunkPos.y)
                    {
                        _paused = true;
                        NSLog(@"HIT CHUNK");
                    }
                }
                LQSTranslationTransformation *snakeHeadPos = [_snakeChunkArray objectAtIndex:0].translationTransformation;
                if (snakeHeadPos.x <= -16)
                {
                    _paused = true;
                    NSLog(@"HIT LEFT WALL");
                }
                if (snakeHeadPos.x >= 16)
                {
                    _paused = true;
                    NSLog(@"HIT RIGHT WALL");
                }
                if (snakeHeadPos.y <= -16)
                {
                    _paused = true;
                    NSLog(@"HIT BOTTOM WALL");
                }
                if (snakeHeadPos.y >= 16)
                {
                    _paused = true;
                    NSLog(@"HIT TOP WALL");
                }
            }
        }
    }
}

@end
