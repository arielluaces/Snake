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
#import "LQSScaledTranslationTransformation.h"
#import "LQSScaleTransformation.h"
#import <Foundation/NSBundle.h>

@implementation LQSViewController
{
    LQSScaleTransformation *_viewScaleTransformation;
    NSObject<ILQSAdjacentSpace> *_viewSpace;
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
    
    LQSRotationTransformation *_squareRotationTransformation;
    NSObject<ILQSAdjacentSpace> *_square1Space;
    NSObject<ILQSAdjacentSpace> *_square2Space;
    NSObject<ILQSAdjacentSpace> *_square3Space;
    LQSDrawableSquareData *_square1Data;
    LQSDrawableSquareData *_square2Data;
    LQSDrawableSquareData *_square3Data;
    LQSTranslationTransformation *_square1TranslationTransformation;
    LQSTranslationTransformation *_square2TranslationTransformation;
    LQSTranslationTransformation *_square3TranslationTransformation;
    
    float _velocityX;
    float _velocityY;
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
    {
        // Create space information for the square being drawn
        _velocityX = -1;
        _velocityY = 0;
        LQSTransformationResolver *transformationResolver = [[LQSTransformationResolver alloc] init];
        LQSDrawableParent *drawableParent = [[LQSDrawableParent alloc] init];
        LQSChildSpace *viewSpace = [[LQSChildSpace alloc] init];
        LQSChildSpace *cameraSpace = [[LQSChildSpace alloc] init];
        LQSChildSpace *gridSpace = [[LQSChildSpace alloc] init];
        {
            // Set up view space relative to camera space
            viewSpace.parent = cameraSpace;
            LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
            LQSScaleTransformation *viewScaleTransformation = [LQSTransformationFactory scaleTransformationWithScaleX:1.0f/self.view.bounds.size.width scaleY:1.0f/self.view.bounds.size.height scaleZ:1];
            [transformationSet.transformationArray addTransformation:viewScaleTransformation];
            [transformationSet.transformationArray addTransformation:[LQSTransformationFactory uniformScaleTransformationWithScale:2]];
            [transformationSet.transformationArray addTransformation:[LQSTransformationFactory translationTransformationWithX:-1 y:-1 z:0]];
            [transformationSet.transformationArray addTransformation:[LQSTransformationFactory scaleTransformationWithScaleX:1 scaleY:-1 scaleZ:1]];
            viewSpace.transformToParent = transformationSet;
            _viewScaleTransformation = viewScaleTransformation;
        }
        {
            LQSRootSpace *rootSpace = [[LQSRootSpace alloc] init];
            cameraSpace.parent = rootSpace;
            cameraSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:0 y:0 z:0];
            {
                // Set up textured square
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
                NSObject<ILQSTransformation> *pivotTransformation = [LQSTransformationFactory translationTransformationWithX:-0.5 y:-0.5 z:0];
                NSObject<ILQSTransformation> *scaleTransformation = [LQSTransformationFactory uniformScaleTransformationWithScale:1.0f/16.0f];
                NSObject<ILQSTransformation> *scale2Transformation = [LQSTransformationFactory uniformScaleTransformationWithScale:0.9f];
                LQSRotationTransformation *rotationTransformation = [LQSTransformationFactory rotationTransformationWithRadians:0*6.283185307f/8 x:0 y:0 z:1];
                NSObject<ILQSColoredVerticesProgram> *program = [[LQSColoredVerticesProgram alloc] initWithContext:context];
                {
                    // Set up purple square 1
                    LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                    [transformationSet.transformationArray addTransformation:pivotTransformation];
                    [transformationSet.transformationArray addTransformation:rotationTransformation];
                    [transformationSet.transformationArray addTransformation:scale2Transformation];
                    LQSTranslationTransformation *translationTransformation = [LQSTransformationFactory translationTransformationWithX:0 y:0 z:0];
                    _square1TranslationTransformation = translationTransformation;
                    [transformationSet.transformationArray addTransformation:translationTransformation];
                    [transformationSet.transformationArray addTransformation:scaleTransformation];
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
                        drawableSquareData.colorB = 0;//0.95f;
                        drawableSquare.squareData = drawableSquareData;
                        [drawableParent.drawableArray addDrawableObject:drawableSquare];
                        _square1Data = drawableSquareData;
                    }
                    _square1Space = childSpace;
                }
                {
                    // Set up purple square 2
                    LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                    [transformationSet.transformationArray addTransformation:pivotTransformation];
                    [transformationSet.transformationArray addTransformation:rotationTransformation];
                    [transformationSet.transformationArray addTransformation:scale2Transformation];
                    LQSTranslationTransformation *translationTransformation = [LQSTransformationFactory translationTransformationWithX:1 y:0 z:0];
                    _square2TranslationTransformation = translationTransformation;
                    [transformationSet.transformationArray addTransformation:translationTransformation];
                    [transformationSet.transformationArray addTransformation:scaleTransformation];
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
                        _square2Data = drawableSquareData;
                    }
                    _square2Space = childSpace;
                }
                {
                    // Set up purple square 3
                    LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                    [transformationSet.transformationArray addTransformation:pivotTransformation];
                    [transformationSet.transformationArray addTransformation:rotationTransformation];
                    [transformationSet.transformationArray addTransformation:scale2Transformation];
                    LQSTranslationTransformation *translationTransformation = [LQSTransformationFactory translationTransformationWithX:2 y:0 z:0];
                    _square3TranslationTransformation = translationTransformation;
                    [transformationSet.transformationArray addTransformation:translationTransformation];
                    [transformationSet.transformationArray addTransformation:scaleTransformation];
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
                        _square3Data = drawableSquareData;
                    }
                    _square3Space = childSpace;
                }
                _squareRotationTransformation = rotationTransformation;
            }
            {
                // Set up grid shader program
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
        _context = context;
        _drawable = drawableParent;
        _viewSpace = viewSpace;
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
    if (self.timeSinceFirstResume>5)
    {
        if (floor(self.timeSinceFirstResume)!=floor(self.timeSinceFirstResume-self.timeSinceLastUpdate))
        {
            if (rand()%4==0)
            {
                int change = rand()%2;
                switch (change)
                {
                    case 0:
                    {
                        GLKVector3 oldVelocity = GLKVector3Make(_velocityX, _velocityY, 0);
                        GLKVector3 newVelocity = GLKMatrix3MultiplyVector3(GLKMatrix3MakeRotation(6.283185307f/4, 0, 0, 1), oldVelocity);
                        _velocityX = newVelocity.x;
                        _velocityY = newVelocity.y;
                        break;
                    }
                    case 1:
                    {
                        GLKVector3 oldVelocity = GLKVector3Make(_velocityX, _velocityY, 0);
                        GLKVector3 newVelocity = GLKMatrix3MultiplyVector3(GLKMatrix3MakeRotation(-6.283185307f/4, 0, 0, 1), oldVelocity);
                        _velocityX = newVelocity.x;
                        _velocityY = newVelocity.y;
                        break;
                    }
                    case 2:
                    {
                        GLKVector3 oldVelocity = GLKVector3Make(_velocityX, _velocityY, 0);
                        GLKVector3 newVelocity = GLKMatrix3MultiplyVector3(GLKMatrix3MakeRotation(0, 0, 0, 1), oldVelocity);
                        _velocityX = newVelocity.x;
                        _velocityY = newVelocity.y;
                        break;
                    }
                    default:
                        break;
                };
            }
            _square3TranslationTransformation.x = _square2TranslationTransformation.x;
            _square3TranslationTransformation.y = _square2TranslationTransformation.y;
            _square2TranslationTransformation.x = _square1TranslationTransformation.x;
            _square2TranslationTransformation.y = _square1TranslationTransformation.y;
            _square1TranslationTransformation.x = _square1TranslationTransformation.x+_velocityX;
            _square1TranslationTransformation.y = _square1TranslationTransformation.y+_velocityY;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        if (touch.view == self.view)
        {
            _viewScaleTransformation.scaleX = 1.0f/self.view.bounds.size.width;
            _viewScaleTransformation.scaleY = 1.0f/self.view.bounds.size.height;
            CGPoint locationInView = [touch locationInView:self.view];
            GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_square1Space];
            GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
            vector = GLKMatrix4MultiplyVector4(matrix, vector);
            NSLog(@"[%f,%f,%f]", vector.x, vector.y, vector.z);
            if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
            {
                _square1Data.colorB = 0;
                NSLog(@"hit");
            }
            else
            {
                _square1Data.colorB = 0.95f;
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        if (touch.view == self.view)
        {
            _viewScaleTransformation.scaleX = 1.0f/self.view.bounds.size.width;
            _viewScaleTransformation.scaleY = 1.0f/self.view.bounds.size.height;
            CGPoint locationInView = [touch locationInView:self.view];
            GLKMatrix4 matrix = [_transformationResolver transformationMatrixFromSpace:_viewSpace toSpace:_square1Space];
            GLKVector4 vector = GLKVector4Make(locationInView.x, locationInView.y, 0, 1);
            vector = GLKMatrix4MultiplyVector4(matrix, vector);
            NSLog(@"[%f,%f,%f]", vector.x, vector.y, vector.z);
            if (vector.x >= 0.0f && vector.x <= 1.0f && vector.y >= 0.0f && vector.y <= 1.0f)
            {
                _square1Data.colorB = 0;
                NSLog(@"hit");
            }
            else
            {
                _square1Data.colorB = 0.95f;
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    _square1Data.colorB = 0.95f;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//    _square1Data.colorB = 0.95f;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    {
//        glUseProgram(_program.name);
//        glEnableVertexAttribArray(_aPosition);
//        glEnableVertexAttribArray(_aTexCoord);
//        float positions[] = {
//            0.0f, 0.0f,
//            0.0f, 1.0f,
//            1.0f, 0.0f,
//            1.0f, 1.0f,
//        };
//        float texCoords[] = {
//            0.0f, 0.0f,
//            0.0f, 32.0f,
//            32.0f, 0.0f,
//            32.0f, 32.0f,
//        };
//        GLKMatrix4 MVPMatrix = [_transformationResolver transformationMatrixFromSpace:_gridSpace toSpace:_cameraSpace];
//        glUniformMatrix4fv(_uMVPMatrix, 1, GL_FALSE, MVPMatrix.m);
//        glUniform4f(_uColor, 0.0f, 0.8f, 0.0f, 1.0f);
//        glUniform1f(_uExponent, 1.0f/((sinf(_exponent)+1.0f)*2.0f*0.3f+20.0f));
//        glVertexAttribPointer(_aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, positions);
//        glVertexAttribPointer(_aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(float)*2, texCoords);
//        glEnable(GL_BLEND);
//        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
//        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
//        glDisable(GL_BLEND);
//        glUseProgram(0);
    }
    {
        [_drawable draw];
    }
}

@end
