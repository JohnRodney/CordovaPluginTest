#import "apple-pay.h"

@implementation ApplePay

- (void)setMerchantId:(CDVInvokedUrlCommand*)command
{
  merchantId = [command.arguments objectAtIndex:0];
  NSLog(@"ApplePay set merchant id to %@", merchantId);

  NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                                @"true", @"success",
                                @merchantId, @"result",
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

}

@end
