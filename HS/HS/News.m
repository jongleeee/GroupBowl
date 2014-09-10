//
//  News.m
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "News.h"

@implementation News
- (id)init
{
    self = [super init];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self)
    {
        _name = [coder decodeObjectForKey:@"name"];
        _text = [coder decodeObjectForKey:@"text"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.text forKey:@"text"];
}
@end
