//
//  LQSGLVertexShader.m
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGLVertexShader.h"

@implementation LQSGLVertexShader

- (id)init
{
    self = [super initWithType:GL_VERTEX_SHADER];
    if (self)
    {
    }
    return self;
}

- (id)initWithContext:(EAGLContext *)context
{
    self = [super initWithType:GL_VERTEX_SHADER context:context];
    if (self)
    {
    }
    return self;
}

- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super initWithType:GL_VERTEX_SHADER sharegroup:sharegroup];
    if (self)
    {
    }
    return self;
}

@end
