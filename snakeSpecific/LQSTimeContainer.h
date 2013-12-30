//
//  LQSTimeContainer.h
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTimeKeeper.h"
#import "ILQSTimeContainer.h"

@interface LQSTimeContainer : NSObject<ILQSTimeKeeper,ILQSTimeContainer>

@property (nonatomic) double timeSinceFirstResume;
@property (nonatomic) double timeSinceLastUpdate;

@end
