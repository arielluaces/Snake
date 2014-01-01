//
//  LQSDrawableMatrixGrid.m
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSDrawableMatrixGrid.h"
#import "ILQSDrawableMatrixGridData.h"
#import "ILQSMatrixGridProgram.h"
#import "ILQSTransformationResolver.h"
#import <GLKit/GLKMath.h>

@implementation LQSDrawableMatrixGrid

- (void)draw
{
    glUseProgram(_matrixGridData.matrixGridProgram.name);
    glEnableVertexAttribArray(_matrixGridData.matrixGridProgram.aPosition);
    glEnableVertexAttribArray(_matrixGridData.matrixGridProgram.aTexCoord);
    float positions[] = {
        0.0f, 0.0f,
        0.0f, 1.0f,
        1.0f, 0.0f,
        1.0f, 1.0f,
    };
    float texCoords[] = {
        0.0f, 0.0f,
        0.0f, 32.0f,
        32.0f, 0.0f,
        32.0f, 32.0f,
    };
    GLKMatrix4 MVPMatrix = [_matrixGridData.transformationResolver transformationMatrixFromSpace:_matrixGridData.gridSpace toSpace:_matrixGridData.cameraSpace];
    glUniformMatrix4fv(_matrixGridData.matrixGridProgram.uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
    glUniform4f(_matrixGridData.matrixGridProgram.uColor, 0.0f, 0.8f, 0.0f, 1.0f);
    glUniform1f(_matrixGridData.matrixGridProgram.uExponent, 1.0f/((sinf(_matrixGridData.exponent)+1.0f)*2.0f*0.3f+20.0f));
    glVertexAttribPointer(_matrixGridData.matrixGridProgram.aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, positions);
    glVertexAttribPointer(_matrixGridData.matrixGridProgram.aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, texCoords);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glDisable(GL_BLEND);
    glUseProgram(0);
}

@end
