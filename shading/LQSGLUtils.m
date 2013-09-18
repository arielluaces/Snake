//
//  LQSGLUtils.m
//  Snake
//
//  Created by Ariel on 2013-08-01.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGLUtils.h"
#import "ILQSGLProgram.h"
#import "ILQSGLShader.h"

@implementation LQSGLUtils

+ (void)checkProgramLinkStatus:(NSObject<ILQSGLProgram> *)program
{
    int linkStatus = 0;
    glGetProgramiv(program.name, GL_LINK_STATUS, &linkStatus);
    if (linkStatus == GL_FALSE)
    {
        int logLength = 0;
        glGetProgramiv(program.name, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength)
        {
            char *log = malloc(sizeof(char) * (uint)logLength);
            glGetProgramInfoLog(program.name, logLength, NULL, log);
            NSAssert(FALSE, @"Could not link shader program log: %s",log);
            free(log);
        }
        NSAssert(FALSE, @"Could not link shader program");
    }
}

+ (void)checkShaderCompileStatus:(NSObject<ILQSGLShader> *)shader
{
    int compileStatus = 0;
    glGetShaderiv(shader.name, GL_COMPILE_STATUS, &compileStatus);
    if (compileStatus == GL_FALSE)
    {
        int logLength = 0;
        glGetShaderiv(shader.name, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength)
        {
            char *log = malloc(sizeof(char) * (uint)logLength);
            glGetShaderInfoLog(shader.name, logLength, NULL, log);
            NSAssert(FALSE, @"Could not compile shader log: %s", log);
            free(log);
        }
        NSAssert(FALSE, @"Could not compile shader");
    }
}

@end
