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
        // Do it in the current context
        _name = glCreateShader(type);
        _sharegroup = [EAGLContext currentContext].sharegroup;
    }
    return self;
}

- (id)initWithType:(GLenum)type context:(EAGLContext *)context
{
    self = [super init];
    if (self)
    {
        if (context == [EAGLContext currentContext])
        {
            // Do it in the current context
            _name = glCreateShader(type);
            _sharegroup = context.sharegroup;
        }
        else if (context != [EAGLContext currentContext])
        {
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateShader(type);
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
        if (sharegroup == [EAGLContext currentContext].sharegroup)
        {
            // Do it in the current context
            _name = glCreateShader(type);
            _sharegroup = sharegroup;
        }
        else if (sharegroup != [EAGLContext currentContext].sharegroup)
        {
            // Create a new context with the given sharegroup
            EAGLContext *context  = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:sharegroup];
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateShader(type);
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
    else if (_sharegroup != [EAGLContext currentContext].sharegroup)
    {
        // Create a new context with the saved sharegroup
        EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:_sharegroup];
        EAGLContext *savedContext = [EAGLContext currentContext];
        [EAGLContext setCurrentContext:context];
        glDeleteShader(_name);
        [EAGLContext setCurrentContext:savedContext];
    }
}

@end
