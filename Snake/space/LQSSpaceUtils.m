//
//  LQSSpaceUtils.m
//  Snake
//
//  Created by Ariel on 2013-09-04.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSSpaceUtils.h"
#import "ILQSAdjacentSpace.h"
#import "ILQSTransformation.h"
#import <GLKit/GLKMatrix4.h>
#import "ILQSSpaceCollection.h"

@implementation LQSSpaceUtils

+ (GLKMatrix4)transformationMatrixFromSpace:(NSObject<ILQSAdjacentSpace> *)space1 toSpace:(NSObject<ILQSAdjacentSpace> *)space2
{
    if (space1 == space2)
    {
        return GLKMatrix4Identity;
    }
    else if ([space1 isAdjacentSpace:space2])
    {
        return [[space1 transformationObjectToSpace:space2] transformationMatrix];
    }
    else if ([space2 isAdjacentSpace:space1])
    {
        // We can either ask the object for the matrix already ionverted or we could invert the matrix ourselves
        // The matrices can be inverted individually or a large set of matrices that need to be inverted can
        // be inverted one chunk after being multiplied together
        return [[space2 transformationObjectToSpace:space1] transformationMatrixInverse];
    }
    else
    {
        // Start looking for longer chains in the directed graph to end up with a path from space1 to space2
        NSMutableArray *space1AdjacencyPath = [[NSMutableArray alloc] init];
        [space1AdjacencyPath addObject:space1];
        NSMutableArray *space2AdjacencyPath = [[NSMutableArray alloc] init];
        [space2AdjacencyPath addObject:space2];
        while (true)
        {
            NSObject<ILQSAdjacentSpace> *space = [space1AdjacencyPath lastObject];
            NSArray *adjacentSpaces = space.adjacentSpaces.toArray;
            NSAssert(adjacentSpaces.count < 2, @"This algorithm doesn work if the number of adjacent spaces to any space is 2 or greater");
            if (adjacentSpaces.count == 0)
            {
                break;
            }
            else if (adjacentSpaces.count == 1)
            {
                NSObject<ILQSAdjacentSpace> *adjacentSpace = adjacentSpaces.lastObject;
                [space1AdjacencyPath addObject:adjacentSpace];
                if (adjacentSpace == space2)
                {
                    GLKMatrix4 transformationMatrix = GLKMatrix4Identity;
                    for (uint i = 0; i < space1AdjacencyPath.count-1; ++i)
                    {
                        NSObject<ILQSAdjacentSpace> *currentAdjacentSpace = [space1AdjacencyPath objectAtIndex:i];
                        NSObject<ILQSAdjacentSpace> *nextAdjacentSpace = [space1AdjacencyPath objectAtIndex:i+1];
                        NSObject<ILQSTransformation> *newTransform = [currentAdjacentSpace transformationObjectToSpace:nextAdjacentSpace];
                        NSAssert(newTransform != nil, @"transform can't be nil");
                        transformationMatrix = GLKMatrix4Multiply(newTransform.transformationMatrix, transformationMatrix);
                    }
                    return transformationMatrix;
                }
                else if (adjacentSpace != space2)
                {
                    continue;
                }
            }
        }
        while (true)
        {
            NSObject<ILQSAdjacentSpace> *space = [space2AdjacencyPath lastObject];
            NSArray *adjacentSpaces = space.adjacentSpaces.toArray;
            NSAssert(adjacentSpaces.count < 2, @"This algorithm doesn work if the number of adjacent spaces to any space is 2 or greater");
            if (adjacentSpaces.count == 0)
            {
                break;
            }
            else if (adjacentSpaces.count == 1)
            {
                NSObject<ILQSAdjacentSpace> *adjacentSpace = adjacentSpaces.lastObject;
                [space2AdjacencyPath addObject:adjacentSpace];
                if (adjacentSpace == space1)
                {
                    GLKMatrix4 transformationMatrix = GLKMatrix4Identity;
                    for (uint i = 0; i < space2AdjacencyPath.count-1; ++i)
                    {
                        NSObject<ILQSAdjacentSpace> *currentAdjacentSpace = [space2AdjacencyPath objectAtIndex:i];
                        NSObject<ILQSAdjacentSpace> *nextAdjacentSpace = [space2AdjacencyPath objectAtIndex:i+1];
                        NSObject<ILQSTransformation> *newTransform = [currentAdjacentSpace transformationObjectToSpace:nextAdjacentSpace];
                        NSAssert(newTransform != nil, @"transform can't be nil");
                        transformationMatrix = GLKMatrix4Multiply(transformationMatrix, newTransform.transformationMatrixInverse);
                    }
                    return transformationMatrix;
                }
                else if (adjacentSpace != space1)
                {
                    continue;
                }
            }
        }
        //Next we must find the first object that is in common with the two adjacent space adjacency paths
        NSAssert([space1AdjacencyPath lastObject] == [space2AdjacencyPath lastObject], @"should be the same if adjacency paths merged at a common adjacent space");
        {
            //We can trim away some common spaces so that we don't have to calculate and multiply transformations that will collide with their inverses and be negated
            while (true)
            {
                NSObject<ILQSAdjacentSpace> *space1AdjacentSecondLastObject = [space1AdjacencyPath objectAtIndex:[space1AdjacencyPath count]-2];
                NSObject<ILQSAdjacentSpace> *space2AdjacentSecondLastObject = [space2AdjacencyPath objectAtIndex:[space2AdjacencyPath count]-2];
                if (space1AdjacentSecondLastObject == space2AdjacentSecondLastObject)
                {
                    [space1AdjacencyPath removeLastObject];
                    [space2AdjacencyPath removeLastObject];
                }
                else if (space1AdjacentSecondLastObject != space2AdjacentSecondLastObject)
                {
                    break;
                }
            }
        }
        {
            GLKMatrix4 transformationMatrixSpace1;
            GLKMatrix4 transformationMatrixSpace2;
            {
                GLKMatrix4 transformationMatrix = GLKMatrix4Identity;
                for (uint i = 0; i < space1AdjacencyPath.count-1; ++i)
                {
                    NSObject<ILQSAdjacentSpace> *currentAdjacentSpace = [space1AdjacencyPath objectAtIndex:i];
                    NSObject<ILQSAdjacentSpace> *nextAdjacentSpace = [space1AdjacencyPath objectAtIndex:i+1];
                    NSObject<ILQSTransformation> *newTransform = [currentAdjacentSpace transformationObjectToSpace:nextAdjacentSpace];
                    NSAssert(newTransform != nil, @"transform can't be nil");
                    transformationMatrix = GLKMatrix4Multiply(newTransform.transformationMatrix, transformationMatrix);
                }
                transformationMatrixSpace1 = transformationMatrix;
            }
            {
                GLKMatrix4 transformationMatrix = GLKMatrix4Identity;
                for (uint i = 0; i < space2AdjacencyPath.count-1; ++i)
                {
                    NSObject<ILQSAdjacentSpace> *currentAdjacentSpace = [space2AdjacencyPath objectAtIndex:i];
                    NSObject<ILQSAdjacentSpace> *nextAdjacentSpace = [space2AdjacencyPath objectAtIndex:i+1];
                    NSObject<ILQSTransformation> *newTransform = [currentAdjacentSpace transformationObjectToSpace:nextAdjacentSpace];
                    NSAssert(newTransform != nil, @"transform can't be nil");
                    transformationMatrix = GLKMatrix4Multiply(transformationMatrix, newTransform.transformationMatrixInverse);
                }
                transformationMatrixSpace2 = transformationMatrix;
            }
            return GLKMatrix4Multiply(transformationMatrixSpace2, transformationMatrixSpace1);
        }
    }
    NSAssert(FALSE, @"This is not suppoed to run");
    return GLKMatrix4Identity;
}

@end
