//
//  LQSGLVertexShader.m
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGLVertexShader.h"
#import "LQSGLShader.h"

@implementation LQSGLVertexShader
{
    LQSGLShader *_shader;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER];
    }
    return self;
}

- (id)initWithContext:(EAGLContext *)context
{
    self = [super init];
    if (self)
    {
        _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER context:context];
    }
    return self;
}

- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self)
    {
        _shader = [[LQSGLShader alloc] initWithType:GL_VERTEX_SHADER sharegroup:sharegroup];
    }
    return self;
}

@end
