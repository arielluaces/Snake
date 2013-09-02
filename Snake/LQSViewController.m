//
//  LQSViewController.m
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSViewController.h"
#import "LQSVertexShader.h"
#import "LQSFragmentShader.h"
#import "LQSProgram.h"
#import "LQSGLFileUtils.h"
#import <Foundation/NSBundle.h>
#import "LQSColoredVerticesProgram.h"

@implementation LQSViewController
{
    NSObject<ILQSGLProgram> *_program;
    EAGLContext *_context;
    GLuint _aPosition;
    GLuint _aGridValue;
    GLint _uMVPMatrix;
    GLint _uColor;
    GLint _uExponent;
    
    float _exponent;
    
    NSObject<ILQSColoredVerticesProgram> *_program2;
    float _squareSpaceToRootSpaceScale;
    NSObject *_squareSpace;
    NSObject *_squareSpaceParent;
    NSObject *_squareSpaceToParentTransform;
    NSObject *_rootSpace;
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
    // Create space information for the square being drawn
    _squareSpace = [[NSObject alloc] init];
    _rootSpace = [[NSObject alloc] init];
    _squareSpaceParent = _rootSpace;
    _squareSpaceToParentTransform = _squareSpace;
    _squareSpaceToRootSpaceScale = 1.0f/16.0f;
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    {
        // Create program
        {
            const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"MatrixGrid"];
            const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"MatrixGrid"];
            NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC context:_context];
            NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC context:_context];
            _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader context:_context];
        }
        int aPosition = glGetAttribLocation(_program.name, "aPosition");
        NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
        int aGridValue = glGetAttribLocation(_program.name, "aGridValue");
        NSAssert(aGridValue >= 0, @"%@ attribute not found", @"aGridValue");
        int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
        NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
        int uColor = glGetUniformLocation(_program.name, "uColor");
        NSAssert(uColor >= 0, @"%@ unifrom not found", @"uColor");
        int uExponent = glGetUniformLocation(_program.name, "uExponent");
        NSAssert(uExponent >= 0, @"%@ uniform not found", @"uExponent");
        _aPosition = (GLuint)aPosition;
        _aGridValue = (GLuint)aGridValue;
        _uMVPMatrix = (GLint)uMVPMatrix;
        _uColor = (GLint)uColor;
        _uExponent = (GLint)uExponent;
        // Create second program
        {
            _program2 = [[LQSColoredVerticesProgram alloc] initWithContext:_context];
        }
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
    _exponent = _exponent+1.0f;
}

