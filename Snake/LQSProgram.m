//
//  LQSProgram.m
//  Snake
//
//  Created by Ariel on 2013-08-02.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSProgram.h"
#import "LQSGLProgram.h"
#import "ILQSGLShader.h"
#import "LQSGLUtils.h"

@implementation LQSProgram
{
    NSObject<ILQSGLProgram> *_program;
    NSObject<ILQSGLShader> *_vertexShader;
    NSObject<ILQSGLShader> *_fragmentShader;
}

- (id)initWithVertexShader:(NSObject<ILQSGLShader> *)vertexShader fragmentShader:(NSObject<ILQSGLShader> *)fragmentShader
{
    self = [super init];
    if (self) {
        _program = [[LQSGLProgram alloc] init];
        _vertexShader = vertexShader;
        _fragmentShader = fragmentShader;
        NSAssert(_program.sharegroup == vertexShader.sharegroup, @"Can't create a program made from a vertex shader in a nother sharegroup");
        glAttachShader(_program.name, _vertexShader.name);
        NSAssert(_program.sharegroup == fragmentShader.sharegroup, @"Can't create a program made from a fragment shader in a nother sharegroup");
        glAttachShader(_program.name, _fragmentShader.name);
        glLinkProgram(_program.name);
        [LQSGLUtils checkProgramLinkStatus:_program];
    }
    return self;
}

- (id)initWithVertexShader:(NSObject<ILQSGLShader> *)vertexShader fragmentShader:(NSObject<ILQSGLShader> *)fragmentShader context:(EAGLContext *)context
{
    self = [super init];
    if (self) {
        _program = [[LQSGLProgram alloc] initWithContext:context];
        _vertexShader = vertexShader;
        _fragmentShader = fragmentShader;
        NSAssert(_program.sharegroup == vertexShader.sharegroup, @"Can't create a program made from a vertex shader in a nother sharegroup");
        glAttachShader(_program.name, _vertexShader.name);
        NSAssert(_program.sharegroup == fragmentShader.sharegroup, @"Can't create a program made from a fragment shader in a nother sharegroup");
        glAttachShader(_program.name, _fragmentShader.name);
        glLinkProgram(_program.name);
        [LQSGLUtils checkProgramLinkStatus:_program];
    }
    return self;
}

- (id)initWithVertexShader:(NSObject<ILQSGLShader> *)vertexShader fragmentShader:(NSObject<ILQSGLShader> *)fragmentShader sharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self) {
        _program = [[LQSGLProgram alloc] initWithSharegroup:sharegroup];
        _vertexShader = vertexShader;
        _fragmentShader = fragmentShader;
        NSAssert(_program.sharegroup == vertexShader.sharegroup, @"Can't create a program made from a vertex shader in a nother sharegroup");
        glAttachShader(_program.name, _vertexShader.name);
        NSAssert(_program.sharegroup == fragmentShader.sharegroup, @"Can't create a program made from a fragment shader in a nother sharegroup");
        glAttachShader(_program.name, _fragmentShader.name);
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
