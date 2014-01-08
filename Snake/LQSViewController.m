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
#import "LQSJoystickScript.h"
#import "LQSSnakeChunkArray.h"
#import "LQSSnakeChunkSpawner.h"
#import <Foundation/NSBundle.h>

@implementation LQSViewController
{
    NSObject<ILQSUpdatable> *_mainUpdatable;
    NSObject<ILQSTimeContainer> *_mainTimeContainer;
    NSObject<ILQSTouchProcessor> *_mainTouchProcessor;
    NSObject<ILQSDrawable> *_mainDrawable;
    LQSScaleTransformation *_viewScaleTransformation;
    LQSTranslationTransformation *_joystickPosition;
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
        LQSTimeContainer *timeContainer = [[LQSTimeContainer alloc] init];
        LQSTouchBroadcast *touchBroadcast = [[LQSTouchBroadcast alloc] init];
        touchBroadcast.touchProcessorArray = [[LQSTouchProcessorArray alloc] init];
        LQSDrawableParent *drawableParent = [[LQSDrawableParent alloc] init];
        {
            // Create space information for the square being drawn
            LQSTransformationResolver *transformationResolver = [[LQSTransformationResolver alloc] init];
            LQSChildSpace *viewSpace = [[LQSChildSpace alloc] init];
            LQSChildSpace *cameraSpace = [[LQSChildSpace alloc] init];
            LQSChildSpace *gridSpace = [[LQSChildSpace alloc] init];
            NSObject<ILQSColoredVerticesProgram> *program = [[LQSColoredVerticesProgram alloc] initWithContext:context];
            {
                // Set up view space relative to camera space
                viewSpace.parent = cameraSpace;
                LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                LQSScaleTransformation *viewScaleTransformation = [LQSTransformationFactory scaleTransformationWithScaleX:1.0f/self.view.bounds.size.width scaleY:1.0f/self.view.bounds.size.height scaleZ:1];
                [transformationSet.transformationArray addObject:viewScaleTransformation];
                [transformationSet.transformationArray addObject:[LQSTransformationFactory uniformScaleTransformationWithScale:2]];
                [transformationSet.transformationArray addObject:[LQSTransformationFactory translationTransformationWithX:-1 y:-1 z:0]];
                [transformationSet.transformationArray addObject:[LQSTransformationFactory scaleTransformationWithScaleX:1 scaleY:-1 scaleZ:1]];
                viewSpace.transformToParent = transformationSet;
                _viewScaleTransformation = viewScaleTransformation;
            }
            LQSJoystickScript *joystickScript = [[LQSJoystickScript alloc] init];
            {
                joystickScript.transformationResolver = transformationResolver;
                joystickScript.viewSpace = viewSpace;
                [touchBroadcast.touchProcessorArray addObject:joystickScript];
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
                    LQSChildSpace *squareGridSpace = [[LQSChildSpace alloc] init];
                    squareGridSpace.parent = rootSpace;
                    squareGridSpace.transformToParent = scaleTransformation;
                    {
                        // Set up snake script
                        LQSSnakeScript *snakeScript = [[LQSSnakeScript alloc] init];
                        LQSSnakeChunkArray *snakeChunkArray = [[LQSSnakeChunkArray alloc] init];
                        {
                            // Configure components
                            snakeScript.snakeChunkArray = snakeChunkArray;
                        }
                        {
                            // Outside inputs
                            snakeScript.timeKeeper = timeContainer;
                            snakeScript.transformationResolver = transformationResolver;
                            snakeScript.parent = squareGridSpace;
                            snakeScript.viewSpace = viewSpace;
                            snakeScript.drawableParent = drawableParent;
                        }
                        {
                            // Externals
                            [broadcastUpdater.updatableArray addObject:snakeScript];
                        }
                        // Create other stuff required by snake script
                        {
                            // Set up purple square 1
                            // Allocate components
                            LQSSnakeChunk *snakeChunk = [[LQSSnakeChunk alloc] init];
                            LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                            LQSChildSpace *childSubSpace = [[LQSChildSpace alloc] init];
                            LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                            LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
                            LQSTranslationTransformation *translationTransformation = [[LQSTranslationTransformation alloc] init];
                            LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                            LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                            {
                                // Configure components
                                childSpace.transformToParent = transformationSet;
                                childSpace.parent = childSubSpace;
                                childSubSpace.transformToParent = translationTransformation;
                                drawableSquareData.space = childSpace;
                                drawableSquare.squareData = drawableSquareData;
                                // Save component access
                                snakeChunk.space = childSpace;
                                snakeChunk.subSpace = childSubSpace;
                                snakeChunk.rotationTransformation = rotationTransformation;
                                snakeChunk.translationTransformation = translationTransformation;
                                snakeChunk.draw = drawableSquare;
                                snakeChunk.drawData = drawableSquareData;
                            }
                            {
                                // Outside inputs
                                rotationTransformation.radians = 0*6.283185307f/8;
                                rotationTransformation.x = 0;
                                rotationTransformation.y = 0;
                                rotationTransformation.z = 1;
                                translationTransformation.x = 0;
                                translationTransformation.y = 0;
                                translationTransformation.z = 0;
                                [transformationSet.transformationArray addObject:pivotTransformation];
                                [transformationSet.transformationArray addObject:scale2Transformation];
                                [transformationSet.transformationArray addObject:rotationTransformation];
                                childSubSpace.parent = squareGridSpace;
                                drawableSquareData.program = program;
                                drawableSquareData.rootSpace = cameraSpace;
                                drawableSquareData.transformationResolver = transformationResolver;
                                drawableSquareData.colorR = 0.6f;
                                drawableSquareData.colorG = 0.2f;
                                drawableSquareData.colorB = 0;//0.95f;
                            }
                            {
                                // Externals
                                [drawableParent.drawableArray addDrawableObject:drawableSquare];
                                joystickScript.firstChunkPosition = translationTransformation;
                                [snakeScript.snakeChunkArray addObject:snakeChunk];
                            }
                            {
                                // Create snake direction space
                                LQSChildSpace *square1VelocitySpace = [[LQSChildSpace alloc] init];
                                LQSTranslationTransformation *square1VelocityTransformation = [[LQSTranslationTransformation alloc] init];
                                {
                                    // Set up space 1 direction
                                    {
                                        square1VelocitySpace.transformToParent = square1VelocityTransformation;
                                    }
                                    {
                                        // Outside Inputs
                                        square1VelocityTransformation.x = -1;
                                        square1VelocityTransformation.y = 0;
                                        square1VelocityTransformation.z = 0;
                                        square1VelocitySpace.parent = childSubSpace;
                                    }
                                    {
                                        // Externals
                                        snakeScript.directionSpace = square1VelocitySpace;
                                        snakeScript.directionTransformation = square1VelocityTransformation;
                                        joystickScript.nextFirstChunkPosition = square1VelocityTransformation;
                                    }
                                }
                            }
                        }
                        {
                            // Set up purple square 2
                            // Allocate components
                            LQSSnakeChunk *snakeChunk = [[LQSSnakeChunk alloc] init];
                            LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
                            LQSChildSpace *childSubSpace = [[LQSChildSpace alloc] init];
                            LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                            LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
                            LQSTranslationTransformation *translationTransformation = [[LQSTranslationTransformation alloc] init];
                            LQSDrawableSquare *drawableSquare = [[LQSDrawableSquare alloc] init];
                            LQSDrawableSquareData *drawableSquareData = [[LQSDrawableSquareData alloc] init];
                            {
                                // Configure components
                                childSpace.transformToParent = transformationSet;
                                childSpace.parent = childSubSpace;
                                childSubSpace.transformToParent = translationTransformation;
                                drawableSquareData.space = childSpace;
                                drawableSquare.squareData = drawableSquareData;
                                // Save component access
                                snakeChunk.space = childSpace;
                                snakeChunk.subSpace = childSubSpace;
                                snakeChunk.rotationTransformation = rotationTransformation;
                                snakeChunk.translationTransformation = translationTransformation;
                                snakeChunk.draw = drawableSquare;
                                snakeChunk.drawData = drawableSquareData;
                            }
                            {
                                // Outside inputs
                                rotationTransformation.radians = 0*6.283185307f/8;
                                rotationTransformation.x = 0;
                                rotationTransformation.y = 0;
                                rotationTransformation.z = 1;
                                translationTransformation.x = 1;
                                translationTransformation.y = 0;
                                translationTransformation.z = 0;
                                [transformationSet.transformationArray addObject:pivotTransformation];
                                [transformationSet.transformationArray addObject:scale2Transformation];
                                [transformationSet.transformationArray addObject:rotationTransformation];
                                childSubSpace.parent = squareGridSpace;
                                drawableSquareData.program = program;
                                drawableSquareData.rootSpace = cameraSpace;
                                drawableSquareData.transformationResolver = transformationResolver;
                                drawableSquareData.colorR = 0.6f;
                                drawableSquareData.colorG = 0.2f;
                                drawableSquareData.colorB = 0.95f;
                            }
                            {
                                // Externals
                                [drawableParent.drawableArray addDrawableObject:drawableSquare];
                                joystickScript.secondChunkPosition = translationTransformation;
                                [snakeScript.snakeChunkArray addObject:snakeChunk];
                            }
                        }
                        {
                            LQSSnakeChunkSpawner *snakeChunkSpawner = [[LQSSnakeChunkSpawner alloc] init];
                            {
                                // Outside inputs
                                snakeChunkSpawner.pivotTransformation = pivotTransformation;
                                snakeChunkSpawner.scaleTransformation = scale2Transformation;
                                snakeChunkSpawner.parentSpace = squareGridSpace;
                                snakeChunkSpawner.program = program;
                                snakeChunkSpawner.cameraSpace = cameraSpace;
                                snakeChunkSpawner.transformationResolver = transformationResolver;
                            }
                            {
                                // Externals
                                snakeScript.snakeChunkSpawner = snakeChunkSpawner;
                            }
                        }
                    }
                }
            }
            {
                LQSChildSpace *joystickSpace = [[LQSChildSpace alloc] init];
                LQSTranslationTransformation *joystickPosition = [[LQSTranslationTransformation alloc] init];
                {
                    // Link joystick components
                    joystickSpace.parent = viewSpace;
                    joystickSpace.transformToParent = joystickPosition;
                    joystickPosition.x = self.view.bounds.size.width-100;
                    joystickPosition.y = self.view.bounds.size.height-100;
                    joystickPosition.z = 0;
                }
                {
                    // Create the GUI
                    // Allocate the components
                    LQSChildSpace *space = [[LQSChildSpace alloc] init];
                    LQSDrawableSquare *draw = [[LQSDrawableSquare alloc] init];
                    LQSDrawableSquareData *drawData = [[LQSDrawableSquareData alloc] init];
                    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                    LQSTranslationTransformation *pivot = [[LQSTranslationTransformation alloc] init];
                    LQSUniformScaleTransformation *scale1 = [[LQSUniformScaleTransformation alloc] init];
                    LQSScaleTransformation *scale2 = [[LQSScaleTransformation alloc] init];
                    LQSRotationTransformation *rotation = [[LQSRotationTransformation alloc] init];
                    LQSTranslationTransformation *translation = [[LQSTranslationTransformation alloc] init];
                    {
                        // Link the components
                        space.parent = joystickSpace;
                        space.transformToParent = transformationSet;
                        [transformationSet.transformationArray addObject:pivot];
                        [transformationSet.transformationArray addObject:scale1];
                        [transformationSet.transformationArray addObject:scale2];
                        [transformationSet.transformationArray addObject:rotation];
                        [transformationSet.transformationArray addObject:translation];
                        pivot.x = -0.5;
                        pivot.y = -0.5;
                        pivot.z = 0;
                        scale1.scale = 1;
                        scale2.scaleX = 50;
                        scale2.scaleY = 50;
                        scale2.scaleZ = 1;
                        rotation.radians = 0;
                        rotation.x = 0;
                        rotation.y = 0;
                        rotation.z = 1;
                        translation.x = 50;
                        translation.y = 0;
                        translation.z = 0;
                        draw.squareData = drawData;
                        drawData.program = program;
                        drawData.space = space;
                        drawData.rootSpace = cameraSpace;
                        drawData.transformationResolver = transformationResolver;
                        drawData.colorR = 1;
                        drawData.colorG = 1;
                        drawData.colorB = 1;
                        [drawableParent.drawableArray addDrawableObject:draw];
                        joystickScript.rightButtonSpace = space;
                    }
                }
                {
                    // Create the GUI
                    // Allocate the components
                    LQSChildSpace *space = [[LQSChildSpace alloc] init];
                    LQSDrawableSquare *draw = [[LQSDrawableSquare alloc] init];
                    LQSDrawableSquareData *drawData = [[LQSDrawableSquareData alloc] init];
                    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                    LQSTranslationTransformation *pivot = [[LQSTranslationTransformation alloc] init];
                    LQSUniformScaleTransformation *scale1 = [[LQSUniformScaleTransformation alloc] init];
                    LQSScaleTransformation *scale2 = [[LQSScaleTransformation alloc] init];
                    LQSRotationTransformation *rotation = [[LQSRotationTransformation alloc] init];
                    LQSTranslationTransformation *translation = [[LQSTranslationTransformation alloc] init];
                    {
                        // Link the components
                        space.parent = joystickSpace;
                        space.transformToParent = transformationSet;
                        [transformationSet.transformationArray addObject:pivot];
                        [transformationSet.transformationArray addObject:scale1];
                        [transformationSet.transformationArray addObject:scale2];
                        [transformationSet.transformationArray addObject:rotation];
                        [transformationSet.transformationArray addObject:translation];
                        pivot.x = -0.5;
                        pivot.y = -0.5;
                        pivot.z = 0;
                        scale1.scale = 1;
                        scale2.scaleX = 50;
                        scale2.scaleY = 50;
                        scale2.scaleZ = 1;
                        rotation.radians = 0;
                        rotation.x = 0;
                        rotation.y = 0;
                        rotation.z = 1;
                        translation.x = 0;
                        translation.y = 50;
                        translation.z = 0;
                        draw.squareData = drawData;
                        drawData.program = program;
                        drawData.space = space;
                        drawData.rootSpace = cameraSpace;
                        drawData.transformationResolver = transformationResolver;
                        drawData.colorR = 1;
                        drawData.colorG = 1;
                        drawData.colorB = 1;
                        [drawableParent.drawableArray addDrawableObject:draw];
                        joystickScript.downButtonSpace = space;
                    }
                }
                {
                    // Create the GUI
                    // Allocate the components
                    LQSChildSpace *space = [[LQSChildSpace alloc] init];
                    LQSDrawableSquare *draw = [[LQSDrawableSquare alloc] init];
                    LQSDrawableSquareData *drawData = [[LQSDrawableSquareData alloc] init];
                    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                    LQSTranslationTransformation *pivot = [[LQSTranslationTransformation alloc] init];
                    LQSUniformScaleTransformation *scale1 = [[LQSUniformScaleTransformation alloc] init];
                    LQSScaleTransformation *scale2 = [[LQSScaleTransformation alloc] init];
                    LQSRotationTransformation *rotation = [[LQSRotationTransformation alloc] init];
                    LQSTranslationTransformation *translation = [[LQSTranslationTransformation alloc] init];
                    {
                        // Link the components
                        space.parent = joystickSpace;
                        space.transformToParent = transformationSet;
                        [transformationSet.transformationArray addObject:pivot];
                        [transformationSet.transformationArray addObject:scale1];
                        [transformationSet.transformationArray addObject:scale2];
                        [transformationSet.transformationArray addObject:rotation];
                        [transformationSet.transformationArray addObject:translation];
                        pivot.x = -0.5;
                        pivot.y = -0.5;
                        pivot.z = 0;
                        scale1.scale = 1;
                        scale2.scaleX = 50;
                        scale2.scaleY = 50;
                        scale2.scaleZ = 1;
                        rotation.radians = 0;
                        rotation.x = 0;
                        rotation.y = 0;
                        rotation.z = 1;
                        translation.x = -50;
                        translation.y = 0;
                        translation.z = 0;
                        draw.squareData = drawData;
                        drawData.program = program;
                        drawData.space = space;
                        drawData.rootSpace = cameraSpace;
                        drawData.transformationResolver = transformationResolver;
                        drawData.colorR = 1;
                        drawData.colorG = 1;
                        drawData.colorB = 1;
                        [drawableParent.drawableArray addDrawableObject:draw];
                        joystickScript.leftButtonSpace = space;
                    }
                }
                {
                    // Create the GUI
                    // Allocate the components
                    LQSChildSpace *space = [[LQSChildSpace alloc] init];
                    LQSDrawableSquare *draw = [[LQSDrawableSquare alloc] init];
                    LQSDrawableSquareData *drawData = [[LQSDrawableSquareData alloc] init];
                    LQSTransformationSet *transformationSet = [[LQSTransformationSet alloc] init];
                    LQSTranslationTransformation *pivot = [[LQSTranslationTransformation alloc] init];
                    LQSUniformScaleTransformation *scale1 = [[LQSUniformScaleTransformation alloc] init];
                    LQSScaleTransformation *scale2 = [[LQSScaleTransformation alloc] init];
                    LQSRotationTransformation *rotation = [[LQSRotationTransformation alloc] init];
                    LQSTranslationTransformation *translation = [[LQSTranslationTransformation alloc] init];
                    {
                        // Link the components
                        space.parent = joystickSpace;
                        space.transformToParent = transformationSet;
                        [transformationSet.transformationArray addObject:pivot];
                        [transformationSet.transformationArray addObject:scale1];
                        [transformationSet.transformationArray addObject:scale2];
                        [transformationSet.transformationArray addObject:rotation];
                        [transformationSet.transformationArray addObject:translation];
                        pivot.x = -0.5;
                        pivot.y = -0.5;
                        pivot.z = 0;
                        scale1.scale = 1;
                        scale2.scaleX = 50;
                        scale2.scaleY = 50;
                        scale2.scaleZ = 1;
                        rotation.radians = 0;
                        rotation.x = 0;
                        rotation.y = 0;
                        rotation.z = 1;
                        translation.x = 0;
                        translation.y = -50;
                        translation.z = 0;
                        draw.squareData = drawData;
                        drawData.program = program;
                        drawData.space = space;
                        drawData.rootSpace = cameraSpace;
                        drawData.transformationResolver = transformationResolver;
                        drawData.colorR = 1;
                        drawData.colorG = 1;
                        drawData.colorB = 1;
                        [drawableParent.drawableArray addDrawableObject:draw];
                        joystickScript.upButtonSpace = space;
                    }
                }
                _joystickPosition = joystickPosition;
            }
        }
        _mainUpdatable = broadcastUpdater;
        _mainTimeContainer = timeContainer;
        _mainTouchProcessor = touchBroadcast;
        _mainDrawable = drawableParent;
    }
    [EAGLContext setCurrentContext:savedContext];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _viewScaleTransformation.scaleX = 1.0f/self.view.bounds.size.width;
    _viewScaleTransformation.scaleY = 1.0f/self.view.bounds.size.height;
    _joystickPosition.x = self.view.bounds.size.width-100;
    _joystickPosition.y = self.view.bounds.size.height-100;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    _mainTimeContainer.timeSinceLastResume = self.timeSinceLastResume;
    _mainTimeContainer.timeSinceLastUpdate = self.timeSinceLastUpdate;
    _mainTimeContainer.timeSinceLastDraw = self.timeSinceLastDraw;
    [_mainUpdatable update];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    _viewScaleTransformation.scaleX = 1.0f/self.view.bounds.size.width;
    _viewScaleTransformation.scaleY = 1.0f/self.view.bounds.size.height;
    _joystickPosition.x = self.view.bounds.size.width-100;
    _joystickPosition.y = self.view.bounds.size.height-100;
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