- (GLKMatrix4)transformationMatrixFromSpace:(NSObject *)space1 toSpace:(NSObject *)space2
{
    if (space1 == space2)
    {
        return GLKMatrix4Identity;
    }
    else if ([self isObject:space2 InAdjacentObjectsOfObject:space1])
    {
        return [self transformationMatrixOfSpace:space1 toSpace:space2];
    }
    else if ([self isObject:space1 InAdjacentObjectsOfObject:space2])
    {
        // We can either ask the object for the matrix already ionverted or we could invert the matrix ourselves
        // The matrices can be inverted individually or a large set of matrices that need to be inverted can
        // be inverted one chunk after being multiplied together
        return [self transformationMatrixInverseOfSpace:space2 toSpace:space1];
    }
    else
    {
        // Start looking for longer chains in the directed graph to end up with a path from space1 to space2
        NSAssert(FALSE, @"Not implemented yet");
        return GLKMatrix4Identity;
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return GLKMatrix4Identity;
}

- (GLKMatrix4)transformationMatrixOfSpace:(NSObject *)space1 toSpace:(NSObject *)space2
{
    if (space1 == _squareSpace)
    {
        if (space2 == _squareSpaceParent)
        {
            return [self transformatrionMatrixOfObject:[self transformObjectOfOBject:space1]];
        }
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return GLKMatrix4Identity;
}

- (GLKMatrix4)transformationMatrixInverseOfSpace:(NSObject *)space1 toSpace:(NSObject *)space2
{
    if (space1 == _squareSpace)
    {
        if (space2 == _squareSpaceParent)
        {
            return [self transformatrionMatrixInverseOfObject:[self transformObjectOfOBject:space1]];
        }
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return GLKMatrix4Identity;
}

- (bool)isChild:(NSObject *)object
{
    if (object == _squareSpace)
    {
        return true;
    }
    else if (object == _rootSpace)
    {
        return false;
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return false;
}

- (bool)isObject:(NSObject *)adjacentObject InAdjacentObjectsOfObject:(NSObject *)object
{
    // Should be equivalent to "adjacentObject" being in the set of adjacent objects of "object"
    // This function is just used of optimizations so that the adjacnet objects set doesn't need
    // to be constructed in order to determine if an "adjacentObject" is in the set
    if (object == _squareSpace)
    {
        if (adjacentObject == _squareSpaceParent)
        {
            return true;
        }
    }
    else if (object == _rootSpace)
    {
        return false;
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return false;
}

- (NSArray *)adjacentSpacesOfObject:(NSObject *)object
{
    if (object == _squareSpace)
    {
        return [NSArray arrayWithObject:_squareSpaceParent];
    }
    else if (object == _rootSpace)
    {
        return [NSArray array];
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return [NSArray array];
}

- (NSObject *)transformObjectOfOBject:(NSObject *)object
{
    if (object == _squareSpace)
    {
        return _squareSpaceToParentTransform;
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return nil;
}

- (NSObject *)parentOfObject:(NSObject *)object
{
    if (object == _squareSpace)
    {
        return _squareSpaceParent;
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return nil;
}

- (GLKMatrix4)transformatrionMatrixOfObject:(NSObject *)object;
{
    if (object == _squareSpaceToParentTransform)
    {
        return GLKMatrix4MakeScale(_squareSpaceToRootSpaceScale, _squareSpaceToRootSpaceScale, _squareSpaceToRootSpaceScale);
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return GLKMatrix4Identity;
}

- (GLKMatrix4)transformatrionMatrixInverseOfObject:(NSObject *)object
{
    if (object == _squareSpaceToParentTransform)
    {
        return GLKMatrix4MakeScale(1.0f/_squareSpaceToRootSpaceScale, 1.0f/_squareSpaceToRootSpaceScale, 1.0f/_squareSpaceToRootSpaceScale);
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return GLKMatrix4Identity;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    {
        glUseProgram(_program.name);
        glEnableVertexAttribArray(_aPosition);
        glEnableVertexAttribArray(_aGridValue);
        float vertices[] = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 0.0f,
            1.0f, 1.0f,
        };
        float GridVals[] = {
            0.0f, 0.0f,
            0.0f, 32.0f,
            32.0f, 0.0f,
            32.0f, 32.0f,
        };
        GLKMatrix4 MVPMatrix = GLKMatrix4Identity;
        MVPMatrix = GLKMatrix4Scale(MVPMatrix, 2.0f, 2.0f, 1.0f);
        MVPMatrix = GLKMatrix4Translate(MVPMatrix, -0.5f, -0.5f, 0.0f);
        glUniformMatrix4fv(_uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
        glUniform4f(_uColor, 0.0f, 0.8f, 0.0f, 1.0f);
        glUniform1f(_uExponent, 1.0f/((sinf(_exponent)+1.0f)*2.0f*0.3f+20.0f));
        glVertexAttribPointer(_aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, vertices);
        glVertexAttribPointer(_aGridValue, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, GridVals);
        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        glDisable(GL_BLEND);
        glUseProgram(0);
    }
    {
        glUseProgram(_program2.name);
        glEnableVertexAttribArray(_program2.aPosition);
        float vertexPositions[] = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 0.0f,
            1.0f, 1.0f,
        };
        GLKMatrix4 MVPMatrix = [self transformationMatrixFromSpace:_squareSpace toSpace:_rootSpace];
        glUniformMatrix4fv(_program2.uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
        glVertexAttribPointer(_program2.aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, vertexPositions);
        glUniform3f(_program2.uColor, 0.6f, 0.2f, 0.95f);
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        glUseProgram(0);
    }
}

@end
