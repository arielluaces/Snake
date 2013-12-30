//
//  LQSTouchBroadcast.h
//  Snake
//
//  Created by Ariel School on 2013-12-30.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTouchProcessor.h"

@protocol ILQSTouchProcessorCollection;

@interface LQSTouchBroadcast : NSObject<ILQSTouchProcessor>

@property (nonatomic) NSObject<ILQSTouchProcessorCollection> *touchProcessorArray;

@end
