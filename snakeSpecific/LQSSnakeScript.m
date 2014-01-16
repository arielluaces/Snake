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
#import "ILQSFood.h"
#import "ILQSFoodSpawner.h"
#import <GLKit/GLKMath.h>
#import <UIKit/UITouch.h>

@implementation LQSSnakeScript

- (id)init
{
    self = [super init];
    if (self) {
        _chunksToSpawn = 0;
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
                if (_chunksToSpawn > 0)
                {
                    // === SPAWNING A CHUNK ===
                    // This must be done before moving all the chunks
                    NSObject<ILQSSnakeChunk> *snakeChunk = [_snakeChunkSpawner spawnSnakeChunk];
                    [_drawableParent.drawableArray addDrawableObject:snakeChunk.draw];
                    [_snakeChunkArray addObject:snakeChunk];
                    _chunksToSpawn--;
                }
                for (uint i=([_snakeChunkArray size]-1); i>=1; i--)
                {
                    // === MOVING THE CHUNKS ===
                    // This must be done before moving the head
                    [_snakeChunkArray objectAtIndex:i].translationTransformation.x = [_snakeChunkArray objectAtIndex:i-1].translationTransformation.x;
                    [_snakeChunkArray objectAtIndex:i].translationTransformation.y = [_snakeChunkArray objectAtIndex:i-1].translationTransformation.y;
                }
                {
                    // === MOVING THE HEAD ===
                    // This must be done before checking for collisions
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
                if (_food == nil)
                {
                    // === SPAWNING FOOD ===
                    NSObject<ILQSFood> *food = [_foodSpawner spawnFood];
                    [_drawableParent.drawableArray addDrawableObject:food.draw];
                    food.translationTransformation.x = (rand()%32)-16;
                    food.translationTransformation.y = (rand()%32)-16;
                    _food = food;
                }
                if (snakeHeadPos.x == _food.translationTransformation.x && snakeHeadPos.y == _food.translationTransformation.y)
                {
                    // === EATING FOOD ===
                    _chunksToSpawn += 3;
                    [_drawableParent.drawableArray removeDrawableObject:_food.draw];
                    _food = nil;
                    
                    // === SPAWNING FOOD ===
                    NSObject<ILQSFood> *food = [_foodSpawner spawnFood];
                    [_drawableParent.drawableArray addDrawableObject:food.draw];
                    food.translationTransformation.x = (rand()%32)-16;
                    food.translationTransformation.y = (rand()%32)-16;
                    _food = food;
                }
            }
        }
    }
}

@end
