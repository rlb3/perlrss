#import <Cocoa/Cocoa.h>
#import "libetpan.h"

#define DEST_CHARSET "iso-8859-1"
@interface CTMIMEParser : NSObject {
}
+ (NSString *)decodeMIMEBodyFromMessage:(struct mailmessage *)message mime:(struct mailmime *)mimeBody;
+ (NSString *)decodeMIMEPhrase:(char *)data;
+ (BOOL)isMIMEText:(struct mailmime *)mimeStruct;
+ (NSString *)decodeMIMESubType:(struct mailmime *)data;
@end
