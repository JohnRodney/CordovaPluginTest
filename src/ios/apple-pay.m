#import "apple-pay.h"

@implementation ApplePay

- (void)setMerchantId:(CDVInvokedUrlCommand*)command
{
  /* Set the merchantID to the argument string passed */
  merchantId = [command.arguments objectAtIndex:0];

  /* Create a string to pass back to JavaScript as the result key in a json Object */
  NSString *result = [merchantId stringByAppendingString:@" has been set as MerchantId"];

  /* Log the message to the native Log program */
  NSLog(@"ApplePay set merchant id to %@", merchantId);

  /* create a dictionary jsonObj to return as the result of this function */
  NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                                @"true", @"success",
                                result, @"result",
                                nil
                          ];

  /* create a plugin result object with set params to return to JS */
  CDVPluginResult *pluginResult = [ CDVPluginResult
                                    resultWithStatus    : CDVCommandStatus_OK
                                    messageAsDictionary : jsonObj
                                  ];

  /* send the created message back to JS by calling the passed success callback */
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
 }

- (void)getAllowsApplePay:(CDVInvokedUrlCommand*)command
{
  /* if the merchantID has not yet been set then return a failed calledback message */
  if (merchantId == nil) {
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Please call setMerchantId() with your Apple-given merchant ID."];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    return;
  }

  /* if the device can use apple pay check */
  if (PKAuthorizationViewController.canMakePayments()) {
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"true"];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    return;
  } else {
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"false"];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    return;
  }

}

@end
