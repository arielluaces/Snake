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
#import <GLKit/GLKMath.h>
#import <UIKit/UITouch.h>

@implementation LQSSnakeScript

- (void)update
{
    if (_timeKeeper.timeSinceFirstResume>5)
    {
        if (floor(_timeKeeper.timeSinceFirstResume)!=floor(_timeKeeper.timeSinceFirstResume-_timeKeeper.timeSinceLastUpdate))
        {
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
        }
    }
}

@end
