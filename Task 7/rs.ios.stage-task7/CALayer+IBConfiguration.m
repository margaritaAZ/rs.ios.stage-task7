//
//  CALayer+IBConfiguration.m
//  rs.ios.stage-task7
//
//  Created by Маргарита Жучик on 3.07.21.
//

#import "CALayer+IBConfiguration.h"


@implementation CALayer (IBConfiguration)

-(void)setBorderIBColor:(UIColor *) color{
    self.borderColor = color.CGColor;
}
 
-(UIColor*)borderIBColor{
    return [UIColor colorWithCGColor:self.borderColor];
}
 
@end
