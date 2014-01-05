//
//  LQSJoystickScript.m
//  Snake
//
//  Created by Ariel School on 2014-01-04.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "LQSJoystickScript.h"
#import "ILQSTransformationResolver.h"
#import "LQSTranslationTransformation.h"
#import <UIKit/UITouch.h>
#import <GLKit/GLKMath.h>

@implementation LQSJoystickScript

- (void)processTouch:(UITouch *)touch
{
    if (touch.phase == UITouchPhaseEnded)
    {
        CGPoint locationInView = [touch locationInView:touch.view];
        {
            GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_rightButtonSpace];
            GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
            vector = GLKMatrix4MultiplyVector4(matrix, vector);
            if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
            {
                NSLog(@"hit right");
                if (_firstChunkPosition.x+1 != _secondChunkPosition.x || _firstChunkPosition.y != _secondChunkPosition.y)
                {
                    _nextFirstChunkPosition.x = 1;
                    _nextFirstChunkPosition.y = 0;
                }
            }
        }
        {
            GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_downButtonSpace];
            GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
            vector = GLKMatrix4MultiplyVector4(matrix, vector);
            if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
            {
                NSLog(@"hit down");
                if (_firstChunkPosition.x != _secondChunkPosition.x || _firstChunkPosition.y-1 != _secondChunkPosition.y)
                {
                    _nextFirstChunkPosition.x = 0;
                    _nextFirstChunkPosition.y = -1;
                }
            }
        }
        {
            GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_leftButtonSpace];
            GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
            vector = GLKMatrix4MultiplyVector4(matrix, vector);
            if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
            {
                NSLog(@"hit left");
                if (_firstChunkPosition.x-1 != _secondChunkPosition.x || _firstChunkPosition.y != _secondChunkPosition.y)
                {
                    _nextFirstChunkPosition.x = -1;
                    _nextFirstChunkPosition.y = 0;
                }
            }
        }
        {
            GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_upButtonSpace];
            GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
            vector = GLKMatrix4MultiplyVector4(matrix, vector);
            if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
            {
                NSLog(@"hit up");
                if (_firstChunkPosition.x != _secondChunkPosition.x || _firstChunkPosition.y+1 != _secondChunkPosition.y)
                {
                    _nextFirstChunkPosition.x = 0;
                    _nextFirstChunkPosition.y = 1;
                }
            }
        }
    }
}

@end
