//
//  ILQSColoredVerticesProgram.h
//  Snake
//
//  Created by Ariel on 2013-08-14.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGLProgram.h"

@protocol ILQSColoredVerticesProgram <ILQSGLProgram>

- (GLuint)aPosition;
- (GLint)uMVPMatrix;
- (GLint)uColor;

@end
