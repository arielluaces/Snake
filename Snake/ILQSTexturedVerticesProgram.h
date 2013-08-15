//
//  ILQSTexturedVerticesProgram.h
//  Snake
//
//  Created by Ariel on 2013-08-14.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSGLProgram.h"

@protocol ILQSTexturedVerticesProgram <ILQSGLProgram>

- (GLuint)aPosition;
- (GLuint)aTexCoord;
- (GLint)uMVPMatrix;

@end
