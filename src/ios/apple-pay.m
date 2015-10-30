#import "apple-pay.h"

@implementation ApplePay

- (void)setMerchantId:(CDVInvokedUrlCommand*)command
{
    merchantId = [command.arguments objectAtIndex:0];
    NSLog(@"ApplePay set merchant id to %@", merchantId);
}

@end
