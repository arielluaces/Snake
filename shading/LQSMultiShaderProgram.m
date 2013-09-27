//
//  LQSMultiShaderProgram.m
//  Snake
//
//  Created by Ariel on 2013-09-25.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSMultiShaderProgram.h"
#import "ILQSGLShaderCollection.h"
#import "LQSGLProgram.h"
#import "LQSGLShaderArray.h"
#import "ILQSGLShader.h"
#import "LQSGLUtils.h"

@implementation LQSMultiShaderProgram
{
    NSObject<ILQSGLProgram> *_program;
    NSObject<ILQSGLShaderCollection> *_shaders;
}

- (id)initWithShaders:(NSObject<ILQSGLShaderCollection> *)shaders
{
    self = [super init];
    if (self) {
        _program = [[LQSGLProgram alloc] init];
        _shaders = [[LQSGLShaderArray alloc] init];
        [_shaders addShaders:shaders];
        for (NSObject<ILQSGLShader> *shader in shaders)
        {
            NSAssert(_program.sharegroup == shader.sharegroup, @"Can't create a program made from a shader in another sharegroup");
            glAttachShader(_program.name, shader.name);
        }
        glLinkProgram(_program.name);
        [LQSGLUtils checkProgramLinkStatus:_program];
    }
    return self;
}

- (id)initWithShaders:(NSObject<ILQSGLShaderCollection> *)shaders context:(EAGLContext *)context
{
    self = [super init];
    if (self) {
        _program = [[LQSGLProgram alloc] initWithContext:context];
        _shaders = [[LQSGLShaderArray alloc] init];
        [_shaders addShaders:shaders];
        for (NSObject<ILQSGLShader> *shader in shaders)
        {
            NSAssert(_program.sharegroup == shader.sharegroup, @"Can't create a program made from a shader in another sharegroup");
            glAttachShader(_program.name, shader.name);
        }
        glLinkProgram(_program.name);
        [LQSGLUtils checkProgramLinkStatus:_program];
    }
    return self;
}

- (id)initWithShaders:(NSObject<ILQSGLShaderCollection> *)shaders sharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self) {
        _program = [[LQSGLProgram alloc] initWithSharegroup:sharegroup];
        _shaders = [[LQSGLShaderArray alloc] init];
        [_shaders addShaders:shaders];
        for (NSObject<ILQSGLShader> *shader in shaders)
        {
            NSAssert(_program.sharegroup == shader.sharegroup, @"Can't create a program made from a shader in another sharegroup");
            glAttachShader(_program.name, shader.name);
        }
        glLinkProgram(_program.name);
        [LQSGLUtils checkProgramLinkStatus:_program];
    }
    return self;
}

- (EAGLSharegroup *)sharegroup
{
    return _program.sharegroup;
}

- (GLuint)name
{
    return _program.name;
}

@end
