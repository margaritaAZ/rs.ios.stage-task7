//
//  RSButton.m
//  rs.ios.stage-task7
//
//  Created by Маргарита Жучик on 5.07.21.
//

#import "RSButton.h"

@implementation RSButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.borderColor = [[UIColor colorNamed:@"LittleBoyBlue"] CGColor];
        self.layer.borderWidth = 2;
        self.layer.cornerRadius = 10;
        [self setImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
        self.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 5);
        self.titleEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 0);
    }
    return self;
}

- (void) highliteButton {
    self.backgroundColor = [UIColor colorNamed:@"LittleBoyBlue0.2"];
    self.titleLabel.alpha = 0.4;
    [self setImage:[UIImage imageNamed:@"person-fill.png"] forState:UIControlStateHighlighted];
}

- (void) setDefaultState {
    self.backgroundColor = [UIColor whiteColor];
    self.alpha = 1.0;
    self.enabled = YES;
    self.titleLabel.alpha = 1.0;
}

- (void) setDisabledState {
    self.enabled = NO;
    self.alpha = 0.5;
}

@end
