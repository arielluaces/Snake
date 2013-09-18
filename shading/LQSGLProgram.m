//
//  LQSGLProgram.m
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGLProgram.h"

@implementation LQSGLProgram

- (id)init
{
    self = [super init];
    if (self)
    {
        // Create program in the current context
        NSAssert([EAGLContext currentContext] != nil, @"Current context cannot be nil");
        _name = glCreateProgram();
        NSAssert(_name != 0, @"Failed to create program");
        _sharegroup = [EAGLContext currentContext].sharegroup;
    }
    return self;
}

- (id)initWithContext:(EAGLContext *)context
{
    self = [super init];
    if (self)
    {
        NSAssert(context != nil, @"Context cannot be nil");
        if (context == [EAGLContext currentContext])
        {
            // Create program in the current context
            _name = glCreateProgram();
            NSAssert(_name != 0, @"Failed to create program");
            _sharegroup = context.sharegroup;
        }
        else// if (context != [EAGLContext currentContext])
        {
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateProgram();
            NSAssert(_name != 0, @"Failed to create program");
            [EAGLContext setCurrentContext:savedContext];
            _sharegroup = context.sharegroup;
        }
    }
    return self;
}

- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup
{
    self = [super init];
    if (self)
    {
        NSAssert(sharegroup != nil, @"Sharegroup cannot be nil");
        if (sharegroup == [EAGLContext currentContext].sharegroup)
        {
            // Create program in the current context
            _name = glCreateProgram();
            NSAssert(_name != 0, @"Failed to create program");
            _sharegroup = sharegroup;
        }
        else// if (sharegroup != [EAGLContext currentContext].sharegroup)
        {
            // Create a new "throwaway" context with the given sharegroup
            EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:sharegroup];
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateProgram();
            NSAssert(_name != 0, @"Failed to create program");
            [EAGLContext setCurrentContext:savedContext];
            _sharegroup = sharegroup;
        }
    }
    return self;
}

@end
