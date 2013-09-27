//
//  LQSMultiShaderProgram.h
//  Snake
//
//  Created by Ariel on 2013-09-25.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGLProgram.h"

@protocol ILQSGLShaderCollection;

@interface LQSMultiShaderProgram : NSObject <ILQSGLProgram>

- (id)initWithShaders:(NSObject<ILQSGLShaderCollection> *)shaders;
- (id)initWithShaders:(NSObject<ILQSGLShaderCollection> *)shaders context:(EAGLContext *)context;
- (id)initWithShaders:(NSObject<ILQSGLShaderCollection> *)shaders sharegroup:(EAGLSharegroup *)sharegroup;

@end
