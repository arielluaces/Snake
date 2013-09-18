//
//  LQSVertexShader.m
//  Snake
//
//  Created by Ariel on 2013-08-02.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSVertexShader.h"
#import "LQSGLShader.h"
#import "LQSGLUtils.h"

@implementation LQSVertexShader
{
    NSObject<ILQSGLShader> *_shader;
}

- (id)initWithSource:(const char*)source
{
    self = [super init];
    if (self) {
        // Create shader in the current context
        NSAssert([EAGLContext currentContext] != nil, @"Current context cannot be nil");
        _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER];
        NSAssert(_shader != nil, @"Failed to create shader");
        NSAssert(_shader.name != 0, @"Failed to create shader");
        glShaderSource(_shader.name, 1, &source, nil);
        glCompileShader(_shader.name);
        [LQSGLUtils checkShaderCompileStatus:_shader];
    }
    return self;
}

- (id)initWithSource:(const char*)source context:(EAGLContext *)context
{
    self = [super init];
    if (self) {
        NSAssert(context != nil, @"Context cannot be nil");
        if (context == [EAGLContext currentContext])
        {
            // Create shader in the current context
            _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER];
            NSAssert(_shader != nil, @"Failed to create shader");
            NSAssert(_shader.name != 0, @"Failed to create shader");
            glShaderSource(_shader.name, 1, &source, nil);
            glCompileShader(_shader.name);
            [LQSGLUtils checkShaderCompileStatus:_shader];
        }
        else// if (context != [EAGLContext currentContext])
        {
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER];
            NSAssert(_shader != nil, @"Failed to create shader");
            NSAssert(_shader.name != 0, @"Failed to create shader");
            glShaderSource(_shader.name, 1, &source, nil);
            glCompileShader(_shader.name);
            [LQSGLUtils checkShaderCompileStatus:_shader];
            [EAGLContext setCurrentContext:savedContext];
        }
    }
    return self;
}

- (id)initWithSource:(const char*)source sharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self) {
        NSAssert(sharegroup != nil, @"Sharegroup cannot be nil");
        if (sharegroup == [EAGLContext currentContext].sharegroup)
        {
            // Create shader in the current context
            _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER];
            NSAssert(_shader != nil, @"Failed to create shader");
            NSAssert(_shader.name != 0, @"Failed to create shader");
            glShaderSource(_shader.name, 1, &source, nil);
            glCompileShader(_shader.name);
            [LQSGLUtils checkShaderCompileStatus:_shader];
        }
        else// if (sharegroup != [EAGLContext currentContext].sharegroup)
        {
            // Create a new "throwaway" context with the given sharegroup
            EAGLContext *context  = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:sharegroup];
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER];
            NSAssert(_shader != nil, @"Failed to create shader");
            NSAssert(_shader.name != 0, @"Failed to create shader");
            glShaderSource(_shader.name, 1, &source, nil);
            glCompileShader(_shader.name);
            [LQSGLUtils checkShaderCompileStatus:_shader];
            [EAGLContext setCurrentContext:savedContext];
        }
    }
    return self;
}

- (EAGLSharegroup *)sharegroup
{
    return _shader.sharegroup;
}

- (GLuint)name
{
    return _shader.name;
}

@end
