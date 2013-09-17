//
//  LQSGLShader.m
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGLShader.h"

@implementation LQSGLShader

- (id)initWithType:(GLenum)type
{
    self = [super init];
    if (self)
    {
        // Create shader in the current context
        NSAssert([EAGLContext currentContext] != nil, @"Current context cannot be nil");
        _name = glCreateShader(type);
        NSAssert(_name != 0, @"Failed to create shader");
        _sharegroup = [EAGLContext currentContext].sharegroup;
    }
    return self;
}

- (id)initWithType:(GLenum)type context:(EAGLContext *)context
{
    self = [super init];
    if (self)
    {
        NSAssert(context != nil, @"Context cannot be nil");
        if (context == [EAGLContext currentContext])
        {
            // Create shader in the current context
            _name = glCreateShader(type);
            NSAssert(_name != 0, @"Failed to create shader");
            _sharegroup = context.sharegroup;
        }
        else// if (context != [EAGLContext currentContext])
        {
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateShader(type);
            NSAssert(_name != 0, @"Failed to create shader");
            [EAGLContext setCurrentContext:savedContext];
            _sharegroup = context.sharegroup;
        }
    }
    return self;
}

- (id)initWithType:(GLenum)type sharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self)
    {
        NSAssert(sharegroup != nil, @"Sharegroup cannot be nil");
        if (sharegroup == [EAGLContext currentContext].sharegroup)
        {
            // Create shader in the current context
            _name = glCreateShader(type);
            NSAssert(_name != 0, @"Failed to create shader");
            _sharegroup = sharegroup;
        }
        else// if (sharegroup != [EAGLContext currentContext].sharegroup)
        {
            // Create a new "throwaway" context with the given sharegroup
            EAGLContext *context  = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:sharegroup];
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateShader(type);
            NSAssert(_name != 0, @"Failed to create shader");
            [EAGLContext setCurrentContext:savedContext];
            _sharegroup = sharegroup;
        }
    }
    return self;
}

- (void)dealloc
{
    if (_sharegroup == [EAGLContext currentContext].sharegroup)
    {
        glDeleteShader(_name);
    }
    else// if (_sharegroup != [EAGLContext currentContext].sharegroup)
    {
        // Create a new "throwaway" context with the given sharegroup
        EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:_sharegroup];
        EAGLContext *savedContext = [EAGLContext currentContext];
        [EAGLContext setCurrentContext:context];
        glDeleteShader(_name);
        [EAGLContext setCurrentContext:savedContext];
    }
}

@end
