//
//  LQSGLFragmentShader.h
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <OpenGLES/EAGL.h>
#import "ILQSGLShader.h"

@interface LQSGLFragmentShader : NSObject <ILQSGLShader>

- (id)initWithContext:(EAGLContext *)context;
- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup;

@end
