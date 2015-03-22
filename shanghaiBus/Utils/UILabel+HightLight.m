//
//  UILabel+HightLight.m
//  CTRIP_WIRELESS
//
//  Created by Sou Dai on 14-6-25.
//  Copyright (c) 2014年 携程. All rights reserved.
//

#import "UILabel+HightLight.h"

@interface CTYouthAttribution : NSObject
@property (strong) NSString *attributionKey;
@property (strong) id       attributionValue;
@property (assign) NSRange  applyRange;

-(id) initWithKey:(NSString*)key value:(id)value range:(NSRange)range;
@end

@implementation CTYouthAttribution

-(id) initWithKey:(NSString*)key value:(id)value range:(NSRange)range{
    self = [super init];
    if (self) {
        _attributionKey = key;
        _attributionValue = value;
        _applyRange = range;
    }
    
    return self;
}

@end

@implementation UILabel (HightLight)
-(void)highLightTextInRange:(NSRange)range forColor:(UIColor*)color{
    if (color == nil) {
        return;
    }
    
    CTYouthAttribution* attribute = [[CTYouthAttribution alloc] initWithKey:NSForegroundColorAttributeName value:color range:range];
    
    [self addAttributions:@[attribute]];
}

-(void)addAttributions:(NSArray*)attributes{
    if (attributes.count < 1) {
        return;
    }
    
    NSMutableAttributedString *attributedValue = [self.attributedText mutableCopy];
    
    [attributedValue beginEditing];
    
    for (CTYouthAttribution* attribute in attributes) {
        [attributedValue addAttribute:attribute.attributionKey value:attribute.attributionValue range:attribute.applyRange];
    }
    
    [attributedValue endEditing];
    [self setAttributedText:attributedValue];
}

- (void)setUnderline
{
    if (self.text.length > 0) {
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.text];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        
        self.attributedText = content;
    }
}

- (void)setNoUnderline
{
    if (self.text.length > 0) {
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.text];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:contentRange];
        
        self.attributedText = content;
    }
}



@end
