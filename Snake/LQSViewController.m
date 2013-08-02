//
//  LQSViewController.m
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSViewController.h"
#import "ILQSGLShader.h"
#import "ILQSGLProgram.h"
#import "LQSGLVertexShader.h"
#import "LQSGLFragmentShader.h"
#import "LQSGLProgram.h"
#import "LQSGLUtils.h"
#import <Foundation/NSBundle.h>

@implementation LQSViewController
{
    NSObject<ILQSGLShader> *_vertexShader;
    NSObject<ILQSGLShader> *_fragmentShader;
    NSObject<ILQSGLProgram> *_program;
    EAGLContext *_context;
    GLuint _aPosition;
    GLint _uMVPMatrix;
    GLint _uColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSAssert(_context != nil, @"Failed to create ES context");
    self.glkView.context = _context;
    self.glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    EAGLContext *savedContext = [EAGLContext currentContext];
    [EAGLContext setCurrentContext:_context];
    glEnable(GL_DEPTH_TEST);
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    {
        // Create program
        _vertexShader = [[LQSGLVertexShader alloc] initWithContext:_context];
        {
            NSStringEncoding *vertexShaderSourceEncoding = nil;
            NSError *vertexShaderError;
            NSString *vertexShaderFilePath = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
            NSString *vertexShaderSource = [NSString stringWithContentsOfFile:vertexShaderFilePath usedEncoding:vertexShaderSourceEncoding error:&vertexShaderError];
            const GLchar *source = [vertexShaderSource UTF8String];
            NSLog(@"%s",source);
            glShaderSource(_vertexShader.name, 1, &source, NULL);
            glCompileShader(_vertexShader.name);
            [LQSGLUtils checkShaderCompileStatus:_vertexShader];
        }
        _fragmentShader = [[LQSGLFragmentShader alloc] initWithContext:_context];
        {
            NSStringEncoding *fragmentShaderSourceEncoding = nil;
            NSError *fragmentShaderError;
            NSString *fragmentShaderFilePath = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
            NSString *fragmentShaderSource = [NSString stringWithContentsOfFile:fragmentShaderFilePath usedEncoding:fragmentShaderSourceEncoding error:&fragmentShaderError];
            const GLchar *source = [fragmentShaderSource UTF8String];
            NSLog(@"%s",source);
            glShaderSource(_fragmentShader.name, 1, &source, NULL);
            glCompileShader(_fragmentShader.name);
            [LQSGLUtils checkShaderCompileStatus:_fragmentShader];
        }
        _program = [[LQSGLProgram alloc] initWithContext:_context];
        {
            glAttachShader(_program.name, _vertexShader.name);
            glAttachShader(_program.name, _fragmentShader.name);
            glLinkProgram(_program.name);
            [LQSGLUtils checkProgramLinkStatus:_program];
        }
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"Position attribute not found");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"uMVPMatrix unifrom not found");
        int uColor = glGetUniformLocation(_program.name, "uColor");
        NSAssert(uColor >= 0, @"uColor unifrom not found");
        _aPosition = (GLuint)aPosition;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
    }
    [EAGLContext setCurrentContext:savedContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glUseProgram(_program.name);
    glEnableVertexAttribArray(_aPosition);
    float vertices[] = {
        0.0f, 0.0f,
        0.0f, 1.0f,
        1.0f, 0.0f,
        1.0f, 1.0f,
    };
    GLKMatrix4 MVPMatrix = GLKMatrix4Identity;
    MVPMatrix = GLKMatrix4Translate(MVPMatrix, -0.5f, -0.5f, 0.0f);
    glUniformMatrix4fv(_uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
    glUniform4f(_uColor, 1.0f, 1.0f, 1.0f, 1.0f);
    glVertexAttribPointer(_aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, vertices);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glUseProgram(0);
}

@end
