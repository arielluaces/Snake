//
//  LQSMatrixGridProgram.h
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSMatrixGridProgram.h"

@interface LQSMatrixGridProgram : NSObject<ILQSMatrixGridProgram>

- (id)init;
- (id)initWithContext:(EAGLContext *)context;
- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup;

@property (nonatomic) GLuint aPosition;
@property (nonatomic) GLuint aTexCoord;
@property (nonatomic) GLint uMVPMatrix;
@property (nonatomic) GLint uColor;
@property (nonatomic) GLint uExponent;

@end
