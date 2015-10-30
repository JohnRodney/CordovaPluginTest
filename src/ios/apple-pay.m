#import "apple-pay.h"

@implementation ApplePay

- (void)setMerchantId:(CDVInvokedUrlCommand*)command
{
  merchantId = [command.arguments objectAtIndex:0];
  NSLog(@"ApplePay set merchant id to %@", merchantId);

  NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                                @"true", @"success",
                                nil
                          ];

  CDVPluginResult *pluginResult = [ CDVPluginResult
                                    resultWithStatus    : CDVCommandStatus_OK
                                    messageAsDictionary : jsonObj
                                  ];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
 }

- (void)getAllowsApplePay:(CDVInvokedUrlCommand*)command
{
    if (merchantId == nil) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Please call setMerchantId() with your Apple-given merchant ID."];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        return;
    }

    PKPaymentRequest *request = [Stripe
                                 paymentRequestWithMerchantIdentifier:merchantId];

    // Configure a dummy request
    NSString *label = @"Premium Llama Food";
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"10.00"];
    request.paymentSummaryItems = @[
                                    [PKPaymentSummaryItem summaryItemWithLabel:label
                                                                        amount:amount]
                                    ];

    if ([Stripe canSubmitPaymentRequest:request]) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"user has apple pay"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } else {
#if DEBUG
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"in debug mode, simulating apple pay"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
#else
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"user does not have apple pay"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
#endif
    }
}

@end
