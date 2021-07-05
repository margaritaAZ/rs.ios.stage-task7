//
//  RSTextField.m
//  rs.ios.stage-task7
//
//  Created by Маргарита Жучик on 5.07.21.
//

#import "RSTextField.h"

@interface RSTextField () <UITextFieldDelegate>

@end

@implementation RSTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
//        self.clipsToBounds = YES;
//        [self setLeftViewMode:UITextFieldViewModeAlways];

        self.layer.borderColor = [[UIColor colorNamed:@"BlackCoral"] CGColor];
        self.layer.borderWidth = 1.5;
        self.layer.cornerRadius = 5;
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void) setDefaultState {
    self.layer.borderColor = [[UIColor colorNamed:@"BlackCoral"] CGColor];
    self.text = @"";
    self.enabled = YES;
    self.alpha = 1.0;
}

- (void) setDisabledState {
    self.alpha = 0.5;
    self.enabled = NO;
    [self setSuccessState];
}

- (void) setSuccessState {
    self.layer.borderColor = [[UIColor colorNamed:@"TurquoiseGreen"] CGColor];
}

- (void) setErrorState {
    self.layer.borderColor = [[UIColor colorNamed:@"VenetianRed"] CGColor];
}

@end
