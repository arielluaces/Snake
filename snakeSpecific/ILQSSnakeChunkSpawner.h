//
//  ILQSSnakeChunkSpawner.h
//  Snake
//
//  Created by Ariel School on 2014-01-07.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LQSSnakeChunk;

@protocol ILQSSnakeChunkSpawner <NSObject>

- (LQSSnakeChunk *)spawnSnakeChunk;

@end
