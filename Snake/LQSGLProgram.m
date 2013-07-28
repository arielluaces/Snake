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
        _name = glCreateProgram();
        _sharegroup = [EAGLContext currentContext].sharegroup;
    }
    return self;
}

- (id)initWithContext:(EAGLContext *)context
{
    self = [super init];
    if (self)
    {
        if (context == [EAGLContext currentContext])
        {
            _name = glCreateProgram();
            _sharegroup = context.sharegroup;
        }
        else if (context != [EAGLContext currentContext])
        {
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateProgram();
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
        if (sharegroup == [EAGLContext currentContext].sharegroup)
        {
            _name = glCreateProgram();
            _sharegroup = sharegroup;
        }
        else if (sharegroup != [EAGLContext currentContext].sharegroup)
        {
            EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:sharegroup];
            EAGLContext *savedContext = [EAGLContext currentContext];
            [EAGLContext setCurrentContext:context];
            _name = glCreateProgram();
            [EAGLContext setCurrentContext:savedContext];
            _sharegroup = sharegroup;
        }
    }
    return self;
}

@end
