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
#import "LQSColoredVerticesProgram.h"
#import "LQSChildSpace.h"
#import "LQSRootSpace.h"
#import "LQSUniformScaleTransformation.h"
#import "ILQSSpaceCollection.h"
#import "LQSTransformationResolver.h"
#import "LQSTranslationTransformation.h"
#import "LQSDrawableSquare.h"
#import "LQSDrawableSquareData.h"
#import "LQSDrawableParent.h"
#import "ILQSDrawableArray.h"
#import "LQSTransformationFactory.h"
#import "LQSTexturedVerticesProgram.h"
#import "LQSDrawableTexturedSquare.h"
#import "LQSDrawableTexturedSquareData.h"
#import "LQSGLTexture.h"
#import "LQSRotationTransformation.h"
#import "LQSTransformationSet.h"
#import "LQSTransformationArray.h"
#import <Foundation/NSBundle.h>

@implementation LQSViewController
{
    NSObject<ILQSAdjacentSpace> *_cameraSpace;
    NSObject<ILQSTransformationResolver> *_transformationResolver;
    
    NSObject<ILQSAdjacentSpace> *_gridSpace;
    NSObject<ILQSGLProgram> *_program;
    EAGLContext *_context;
    GLuint _aPosition;
    GLuint _aTexCoord;
    GLint _uMVPMatrix;
    GLint _uColor;
    GLint _uExponent;
    
    float _exponent;
    
    NSObject<ILQSDrawable> *_drawable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSAssert(context != nil, @"Failed to create ES context");
    self.glkView.context = context;
    self.glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    EAGLContext *savedContext = [EAGLContext currentContext];
    [EAGLContext setCurrentContext:context];
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    // Create space information for the square being drawn
    LQSTransformationResolver *transformationResolver = [[LQSTransformationResolver alloc] init];
    LQSDrawableParent *drawableParent = [[LQSDrawableParent alloc] init];
    LQSChildSpace *cameraSpace = [[LQSChildSpace alloc] init];
    LQSChildSpace *gridSpace = [[LQSChildSpace alloc] init];
    {
        LQSRootSpace *rootSpace = [[LQSRootSpace alloc] init];
        cameraSpace.parent = rootSpace;
        cameraSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:0 y:0 z:0];
        {
            NSObject<ILQSTransformation> *pivotTransformation = [LQSTransformationFactory translationTransformationWithX:-0.5 y:-0.5 z:0];
            NSObject<ILQSTransformation> *scaleTransformation = [LQSTransformationFactory uniformScaleTransformationWithScale:1.0f/16.0f];
            NSObject<ILQSTransformation> *rotationTransformation = [LQSTransformationFactory rotationTransformationWithRadians:6.283185307f/8 x:0 y:0 z:1];
            NSObject<ILQSColoredVerticesProgram> *program = [[LQSColoredVerticesProgram alloc] initWithContext:context];
            {
                LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                [transformationSet.transformationArray addTransformation:pivotTransformation];
                [transformationSet.transformationArray addTransformation:scaleTransformation];
                [transformationSet.transformationArray addTransformation:rotationTransformation];
                [transformationSet.transformationArray addTransformation:[LQSTransformationFactory translationTransformationWithX:1.0f/16.0f*0 y:1.5f/16.0f z:0]];
                childSpace.parent = rootSpace;
                childSpace.transformToParent = transformationSet;
                {
                    LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                    LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                    drawableSquareData.program = program;
                    drawableSquareData.space = childSpace;
                    drawableSquareData.rootSpace = cameraSpace;
                    drawableSquareData.transformationResolver = transformationResolver;
                    drawableSquareData.colorR = 0.6f;
                    drawableSquareData.colorG = 0.2f;
                    drawableSquareData.colorB = 0.95f;
                    drawableSquare.squareData = drawableSquareData;
                    [drawableParent.drawableArray addDrawableObject:drawableSquare];
                }
            }
            {
                LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                [transformationSet.transformationArray addTransformation:pivotTransformation];
                [transformationSet.transformationArray addTransformation:scaleTransformation];
                [transformationSet.transformationArray addTransformation:rotationTransformation];
                [transformationSet.transformationArray addTransformation:[LQSTransformationFactory translationTransformationWithX:1.0f/16.0f*2 y:1.5f/16.0f z:0]];
                childSpace.parent = rootSpace;
                childSpace.transformToParent = transformationSet;
                {
                    LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                    LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                    drawableSquareData.program = program;
                    drawableSquareData.space = childSpace;
                    drawableSquareData.rootSpace = cameraSpace;
                    drawableSquareData.transformationResolver = transformationResolver;
                    drawableSquareData.colorR = 0.6f;
                    drawableSquareData.colorG = 0.2f;
                    drawableSquareData.colorB = 0.95f;
                    drawableSquare.squareData = drawableSquareData;
                    [drawableParent.drawableArray addDrawableObject:drawableSquare];
                }
            }
            {
                LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                [transformationSet.transformationArray addTransformation:pivotTransformation];
                [transformationSet.transformationArray addTransformation:scaleTransformation];
                [transformationSet.transformationArray addTransformation:rotationTransformation];
                [transformationSet.transformationArray addTransformation:[LQSTransformationFactory translationTransformationWithX:1.0f/16.0f*4 y:1.5f/16.0f z:0]];
                childSpace.parent = rootSpace;
                childSpace.transformToParent = transformationSet;
                {
                    LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                    LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                    drawableSquareData.program = program;
                    drawableSquareData.space = childSpace;
                    drawableSquareData.rootSpace = cameraSpace;
                    drawableSquareData.transformationResolver = transformationResolver;
                    drawableSquareData.colorR = 0.6f;
                    drawableSquareData.colorG = 0.2f;
                    drawableSquareData.colorB = 0.95f;
                    drawableSquare.squareData = drawableSquareData;
                    [drawableParent.drawableArray addDrawableObject:drawableSquare];
                }
            }
        }
        {
            LQSChildSpace *textureSpace = [[LQSChildSpace alloc] init];
            LQSChildSpace *textureSpaceParent = [[LQSChildSpace alloc] init];
            textureSpace.parent = textureSpaceParent;
            textureSpaceParent.parent = rootSpace;
            textureSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:-0.5 y:-0.5 z:0];
            textureSpaceParent.transformToParent = [LQSTransformationFactory uniformScaleTransformationWithScale:2.0f/16.0f];
            {
                LQSDrawableTexturedSquare *drawableTexturedSquare = [[LQSDrawableTexturedSquare alloc] init];
                LQSDrawableTexturedSquareData *drawableTexturedSquareData = [[LQSDrawableTexturedSquareData alloc] init];
                drawableTexturedSquareData.program = [[LQSTexturedVerticesProgram alloc] initWithContext:context];
                {
                    NSBundle *textureBundle = [NSBundle mainBundle];
                    NSString *texturePath = [textureBundle pathForResource:@"fff7dce8bab7b1f11abd79c84ad9247e" ofType:@"png"];
                    NSError *textureLoaderError = nil;
                    GLKTextureInfo *texureInfo = [GLKTextureLoader textureWithContentsOfFile:texturePath options:nil error:&textureLoaderError];
                    LQSGLTexture *texture = [[LQSGLTexture alloc] init];
                    texture.name = texureInfo.name;
                    glBindTexture(GL_TEXTURE_2D, 0);
                    drawableTexturedSquareData.texture = texture;
                }
                drawableTexturedSquareData.squareSpace = textureSpace;
                drawableTexturedSquareData.cameraSpace = cameraSpace;
                drawableTexturedSquareData.transformationResolver = transformationResolver;
                drawableTexturedSquare.squareData = drawableTexturedSquareData;
                [drawableParent.drawableArray addDrawableObject:drawableTexturedSquare];
            }
        }
        {
            LQSChildSpace *gridSpaceParent = [[LQSChildSpace alloc] init];
            gridSpace.parent = gridSpaceParent;
            gridSpaceParent.parent = rootSpace;
            gridSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:-0.5 y:-0.5 z:0];
            gridSpaceParent.transformToParent = [LQSTransformationFactory uniformScaleTransformationWithScale:2];
            {
                // Create program
                {
                    const GLchar *vertexShaderSourceC = [LQSGLFileUtils loadVertexShaderSource:@"MatrixGrid"];
                    const GLchar *fragmentShaderSourceC = [LQSGLFileUtils loadFragmentShaderSource:@"MatrixGrid"];
                    NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC context:context];
                    NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC context:context];
                    _program = [[LQSProgram alloc] initWithVertexShader:vertexShader fragmentShader:fragmentShader context:context];
                }
                int aPosition = glGetAttribLocation(_program.name, "aPosition");
                NSAssert(aPosition >= 0, @"%@ attribute not found", @"aPosition");
                int aTexCoord = glGetAttribLocation(_program.name, "aTexCoord");
                NSAssert(aTexCoord >= 0, @"%@ attribute not found", @"aTexCoord");
                int uMVPMatrix = glGetUniformLocation(_program.name, "uMVPMatrix");
                NSAssert(uMVPMatrix >= 0, @"%@ unifrom not found", @"uMVPMatrix");
                int uColor = glGetUniformLocation(_program.name, "uColor");
                NSAssert(uColor >= 0, @"%@ unifrom not found", @"uColor");
                int uExponent = glGetUniformLocation(_program.name, "uExponent");
                NSAssert(uExponent >= 0, @"%@ uniform not found", @"uExponent");
                _aPosition = (GLuint)aPosition;
                _aTexCoord = (GLuint)aTexCoord;
                _uMVPMatrix = (GLint)uMVPMatrix;
                _uColor = (GLint)uColor;
                _uExponent = (GLint)uExponent;
            }
        }
    }
    {
        _context = context;
        _drawable = drawableParent;
        _cameraSpace = cameraSpace;
        _gridSpace = gridSpace;
        _transformationResolver = transformationResolver;
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

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    {
        glUseProgram(_program.name);
        glEnableVertexAttribArray(_aPosition);
        glEnableVertexAttribArray(_aTexCoord);
        float positions[] = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 0.0f,
            1.0f, 1.0f,
        };
        float texCoords[] = {
            0.0f, 0.0f,
            0.0f, 32.0f,
            32.0f, 0.0f,
            32.0f, 32.0f,
        };
        GLKMatrix4 MVPMatrix = [_transformationResolver transformationMatrixFromSpace:_gridSpace toSpace:_cameraSpace];
        glUniformMatrix4fv(_uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
        glUniform4f(_uColor, 0.0f, 0.8f, 0.0f, 1.0f);
        glUniform1f(_uExponent, 1.0f/((sinf(_exponent)+1.0f)*2.0f*0.3f+20.0f));
        glVertexAttribPointer(_aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, positions);
        glVertexAttribPointer(_aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, texCoords);
        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        glDisable(GL_BLEND);
        glUseProgram(0);
    }
    {
        [_drawable draw];
    }
}

@end
