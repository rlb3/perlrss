#import <Foundation/Foundation.h>
#import <MailCore/MailCore.h>

@interface Email : NSObject {
    NSDictionary *config;
}

@property (nonatomic, copy) NSDictionary *config;

- (Email *)initWithConfig:(NSDictionary *) aConfig;
- (void)sendWithModules:(NSArray *) modules;
@end
