//
//  LQSColoredVerticesProgram.m
//  Snake
//
//  Created by Ariel on 2013-08-14.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSColoredVerticesProgram.h"
#import "LQSProgram.h"
#import "LQSGLFileUtils.h"
#import "LQSVertexShader.h"
#import "LQSFragmentShader.h"

@implementation LQSColoredVerticesProgram
{
    NSObject<ILQSGLProgram> *_program;
    GLuint _aPosition;
    GLint _uMVPMatrix;
    GLint _uColor;
}

- (id)init
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"ColoredVerticesProgram"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"ColoredVerticesProgram"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC];
        _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader];
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        int uColor = glGetAttribLocation(_program.name, "uColor");
        NSAssert(uColor >= 0, @"%@ attribute not found", @"uColor");
        _aPosition = (GLuint)aPosition;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
    }
    return self;
}

- (id)initWithContext:(EAGLContext *)context
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"ColoredVerticesProgram"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"ColoredVerticesProgram"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC];
        _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader];
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        int uColor = glGetUniformLocation(_program.name, "uColor");
        NSAssert(uColor >= 0, @"%@ attribute not found", @"uColor");
        _aPosition = (GLuint)aPosition;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
    }
    return self;
}

- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"ColoredVerticesProgram"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"ColoredVerticesProgram"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC];
        _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader];
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        int uColor = glGetAttribLocation(_program.name, "uColor");
        NSAssert(uColor >= 0, @"%@ attribute not found", @"uColor");
        _aPosition = (GLuint)aPosition;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
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

- (GLuint)aPosition
{
    return _aPosition;
}

- (GLint)uMVPMatrix
{
    return _uMVPMatrix;
}

- (GLint)uColor
{
    return _uColor;
}

@end
