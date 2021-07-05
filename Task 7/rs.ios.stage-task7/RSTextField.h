//
//  RSTextField.h
//  rs.ios.stage-task7
//
//  Created by Маргарита Жучик on 5.07.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTextField : UITextField
- (void) setDefaultState;
- (void) setSuccessState;
- (void) setErrorState;
- (void) setDisabledState;
@end

NS_ASSUME_NONNULL_END
