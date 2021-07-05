//
//  AuthorizationViewController.m
//  AuthorizationScreen
//
//  Created by Надежда Зенкова on 03.07.2021.
//

#import <UIKit/UIKit.h>
#import "AuthorizationViewController.h"
#import "UIButton+BackgroundColor.h"
#import "RefreshAlertViewController.h"

typedef NS_ENUM(NSUInteger, TextfieldCondition) {
    ready,
    error,
    success,
};

typedef NS_ENUM(NSUInteger, ButtonCondition) {
    defaultCondition,
    highlighted,
    disabled,
};

typedef NS_ENUM(NSUInteger, SecureCondition) {
    readySecure,
    errorSecure,
    successSecure,
};

@interface AuthorizationViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;
@property (weak, nonatomic) IBOutlet UIView *secureView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;

@property TextfieldCondition textfieldCondition;
@property ButtonCondition buttonCondition;
@property SecureCondition secureCondition;

@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *resultCode;
@property (weak, nonatomic) RefreshAlertViewController *refreshAlert;

@property (strong, nonatomic) NSMutableString *result;

@end

@implementation AuthorizationViewController

-(void) refresh {
    [self setLabel];
    [self setTextFields];
    [self setButton];
    [self setSecureView];
}

- (IBAction)pressAuthorizeButton:(id)sender {
    [self.loginTextField.text isEqual: self.login] ? [self updateTextField:self.loginTextField :success] : [self updateTextField:self.loginTextField :error];
    [self.passwordTextField.text isEqual: self.password] ? [self updateTextField:self.passwordTextField :success] : [self updateTextField:self.passwordTextField :error];
    
    if ([self.loginTextField.text isEqual: self.login] && [self.passwordTextField.text isEqual: self.password]) {
        [self.secureView setHidden:NO];
        [self updateButton:disabled];
        [self.loginTextField setUserInteractionEnabled:NO];
        [self.passwordTextField setUserInteractionEnabled:NO];
        [self.loginTextField.layer setBorderColor: [[UIColor colorNamed:@"ASTurquoiseGreen"] colorWithAlphaComponent:0.5].CGColor];
        [self.passwordTextField.layer setBorderColor: [[UIColor colorNamed:@"ASTurquoiseGreen"] colorWithAlphaComponent:0.5].CGColor];
    }
}
- (IBAction)pressOneButton:(id)sender {
    if (self.result.length < 5) {
        [self.result appendString:@"1"];
        if (self.result.length < 5) {
            [self.result appendString:@" "];
        }
        [self updateResult];
    }
}
- (IBAction)pressTwoButton:(id)sender {
    if (self.result.length < 5) {
        [self.result appendString:@"2"];
        if (self.result.length < 5) {
            [self.result appendString:@" "];
        }
        [self updateResult];
    }
}
- (IBAction)pressThreeButton:(id)sender {
    if (self.result.length < 5) {
        [self.result appendString:@"3"];
        if (self.result.length < 5) {
            [self.result appendString:@" "];
        }
        [self updateResult];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"ASWhite"];
    
    self.login = @"username";
    self.password = @"password";
    self.resultCode = @"1 3 2";
    
    [self setLabel];
    [self setTextFields];
    [self setButton];
    [self setSecureView];
    [self hideWhenTappedAround];
}

- (void)setLabel {
    [self.textLabel setText: @"RSSchool"];
    [self.textLabel setFont:[UIFont systemFontOfSize:36.0 weight:UIFontWeightBold]];
    [self.textLabel setTextColor:[UIColor colorNamed:@"ASBlack"]];
}

