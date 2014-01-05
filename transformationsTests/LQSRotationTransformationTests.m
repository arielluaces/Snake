//
//  LQSRotationTransformationTests.m
//  Snake
//
//  Created by Ariel School on 2014-01-05.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "LQSRotationTransformation.h"
#import <SenTestingKit/SenTestingKit.h>

@interface LQSRotationTransformationTests : SenTestCase

@end

@implementation LQSRotationTransformationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    STFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testZeroVectorRotation
{
    {
        LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
        rotationTransformation.radians = 0;
        rotationTransformation.x = 0;
        rotationTransformation.y = 0;
        rotationTransformation.z = 1;
        STAssertNoThrow(rotationTransformation.transformationMatrix, @"The rotation transformation should be producing transformation matrices under normal circumstances");
        STAssertNoThrow(rotationTransformation.transformationMatrixInverse, @"The rotation transformation should be producing inverse transformation matrices under normal circumstances");
    }
    {
        LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
        rotationTransformation.radians = 0;
        rotationTransformation.x = 0;
        rotationTransformation.y = 0;
        rotationTransformation.z = 0;
        STAssertThrows(rotationTransformation.transformationMatrix, @"The rotation transformation shouldn't be producing transformation matrices when the x, y, and z components are all zero");
        STAssertThrows(rotationTransformation.transformationMatrixInverse, @"The rotation transformation shouldn't be producing inverse transformation matrices when the x, y, and z components are all zero");
    }
    {
        LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
        rotationTransformation.radians = 100;
        rotationTransformation.x = 0;
        rotationTransformation.y = 0;
        rotationTransformation.z = 0;
        STAssertThrows(rotationTransformation.transformationMatrix, @"The rotation transformation shouldn't be producing transformation matrices when the x, y, and z components are all zero");
        STAssertThrows(rotationTransformation.transformationMatrixInverse, @"The rotation transformation shouldn't be producing inverse transformation matrices when the x, y, and z components are all zero");
    }
    {
        LQSRotationTransformation *rotationTransformation = [[LQSRotationTransformation alloc] init];
        rotationTransformation.radians = -100;
        rotationTransformation.x = 0;
        rotationTransformation.y = 0;
        rotationTransformation.z = 0;
        STAssertThrows(rotationTransformation.transformationMatrix, @"The rotation transformation shouldn't be producing transformation matrices when the x, y, and z components are all zero");
        STAssertThrows(rotationTransformation.transformationMatrixInverse, @"The rotation transformation shouldn't be producing inverse transformation matrices when the x, y, and z components are all zero");
    }
}

@end
