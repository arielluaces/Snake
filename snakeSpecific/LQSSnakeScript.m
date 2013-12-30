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
#import <GLKit/GLKMath.h>
#import <UIKit/UITouch.h>

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

- (void)processTouch:(UITouch *)touch
{
    if (touch.phase == UITouchPhaseBegan)
    {
        CGPoint locationInView = [touch locationInView:touch.view];
        GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_snakeChunk1.space];
        GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
        vector = GLKMatrix4MultiplyVector4(matrix, vector);
        NSLog(@"[%f,%f,%f]", vector.x, vector.y, vector.z);
        if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
        {
            _snakeChunk1.drawData.colorB = 0;
            NSLog(@"hit");
        }
        else
        {
            _snakeChunk1.drawData.colorB = 0.95f;
        }
    }
    else if (touch.phase == UITouchPhaseMoved)
    {
        CGPoint locationInView = [touch locationInView:touch.view];
        GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_snakeChunk1.space];
        GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
        vector = GLKMatrix4MultiplyVector4(matrix, vector);
        NSLog(@"[%f,%f,%f]", vector.x, vector.y, vector.z);
        if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
        {
            _snakeChunk1.drawData.colorB = 0;
            NSLog(@"hit");
        }
        else
        {
            _snakeChunk1.drawData.colorB = 0.95f;
        }
    }
}

@end