- (void)setTextFields {
    [self.loginTextField setText:@""];
    [self.passwordTextField setText:@""];
    [self.loginTextField setUserInteractionEnabled:YES];
    [self.passwordTextField setUserInteractionEnabled:YES];
    self.loginTextField.layer.cornerRadius = 5;
    self.loginTextField.layer.borderWidth = 1.5;
    [self.loginTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.loginTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.loginTextField setPlaceholder:@"Login"];
    [self.loginTextField.layer setBorderColor: [UIColor colorNamed:@"ASBlackCoral"].CGColor];
    [self.loginTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.loginTextField.delegate = self;
    
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.layer.borderWidth = 1.5;
    [self.passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.passwordTextField setPlaceholder:@"Password"];
    [self.passwordTextField.layer setBorderColor: [UIColor colorNamed:@"ASBlackCoral"].CGColor];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.passwordTextField.delegate = self;
}

- (void)updateTextField:(UITextField *)textField :(TextfieldCondition)condition {
    switch (condition) {
        case ready:
            [textField.layer setBorderColor: [UIColor colorNamed:@"ASBlackCoral"].CGColor];
            break;
        case error:
            [textField.layer setBorderColor: [UIColor colorNamed:@"ASVenetianRed"].CGColor];
            break;
        case success:
             [textField.layer setBorderColor: [UIColor colorNamed:@"ASTurquoiseGreen"].CGColor];
            break;
    }
}

- (void)setButton {
    [self.authorizeButton setUserInteractionEnabled:YES];    
    [self.authorizeButton.layer setBorderColor: [UIColor colorNamed:@"ASLittleBoyBlue"].CGColor];
    self.authorizeButton.layer.borderWidth = 2.0;
    self.authorizeButton.layer.cornerRadius = 10.0;
    [self.authorizeButton setTitle:@"Authorize" forState:normal];
    [self.authorizeButton.titleLabel setTextColor: [UIColor colorNamed:@"ASLittleBoyBlue"]];
    [self.authorizeButton.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightSemibold]];
    [self.authorizeButton setImage:[UIImage imageNamed:@"user"] forState:normal];
    self.authorizeButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    self.authorizeButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [self.authorizeButton setClipsToBounds:YES];
    self.authorizeButton.layer.opacity = 1.0;
    [self.authorizeButton setImage:[UIImage imageNamed:@"userFilled"] forState:UIControlStateHighlighted];
    [self.authorizeButton setTitleColor:[[UIColor colorNamed:@"ASLittleBoyBlue"] colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
    [self.authorizeButton setBackgroundColor:[[UIColor colorNamed:@"ASLittleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
    [self.authorizeButton setTitleColor:[[UIColor colorNamed:@"ASLittleBoyBlue"] colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
}

- (void)updateButton:(ButtonCondition)condition {
    switch (condition) {
        case defaultCondition:
            [self.authorizeButton.layer setBorderColor: [UIColor colorNamed:@"ASLittleBoyBlue"].CGColor];
            [self.authorizeButton.titleLabel setTextColor: [UIColor colorNamed:@"ASLittleBoyBlue"]];
            break;
        case highlighted:
            self.authorizeButton.titleLabel.textColor = [[UIColor colorNamed:@"ASLittleBoyBlue"] colorWithAlphaComponent:0.4];
            break;
        case disabled:
            self.authorizeButton.layer.opacity = 0.5;
            [self.authorizeButton setUserInteractionEnabled:NO];
            break;
    }
}

- (void)setSecureView {
    [self.secureView setHidden:YES];
    self.secureView.layer.borderWidth = 0.0;
    self.secureView.layer.cornerRadius = 10.0;
    self.result = [[NSMutableString alloc] initWithString:@""];
    
    [self.resultLabel setText: @"_"];
    [self.resultLabel setFont:[UIFont systemFontOfSize:18.0 weight:UIFontWeightSemibold]];
    [self.resultLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.oneButton setTitle:@"1" forState:normal];
    [self.oneButton.titleLabel setTextColor:[UIColor colorNamed:@"ASLittleBoyBlue"]];
    [self.oneButton.titleLabel setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold]];
    [self.oneButton.layer setBorderColor: [UIColor colorNamed:@"ASLittleBoyBlue"].CGColor];
    self.oneButton.layer.borderWidth = 1.5;
    self.oneButton.layer.cornerRadius = 25.0;
    self.oneButton.clipsToBounds = YES;
    [self.oneButton setBackgroundColor:[[UIColor colorNamed:@"ASLittleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
    
    [self.twoButton setTitle:@"2" forState:normal];
    [self.twoButton.titleLabel setTextColor:[UIColor colorNamed:@"ASLittleBoyBlue"]];
    [self.twoButton.titleLabel setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold]];
    [self.twoButton.layer setBorderColor: [UIColor colorNamed:@"ASLittleBoyBlue"].CGColor];
    self.twoButton.layer.borderWidth = 1.5;
    self.twoButton.layer.cornerRadius = 25.0;
    self.twoButton.clipsToBounds = YES;
    [self.twoButton setBackgroundColor:[[UIColor colorNamed:@"ASLittleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
    
    [self.threeButton setTitle:@"3" forState:normal];
    [self.threeButton.titleLabel setTextColor:[UIColor colorNamed:@"ASLittleBoyBlue"]];
    [self.threeButton.titleLabel setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold]];
    [self.threeButton.layer setBorderColor: [UIColor colorNamed:@"ASLittleBoyBlue"].CGColor];
    self.threeButton.layer.borderWidth = 1.5;
    self.threeButton.layer.cornerRadius = 25.0;
    self.threeButton.clipsToBounds = YES;
    [self.threeButton setBackgroundColor:[[UIColor colorNamed:@"ASLittleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
}

-(void)updateResult {
    if (self.resultLabel.text.length < 5) {
        [self.resultLabel setText:self.result];
        [self updateSecureView:readySecure];
    }
    
    if (self.result.length == 5 && [self.result isEqual:self.resultCode]) {
        [self updateSecureView:successSecure];
        self.result = [NSMutableString stringWithString:@""];
        [self.resultLabel setText:@"_"];
        [RefreshAlertViewController refreshFor:self];
    } else if (self.result.length == 5 && ![self.result isEqual:self.resultCode]) {
        [self updateSecureView:errorSecure];
        self.result = [NSMutableString stringWithString:@""];
        [self.resultLabel setText:@"_"];
    }
}

- (void)updateSecureView:(SecureCondition)condition {
    switch (condition) {
        case readySecure:
            self.secureView.layer.borderWidth = 0.0;
            break;
        case errorSecure:
            [self.secureView.layer setBorderColor: [UIColor colorNamed:@"ASVenetianRed"].CGColor];
            self.secureView.layer.borderWidth = 2.0;
            break;
        case successSecure:
            [self.secureView.layer setBorderColor: [UIColor colorNamed:@"ASTurquoiseGreen"].CGColor];
            self.secureView.layer.borderWidth = 2.0;
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField isEqual:self.passwordTextField] ? [self.view endEditing:true] : [self.passwordTextField becomeFirstResponder];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gesture];
}

- (void)dismissKeyboard {
    [self.view endEditing:true];
}

- (void)textFieldDidChange:(UITextField *)textField {
    [self updateTextField:textField :ready];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.loginTextField) {
        NSCharacterSet *blockedCharacters = [[NSCharacterSet letterCharacterSet] invertedSet];
        return ([string rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    } else {
        return YES;
    }
}

@end
