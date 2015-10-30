#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <PassKit/PassKit.h>
#import <Cordova/CDV.h>

@interface ApplePay : CDVPlugin

<
PKPaymentAuthorizationViewControllerDelegate
>
{
    NSString *merchantId;
    NSString *callbackId;
}

- (void)setMerchantId:(CDVInvokedUrlCommand*)command;
- (void)getAllowsApplePay:(CDVInvokedUrlCommand*)command;
- (void)getStripeToken:(CDVInvokedUrlCommand*)command;

@end
