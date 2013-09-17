//
//  LQSDrawableTexturedSquare.m
//  Snake
//
//  Created by Ariel on 2013-09-16.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSDrawableTexturedSquare.h"
#import "ILQSDrawableTexturedSquareData.h"
#import "ILQSTexturedVerticesProgram.h"
#import "ILQSGLTexture.h"
#import "ILQSTransformationResolver.h"
#import <OpenGLES/ES2/gl.h>
#import <GLKit/GLKMatrix4.h>

@implementation LQSDrawableTexturedSquare

- (void)draw
{
    glUseProgram(_squareData.program.name);
    glEnableVertexAttribArray(_squareData.program.aPosition);
    glEnableVertexAttribArray(_squareData.program.aTexCoord);
    float positions[] = {
        0.0f, 0.0f,
        0.0f, 1.0f,
        1.0f, 0.0f,
        1.0f, 1.0f,
    };
    float texCoords[] = {
        0.0f, 1.0f,
        0.0f, 0.0f,
        1.0f, 1.0f,
        1.0f, 0.0f,
    };
    GLKMatrix4 MVPMatrix = [_squareData.transformationResolver transformationMatrixFromSpace:_squareData.squareSpace toSpace:_squareData.cameraSpace];
    glUniformMatrix4fv(_squareData.program.uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
    glVertexAttribPointer(_squareData.program.aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, positions);
    glVertexAttribPointer(_squareData.program.aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, texCoords);
    glBindTexture(GL_TEXTURE_2D, _squareData.texture.name);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glUseProgram(0);
}

@end
