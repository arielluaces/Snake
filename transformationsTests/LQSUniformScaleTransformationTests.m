//
//  LQSUniformScaleTransformationTests.m
//  Snake
//
//  Created by Ariel School on 2014-01-05.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "LQSUniformScaleTransformation.h"
#import <SenTestingKit/SenTestingKit.h>

@interface LQSUniformScaleTransformationTests : SenTestCase

@end

@implementation LQSUniformScaleTransformationTests

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

- (void)testZeroUniformScaleTransformation
{
    {
        LQSUniformScaleTransformation *uniformScaleTransformation = [[LQSUniformScaleTransformation alloc] init];
        uniformScaleTransformation.scale = 1;
        STAssertNoThrow(uniformScaleTransformation.transformationMatrixInverse, @"The uniform scale transformation should be producing inverse transformation matrices under normal circumstances");
    }
    {
        LQSUniformScaleTransformation *uniformScaleTransformation = [[LQSUniformScaleTransformation alloc] init];
        uniformScaleTransformation.scale = 0;
        STAssertThrows(uniformScaleTransformation.transformationMatrixInverse, @"The uniform scale transformation shouldn't be producing inverse transformation matrices when the scale property is zero");
    }
}

@end
