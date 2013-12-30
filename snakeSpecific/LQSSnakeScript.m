//
//  LQSSnakeScript.m
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSSnakeScript.h"
#import "ILQSTimeKeeper.h"
#import "ILQSSnakeChunk.h"
#import "LQSTranslationTransformation.h"
#import "ILQSTransformationResolver.h"
#import <GLKit/GLKMath.h>

@implementation LQSSnakeScript

- (void)update
{
    if (_timeKeeper.timeSinceFirstResume>5)
    {
        if (floor(_timeKeeper.timeSinceFirstResume)!=floor(_timeKeeper.timeSinceFirstResume-_timeKeeper.timeSinceLastUpdate))
        {
            {
                GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_snakeChunk2.subSpace toSpace:_parent];
                GLKVector4 point1 = GLKVector4Make(0, 0, 0, 1);
                GLKVector4 point2 = GLKMatrix4MultiplyVector4(matrix, point1);
                _snakeChunk3.translationTransformation.x = point2.x;
                _snakeChunk3.translationTransformation.y = point2.y;
            }
            {
                GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_snakeChunk1.subSpace toSpace:_parent];
                GLKVector4 point1 = GLKVector4Make(0, 0, 0, 1);
                GLKVector4 point2 = GLKMatrix4MultiplyVector4(matrix, point1);
                _snakeChunk2.translationTransformation.x = point2.x;
                _snakeChunk2.translationTransformation.y = point2.y;
            }
            {
                GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_directionSpace toSpace:_parent];
                GLKVector4 point1 = GLKVector4Make(0, 0, 0, 1);
                GLKVector4 point2 = GLKMatrix4MultiplyVector4(matrix, point1);
                _snakeChunk1.translationTransformation.x = point2.x;
                _snakeChunk1.translationTransformation.y = point2.y;
            }
        }
    }
}

@end
