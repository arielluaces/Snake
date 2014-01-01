//
//  ILQSMatrixGridProgram.h
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGLProgram.h"

@protocol ILQSMatrixGridProgram <ILQSGLProgram>

- (GLuint)aPosition;
- (GLuint)aTexCoord;
- (GLint)uMVPMatrix;
- (GLint)uColor;
- (GLint)uExponent;

@end
