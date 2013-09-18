//
//  LQSProgram.h
//  Snake
//
//  Created by Ariel on 2013-08-02.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGLProgram.h"

@protocol ILQSGLShader;

@interface LQSProgram : NSObject <ILQSGLProgram>

- (id)initWithVertexShader:(NSObject<ILQSGLShader> *)vertexShader fragmentShader:(NSObject<ILQSGLShader> *)fragmentShader;
- (id)initWithVertexShader:(NSObject<ILQSGLShader> *)vertexShader fragmentShader:(NSObject<ILQSGLShader> *)fragmentShader context:(EAGLContext *)context;
- (id)initWithVertexShader:(NSObject<ILQSGLShader> *)vertexShader fragmentShader:(NSObject<ILQSGLShader> *)fragmentShader sharegroup:(EAGLSharegroup *)sharegroup;

@end
