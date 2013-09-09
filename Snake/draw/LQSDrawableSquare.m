//
//  LQSDrawableSquare.m
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSDrawableSquare.h"
#import "ILQSColoredVerticesProgram.h"
#import "LQSSpaceUtils.h"
#import "ILQSDrawableSquareData.h"
#import <GLKit/GLKMatrix4.h>

@implementation LQSDrawableSquare

- (void)draw
{
    glUseProgram(_squareData.program.name);
    glEnableVertexAttribArray(_squareData.program.aPosition);
    float vertexPositions[] = {
        0.0f, 0.0f,
        0.0f, 1.0f,
        1.0f, 0.0f,
        1.0f, 1.0f,
    };
    GLKMatrix4 MVPMatrix = [LQSSpaceUtils transformationMatrixFromSpace:_squareData.space toSpace:_squareData.rootSpace];
    glUniformMatrix4fv(_squareData.program.uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
    glVertexAttribPointer(_squareData.program.aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, vertexPositions);
    glUniform3f(_squareData.program.uColor, _squareData.colorR, _squareData.colorG, _squareData.colorB);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glUseProgram(0);
}

@end
