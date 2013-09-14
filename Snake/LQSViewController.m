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
#import "LQSChildSpace.h"
#import "LQSRootSpace.h"
#import "LQSUniformScaleTransformation.h"
#import "ILQSSpaceCollection.h"
#import "LQSSpaceUtils.h"
#import "LQSTranslationTransformation.h"
#import "LQSDrawableSquare.h"
#import "LQSDrawableSquareData.h"
#import "LQSDrawableParent.h"
#import "ILQSDrawableArray.h"
#import "LQSTransformationFactory.h"
#import "LQSTexturedVerticesProgram.h"

@implementation LQSViewController
{
    NSObject<ILQSAdjacentSpace> *_cameraSpace;
    
    NSObject<ILQSGLProgram> *_program;
    EAGLContext *_context;
    GLuint _aPosition;
    GLuint _aGridValue;
    GLint _uMVPMatrix;
    GLint _uColor;
    GLint _uExponent;
    
    float _exponent;
    
    NSObject<ILQSDrawable> *_drawable;
    
    NSObject<ILQSTexturedVerticesProgram> *_texProgram;
    NSObject<ILQSAdjacentSpace> *_textureSpace;
    GLuint _textureName;
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
    NSBundle *textureBundle = [NSBundle mainBundle];
    NSString *texturePath = [textureBundle pathForResource:@"fff7dce8bab7b1f11abd79c84ad9247e" ofType:@"png"];
    NSError *textureLoaderError = nil;
    GLKTextureInfo *texureInfo = [GLKTextureLoader textureWithContentsOfFile:texturePath options:nil error:&textureLoaderError];
    _textureName = texureInfo.name;
    glBindTexture(GL_TEXTURE_2D, 0);
    // Create space information for the square being drawn
    LQSChildSpace *cameraSpace = [[LQSChildSpace alloc] init];
    LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
    LQSChildSpace *parentSpace = [[LQSChildSpace alloc] init];
    LQSChildSpace *childSpace2 = [[LQSChildSpace alloc] init];
    LQSChildSpace *parentSpace2 = [[LQSChildSpace alloc] init];
    LQSChildSpace *childSpace3 = [[LQSChildSpace alloc] init];
    LQSChildSpace *parentSpace3 = [[LQSChildSpace alloc] init];
    LQSChildSpace *textureSpace = [[LQSChildSpace alloc] init];
    LQSChildSpace *textureSpaceParent = [[LQSChildSpace alloc] init];
    LQSRootSpace *rootSpace = [[LQSRootSpace alloc] init];
    childSpace.parent = parentSpace;
    childSpace2.parent = parentSpace2;
    childSpace3.parent = parentSpace3;
    parentSpace.parent = rootSpace;
    parentSpace2.parent = rootSpace;
    parentSpace3.parent = rootSpace;
    textureSpace.parent = textureSpaceParent;
    textureSpaceParent.parent = rootSpace;
    cameraSpace.parent = rootSpace;
    textureSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:-0.5 y:-0.5 z:0];
    textureSpaceParent.transformToParent = [LQSTransformationFactory uniformScaleTransformationWithScale:2.0f/16.0f];
    cameraSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:0 y:0 z:0];
    {
        NSObject<ILQSTransformation> *transformToParent = [LQSTransformationFactory uniformScaleTransformationWithScale:1.0f/16.0f];
        childSpace.transformToParent = transformToParent;
        childSpace2.transformToParent = transformToParent;
        childSpace3.transformToParent = transformToParent;
    }
    parentSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:1.0f/32.0f+1.0f/16.0f*0 y:1.0f/32.0f z:0];
    parentSpace2.transformToParent = [LQSTransformationFactory translationTransformationWithX:1.0f/32.0f+1.0f/16.0f*2 y:1.0f/32.0f z:0];
    parentSpace3.transformToParent = [LQSTransformationFactory translationTransformationWithX:1.0f/32.0f+1.0f/16.0f*4 y:1.0f/32.0f z:0];
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
    }
    _texProgram = [[LQSTexturedVerticesProgram alloc] initWithContext:_context];
    // Create second program
    NSObject<ILQSColoredVerticesProgram> *program = [[LQSColoredVerticesProgram alloc] initWithContext:_context];
    LQSDrawableParent *drawableParent = [[LQSDrawableParent alloc] init];
    _drawable = drawableParent;
    {
        LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
        LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
        drawableSquareData.program = program;
        drawableSquareData.space = childSpace;
        drawableSquareData.rootSpace = cameraSpace;
        drawableSquareData.colorR = 0.6f;
        drawableSquareData.colorG = 0.2f;
        drawableSquareData.colorB = 0.95f;
        drawableSquare.squareData = drawableSquareData;
        [drawableParent.drawableArray addDrawableObject:drawableSquare];
    }
    {
        LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
        LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
        drawableSquareData.program = program;
        drawableSquareData.space = childSpace2;
        drawableSquareData.rootSpace = cameraSpace;
        drawableSquareData.colorR = 0.6f;
        drawableSquareData.colorG = 0.2f;
        drawableSquareData.colorB = 0.95f;
        drawableSquare.squareData = drawableSquareData;
        [drawableParent.drawableArray addDrawableObject:drawableSquare];
    }
    {
        LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
        LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
        drawableSquareData.program = program;
        drawableSquareData.space = childSpace3;
        drawableSquareData.rootSpace = cameraSpace;
        drawableSquareData.colorR = 0.6f;
        drawableSquareData.colorG = 0.2f;
        drawableSquareData.colorB = 0.95f;
        drawableSquare.squareData = drawableSquareData;
        [drawableParent.drawableArray addDrawableObject:drawableSquare];
    }
    _cameraSpace = cameraSpace;
    _textureSpace = textureSpace;
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
        [_drawable draw];
    }
    {
        glUseProgram(_texProgram.name);
        glEnableVertexAttribArray(_texProgram.aPosition);
        glEnableVertexAttribArray(_texProgram.aTexCoord);
        float positions[] = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 0.0f,
            1.0f, 1.0f,
        };
        float texCoords[] = {
            0.0f, 1.0f,
            0.0f, 0.0f,
            1.0f, 1.0f,
            1.0f, 0.0f,
        };
        GLKMatrix4 MVPMatrix = [LQSSpaceUtils transformationMatrixFromSpace:_textureSpace toSpace:_cameraSpace];
        glUniformMatrix4fv(_texProgram.uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
        glVertexAttribPointer(_texProgram.aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, positions);
        glVertexAttribPointer(_texProgram.aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, texCoords);
        glBindTexture(GL_TEXTURE_2D, _textureName);
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        glUseProgram(0);
    }
}

@end
