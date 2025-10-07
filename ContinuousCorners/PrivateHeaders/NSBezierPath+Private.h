#import <Cocoa/Cocoa.h>
#ifndef NSBezierPath_Private_h
#define NSBezierPath_Private_h

NS_ASSUME_NONNULL_BEGIN

@interface NSBezierPath(Private)

+(instancetype)_bezierPathWithRoundedRect:(NSRect)rect radius:(CGFloat)radius continuousCorners:(BOOL)continuousCorners;

@end

NS_ASSUME_NONNULL_END

#endif /* NSBezierPath_Private_h */
