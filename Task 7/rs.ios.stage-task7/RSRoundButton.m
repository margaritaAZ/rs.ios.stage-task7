//
//  RSRoundButton.m
//  rs.ios.stage-task7
//
//  Created by Маргарита Жучик on 5.07.21.
//

#import "RSRoundButton.h"

@interface RSRoundButton ()

@end

@implementation RSRoundButton

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.borderColor = [[UIColor colorNamed:@"LittleBoyBlue"] CGColor];
        self.layer.borderWidth = 1.5;
        self.layer.cornerRadius = 25;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void) highliteButton {
    self.backgroundColor = [UIColor colorNamed:@"LittleBoyBlue0.2"];
}

- (void) setDefaultState {
    self.backgroundColor = [UIColor whiteColor];
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (![super pointInside:point withEvent:event])
        {
            return NO;
        }
        BOOL isInside = (pow((point.x - self.frame.size.width/2), 2) + pow((point.y - self.frame.size.height/2), 2) < pow((self.frame.size.width/2), 2)) ? YES:NO;
        return isInside;
}

@end
