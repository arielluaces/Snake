//
//  LQSMatrixGridProgram.m
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSMatrixGridProgram.h"
#import "LQSProgram.h"
#import "LQSGLFileUtils.h"
#import "LQSVertexShader.h"
#import "LQSFragmentShader.h"

@implementation LQSMatrixGridProgram
{
    NSObject<ILQSGLProgram> *_program;
}

- (id)init
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"MatrixGrid"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"MatrixGrid"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC];
        LQSProgram *program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader];
        int aPosition = glGetAttribLocation(program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int aTexCoord = glGetAttribLocation(program.name, "aTexCoord");
        NSAssert(aTexCoord >= 0, @"%@ attribute not found", @"aTexCoord");
        int uMVPMatrix = glGetUniformLocation(program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        int uColor = glGetUniformLocation(program.name, "uColor");
        NSAssert(uColor >= 0, @"%@ unifrom not found", @"uColor");
        int uExponent = glGetUniformLocation(program.name, "uExponent");
        NSAssert(uExponent >= 0, @"%@ uniform not found", @"uExponent");
        _program = program;
        _aPosition = (GLuint)aPosition;
        _aTexCoord = (GLuint)aTexCoord;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
        _uExponent = (GLint)uExponent;
    }
    return self;
}

- (id)initWithContext:(EAGLContext *)context
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"MatrixGrid"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"MatrixGrid"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC context:context];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC context:context];
        LQSProgram *program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader context:context];
        int aPosition = glGetAttribLocation(program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int aTexCoord = glGetAttribLocation(program.name, "aTexCoord");
        NSAssert(aTexCoord >= 0, @"%@ attribute not found", @"aTexCoord");
        int uMVPMatrix = glGetUniformLocation(program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        int uColor = glGetUniformLocation(program.name, "uColor");
        NSAssert(uColor >= 0, @"%@ unifrom not found", @"uColor");
        int uExponent = glGetUniformLocation(program.name, "uExponent");
        NSAssert(uExponent >= 0, @"%@ uniform not found", @"uExponent");
        _program = program;
        _aPosition = (GLuint)aPosition;
        _aTexCoord = (GLuint)aTexCoord;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
        _uExponent = (GLint)uExponent;
    }
    return self;
}

- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self) {
        const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"MatrixGrid"];
        const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"MatrixGrid"];
        NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC sharegroup:sharegroup];
        NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC sharegroup:sharegroup];
        LQSProgram *program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader sharegroup:sharegroup];
        int aPosition = glGetAttribLocation(program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int aTexCoord = glGetAttribLocation(program.name, "aTexCoord");
        NSAssert(aTexCoord >= 0, @"%@ attribute not found", @"aTexCoord");
        int uMVPMatrix = glGetUniformLocation(program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        int uColor = glGetUniformLocation(program.name, "uColor");
        NSAssert(uColor >= 0, @"%@ unifrom not found", @"uColor");
        int uExponent = glGetUniformLocation(program.name, "uExponent");
        NSAssert(uExponent >= 0, @"%@ uniform not found", @"uExponent");
        _program = program;
        _aPosition = (GLuint)aPosition;
        _aTexCoord = (GLuint)aTexCoord;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
        _uExponent = (GLint)uExponent;
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
