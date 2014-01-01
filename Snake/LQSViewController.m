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
#import "LQSSnakeChunk.h"
#import "LQSSnakeScript.h"
#import "ILQSTouchProcessor.h"
#import "LQSBroadcastUpdater.h"
#import "LQSUpdatableArray.h"
#import "LQSTimeContainer.h"
#import "LQSTouchInputState.h"
#import "LQSTouchBroadcast.h"
#import "LQSTouchProcessorArray.h"
#import "LQSMatrixGridProgram.h"
#import "LQSDrawableMatrixGrid.h"
#import "LQSDrawableMatrixGridData.h"
#import "LQSMatrixGridScript.h"
#import <Foundation/NSBundle.h>

@implementation LQSViewController
{
    NSObject<ILQSUpdatable> *_mainUpdatable;
    NSObject<ILQSTimeContainer> *_mainTimeContainer;
    NSObject<ILQSTouchProcessor> *_mainTouchProcessor;
    NSObject<ILQSDrawable> *_mainDrawable;
    
    LQSScaleTransformation *_viewScaleTransformation;
    NSObject<ILQSAdjacentSpace> *_viewSpace;
    NSObject<ILQSAdjacentSpace> *_cameraSpace;
    NSObject<ILQSTransformationResolver> *_transformationResolver;
    
    NSObject<ILQSAdjacentSpace> *_gridSpace;
    NSObject<ILQSMatrixGridProgram> *_matrixGridProgram;
    EAGLContext *_context;
    
    float _exponent;
    LQSDrawableMatrixGridData *_matrixGridData;
    
    NSObject<ILQSSnakeChunk> *_square1;
    NSObject<ILQSSnakeChunk> *_square2;
    NSObject<ILQSSnakeChunk> *_square3;
    
    NSObject<ILQSAdjacentSpace> *_squareGridSpace;
    NSObject<ILQSAdjacentSpace> *_square1VelocitySpace;
    LQSTranslationTransformation *_square1VelocityTransformation;
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
        LQSBroadcastUpdater *broadcastUpdater = [[LQSBroadcastUpdater alloc] init];
        broadcastUpdater.updatableArray = [[LQSUpdatableArray alloc] init];
        _mainUpdatable = broadcastUpdater;
        LQSTimeContainer *timeContainer = [[LQSTimeContainer alloc] init];
        _mainTimeContainer = timeContainer;
        LQSTouchBroadcast *touchBroadcast = [[LQSTouchBroadcast alloc] init];
        touchBroadcast.touchProcessorArray = [[LQSTouchProcessorArray alloc] init];
        _mainTouchProcessor = touchBroadcast;
        {
            // Create space information for the square being drawn
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
                    // Set up grid shader program
                    LQSChildSpace *gridSpaceParent = [[LQSChildSpace alloc] init];
                    gridSpace.parent = gridSpaceParent;
                    gridSpaceParent.parent = rootSpace;
                    gridSpace.transformToParent = [LQSTransformationFactory translationTransformationWithX:-0.5 y:-0.5 z:0];
                    gridSpaceParent.transformToParent = [LQSTransformationFactory uniformScaleTransformationWithScale:2];
                    // Create program
                    LQSMatrixGridProgram *matrixGridProgram = [[LQSMatrixGridProgram alloc] initWithContext:context];
                    _matrixGridProgram = matrixGridProgram;
                    LQSDrawableMatrixGridData *matrixGridData = [[LQSDrawableMatrixGridData alloc] init];
                    matrixGridData.matrixGridProgram = matrixGridProgram;
                    matrixGridData.gridSpace = gridSpace;
                    matrixGridData.cameraSpace = cameraSpace;
                    matrixGridData.transformationResolver = transformationResolver;
                    LQSDrawableMatrixGrid *matrixGrid = [[LQSDrawableMatrixGrid alloc] init];
                    matrixGrid.matrixGridData = matrixGridData;
                    LQSMatrixGridScript *matrixGridScript = [[LQSMatrixGridScript alloc] init];
                    matrixGridScript.matrixGridData = matrixGridData;
                    [drawableParent.drawableArray addDrawableObject:matrixGrid];
                    [broadcastUpdater.updatableArray addObject:matrixGridScript];
                    _matrixGridData = matrixGridData;
                }
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
                    NSObject<ILQSColoredVerticesProgram> *program = [[LQSColoredVerticesProgram alloc] initWithContext:context];
                    LQSChildSpace *squareGridSpace = [[LQSChildSpace alloc] init];
                    _squareGridSpace = squareGridSpace;
                    squareGridSpace.parent = rootSpace;
                    squareGridSpace.transformToParent = scaleTransformation;
                    LQSSnakeChunk *snakeChunk1 = [[LQSSnakeChunk alloc] init];
                    LQSSnakeChunk *snakeChunk2 = [[LQSSnakeChunk alloc] init];
                    LQSSnakeChunk *snakeChunk3 = [[LQSSnakeChunk alloc] init];
                    {
                        // Set up purple square 1
                        // Allocate components
                        LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                        LQSChildSpace *childSubSpace = [[LQSChildSpace alloc] init];
                        LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                        LQSRotationTransformation *rotationTransformation = [LQSTransformationFactory rotationTransformationWithRadians:0*6.283185307f/8 x:0 y:0 z:1];
                        LQSTranslationTransformation *translationTransformation = [LQSTransformationFactory translationTransformationWithX:0 y:0 z:0];
                        LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                        LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                        {
                            // Configure components
                            [transformationSet.transformationArray addTransformation:pivotTransformation];
                            [transformationSet.transformationArray addTransformation:scale2Transformation];
                            [transformationSet.transformationArray addTransformation:rotationTransformation];
                            childSpace.transformToParent = transformationSet;
                            childSpace.parent = childSubSpace;
                            childSubSpace.transformToParent = translationTransformation;
                            childSubSpace.parent = squareGridSpace;
                            drawableSquareData.program = program;
                            drawableSquareData.space = childSpace;
                            drawableSquareData.rootSpace = cameraSpace;
                            drawableSquareData.transformationResolver = transformationResolver;
                            drawableSquareData.colorR = 0.6f;
                            drawableSquareData.colorG = 0.2f;
                            drawableSquareData.colorB = 0;//0.95f;
                            drawableSquare.squareData = drawableSquareData;
                            [drawableParent.drawableArray addDrawableObject:drawableSquare];
                        }
                        // Save component access
                        snakeChunk1.space = childSpace;
                        snakeChunk1.subSpace = childSubSpace;
                        snakeChunk1.rotationTransformation = rotationTransformation;
                        snakeChunk1.translationTransformation = translationTransformation;
                        snakeChunk1.drawData = drawableSquareData;
                        _square1 = snakeChunk1;
                    }
                    {
                        // Set up purple square 2
                        // Allocate components
                        LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                        LQSChildSpace *childSubSpace = [[LQSChildSpace alloc] init];
                        LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                        LQSRotationTransformation *rotationTransformation = [LQSTransformationFactory rotationTransformationWithRadians:0*6.283185307f/8 x:0 y:0 z:1];
                        LQSTranslationTransformation *translationTransformation = [LQSTransformationFactory translationTransformationWithX:1 y:0 z:0];
                        LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                        LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                        {
                            // Configure components
                            [transformationSet.transformationArray addTransformation:pivotTransformation];
                            [transformationSet.transformationArray addTransformation:scale2Transformation];
                            [transformationSet.transformationArray addTransformation:rotationTransformation];
                            childSpace.transformToParent = transformationSet;
                            childSpace.parent = childSubSpace;
                            childSubSpace.transformToParent = translationTransformation;
                            childSubSpace.parent = squareGridSpace;
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
                        // Save component access
                        snakeChunk2.space = childSpace;
                        snakeChunk2.subSpace = childSubSpace;
                        snakeChunk2.rotationTransformation = rotationTransformation;
                        snakeChunk2.translationTransformation = translationTransformation;
                        snakeChunk2.drawData = drawableSquareData;
                        _square2 = snakeChunk2;
                    }
                    {
                        // Set up purple square 3
                        // Allocate components
                        LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                        LQSChildSpace *childSubSpace = [[LQSChildSpace alloc] init];
                        LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                        LQSRotationTransformation *rotationTransformation = [LQSTransformationFactory rotationTransformationWithRadians:0*6.283185307f/8 x:0 y:0 z:1];
                        LQSTranslationTransformation *translationTransformation = [LQSTransformationFactory translationTransformationWithX:2 y:0 z:0];
                        LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                        LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                        {
                            // Configure components
                            [transformationSet.transformationArray addTransformation:pivotTransformation];
                            [transformationSet.transformationArray addTransformation:scale2Transformation];
                            [transformationSet.transformationArray addTransformation:rotationTransformation];
                            childSpace.transformToParent = transformationSet;
                            childSpace.parent = childSubSpace;
                            childSubSpace.transformToParent = translationTransformation;
                            childSubSpace.parent = squareGridSpace;
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
                        // Save component access
                        snakeChunk3.space = childSpace;
                        snakeChunk3.subSpace = childSubSpace;
                        snakeChunk3.rotationTransformation = rotationTransformation;
                        snakeChunk3.translationTransformation = translationTransformation;
                        snakeChunk3.drawData = drawableSquareData;
                        _square3 = snakeChunk3;
                    }
                    {
                        // Set up space 1 direction
                        LQSChildSpace *square1VelocitySpace = [[LQSChildSpace alloc] init];
                        LQSTranslationTransformation *square1VelocityTransformation = [LQSTransformationFactory translationTransformationWithX:-1 y:0 z:0];
                        square1VelocitySpace.transformToParent = square1VelocityTransformation;
                        square1VelocitySpace.parent = snakeChunk1.subSpace;
                        _square1VelocitySpace = square1VelocitySpace;
                        _square1VelocityTransformation = square1VelocityTransformation;
                        {
                            LQSSnakeScript *snakeScript = [[LQSSnakeScript alloc] init];
                            snakeScript.timeKeeper = timeContainer;
                            snakeScript.transformationResolver = transformationResolver;
                            snakeScript.snakeChunk1 = snakeChunk1;
                            snakeScript.snakeChunk2 = snakeChunk2;
                            snakeScript.snakeChunk3 = snakeChunk3;
                            snakeScript.parent = squareGridSpace;
                            snakeScript.directionSpace = square1VelocitySpace;
                            snakeScript.directionTransformation = square1VelocityTransformation;
                            snakeScript.viewSpace = viewSpace;
                            [touchBroadcast.touchProcessorArray addObject:snakeScript];
                            [broadcastUpdater.updatableArray addObject:snakeScript];
                        }
                    }
                }
            }
            _context = context;
            _mainDrawable = drawableParent;
            _viewSpace = viewSpace;
            _cameraSpace = cameraSpace;
            _gridSpace = gridSpace;
            _transformationResolver = transformationResolver;
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
    _mainTimeContainer.timeSinceFirstResume = self.timeSinceFirstResume;
    _mainTimeContainer.timeSinceLastUpdate = self.timeSinceLastUpdate;
    [_mainUpdatable update];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    _viewScaleTransformation.scaleX = 1.0f/self.view.bounds.size.width;
    _viewScaleTransformation.scaleY = 1.0f/self.view.bounds.size.height;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        if (touch.view == self.view)
        {
            [_mainTouchProcessor processTouch:touch];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        if (touch.view == self.view)
        {
            [_mainTouchProcessor processTouch:touch];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        if (touch.view == self.view)
        {
            [_mainTouchProcessor processTouch:touch];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        if (touch.view == self.view)
        {
            [_mainTouchProcessor processTouch:touch];
        }
    }
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [_mainDrawable draw];
}

@end
