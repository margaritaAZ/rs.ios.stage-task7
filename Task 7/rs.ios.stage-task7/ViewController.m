//
//  ViewController.m
//  rs.ios.stage-task7
//
//  Created by Маргарита Жучик on 2.07.21.
//

#import "ViewController.h"
#import "RSTextField.h"
#import "RSButton.h"
#import "RSRoundButton.h"

static NSString *userName = @"username";
static NSString *password = @"password";
static NSString *secretCode = @"132";

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet RSTextField *loginTextField;
@property (weak, nonatomic) IBOutlet RSTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet RSButton *authorizeUIButton;
@property (strong, nonatomic) IBOutlet UIView *secureView;
@property (weak, nonatomic) IBOutlet RSRoundButton *roundButton1;
@property (weak, nonatomic) IBOutlet RSRoundButton *roundButton2;
@property (weak, nonatomic) IBOutlet RSRoundButton *roundButton3;
@property (weak, nonatomic) IBOutlet UILabel *secureCode;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorizeBottomConstraint;

@end

@interface ViewController (KeyboardHandling)
- (void)subscribeOnKeyboardEvents;
- (void)updateTopConstraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // authorize button actions
    [self.authorizeUIButton addTarget:self action:@selector(authorizeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.authorizeUIButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
    
    // round buttons actions
    [self.roundButton1 addTarget:self action:@selector(roundButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.roundButton2 addTarget:self action:@selector(roundButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.roundButton3 addTarget:self action:@selector(roundButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.roundButton1 addTarget:self action:@selector(roundButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.roundButton2 addTarget:self action:@selector(roundButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.roundButton3 addTarget:self action:@selector(roundButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    
    // Subscrube on keyboard events
    [self subscribeOnKeyboardEvents];
    [self hideWhenTappedAround];
    
    // Set delegates
    self.loginTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}

- (void) authorizeButtonTapped: (RSButton *) sender {
    [sender setDefaultState];
    [self validateLoginAndPassword];
}

- (void) validateLoginAndPassword {
    if ([self.loginTextField.text isEqual:userName] && [self.passwordTextField.text isEqual:password])  {
        [self.view endEditing:YES];
        [self.secureView setHidden:NO];
        
        [self.loginTextField setDisabledState];
        [self.passwordTextField setDisabledState];
        
        [self.authorizeUIButton setDisabledState];
        
    } else {
        if (![self.loginTextField.text isEqual:userName]) {
            [self.loginTextField setErrorState];
        } else {
            [self.loginTextField setSuccessState];
        }
        if (![self.passwordTextField.text isEqual:password]) {
            [self.passwordTextField setErrorState];
        } else {
            [self.passwordTextField setSuccessState];
        }
    }
}

- (void) buttonHighlight: (RSButton *) sender {
    [sender highliteButton];
}

- (void) roundButtonHighlight: (RSRoundButton *)sender {
    [sender highliteButton];
}

- (void) roundButtonTapped: (RSRoundButton *) sender {
    [sender setDefaultState];
    NSString *code = [[NSString alloc] init];
    code = [self.secureCode.text stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if (code.length == 0) {
        self.secureView.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
    code = [code stringByAppendingString:[NSString stringWithFormat:@"%li",(long)sender.tag]];
    if (code.length < 4) {
        self.secureCode.text = code;
        if (code.length == 3) {
            if ([code isEqual:secretCode]) {
                self.secureView.layer.borderColor = [[UIColor colorNamed:@"TurquoiseGreen"] CGColor];
                [self showAlertWindow];
            } else {
                self.secureView.layer.borderColor = [[UIColor colorNamed:@"VenetianRed"] CGColor];
                self.secureCode.text = @"_";
            }
        }
    }
}

- (void) showAlertWindow {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Welcome"
                                                                   message:@"You are successfully authorized!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Refresh"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
        [self setViewDefaultState];}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) setViewDefaultState {
    // username
    [self.loginTextField setDefaultState];
    
    // password
    [self.passwordTextField setDefaultState];
    
    //authorize button
    [self.authorizeUIButton setDefaultState];
    
    // secure view
    [self.secureView setHidden:YES];
    self.secureView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.secureCode.text = @"_";
}


// MARK: - Delegates

// TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 1 && ![self.loginTextField.text isEqual:@"username"]) {
        [self.loginTextField setDefaultState];
    }
    if (textField.tag == 2 && ![self.passwordTextField.text isEqual:@"password"]) {
        [self.passwordTextField setDefaultState];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [super viewWillDisappear:animated];
}
@end


// MARK: - Keyboard category

@implementation ViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents {
    // Keyboard will show
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    // Keyboard will hide
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

- (void)keybaordWillShow:(NSNotification *)notification {
    CGRect kbRect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect aRect = self.view.frame;
        aRect.size.height -= kbRect.size.height;
        if (!CGRectContainsPoint(aRect, self.authorizeUIButton.frame.origin) ) {
            [self updateTopConstraintWith:15.0 andBottom: 35.0];
        }
}

- (void)keybaordWillHide:(NSNotification *)notification {
    [self updateTopConstraintWith:80.0 andBottom:60.0];
}

- (void)updateTopConstraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
    // Change your constraint constants
    self.topConstraint.constant = constant;
    self.authorizeBottomConstraint.constant = bottomConstant;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
