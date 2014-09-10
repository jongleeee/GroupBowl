//
//  Event.m
//  HS
//
//  Created by Irene Lee on 7/21/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "Event.h"

@implementation Event
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
        _title = [coder decodeObjectForKey:@"title"];
        _content = [coder decodeObjectForKey:@"content"];
        _datePicked = [coder decodeObjectForKey:@"datePicked"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.content forKey:@"content"];
    [coder encodeObject:self.datePicked forKey:@"datePicked"];
}
@end
