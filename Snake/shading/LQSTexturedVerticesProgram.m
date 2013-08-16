//
//  LQSTexturedVerticesProgram.m
//  Snake
//
//  Created by Ariel on 2013-08-14.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSTexturedVerticesProgram.h"
#import "LQSProgram.h"
#import "LQSGLFileUtils.h"
#import "LQSVertexShader.h"
#import "LQSFragmentShader.h"

@implementation LQSTexturedVerticesProgram
{
    NSObject<ILQSGLProgram> *_program;
    GLuint _aPosition;
    GLuint _aTexCoord;
    GLint _uMVPMatrix;
}

- (id)init
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"TexturedVerticesProgram"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"TexturedVerticesProgram"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC];
        _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader];
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int aTexCoord = glGetAttribLocation(_program.name, "aTexCoord");
        NSAssert(aTexCoord >= 0, @"%@ attribute not found", @"aTexCoord");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        _aPosition = (GLuint)aPosition;
        _aTexCoord = (GLuint)aTexCoord;
        _uMVPMatrix = (GLint)uMVPMatrix;
    }
    return self;
}

- (id)initWithContext:(EAGLContext *)context
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"TexturedVerticesProgram"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"TexturedVerticesProgram"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC context:context];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC context:context];
        _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader];
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int aTexCoord = glGetAttribLocation(_program.name, "aTexCoord");
        NSAssert(aTexCoord >= 0, @"%@ attribute not found", @"aTexCoord");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        _aPosition = (GLuint)aPosition;
        _aTexCoord = (GLuint)aTexCoord;
        _uMVPMatrix = (GLint)uMVPMatrix;
    }
    return self;
}

- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"TexturedVerticesProgram"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"TexturedVerticesProgram"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC sharegroup:sharegroup];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC sharegroup:sharegroup];
        _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader];
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int aTexCoord = glGetAttribLocation(_program.name, "aTexCoord");
        NSAssert(aTexCoord >= 0, @"%@ attribute not found", @"aTexCoord");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        _aPosition = (GLuint)aPosition;
        _aTexCoord = (GLuint)aTexCoord;
        _uMVPMatrix = (GLint)uMVPMatrix;
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

- (GLuint)aTexCoord
{
    return _aTexCoord;
}

- (GLint)uMVPMatrix
{
    return _uMVPMatrix;
}

@end
