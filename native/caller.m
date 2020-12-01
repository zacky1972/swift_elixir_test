#ifdef EXIST_FOUNDATION
#import <Foundation/Foundation.h>
#endif

#import "ExampleClass-Swift.h"
#import "caller.h"

void caller()
{
	ExampleClass *obj = [[ExampleClass alloc] init];
	[obj increment];
#ifdef WORK_NSLOG
	NSLog(@"Hello world from Objective-C.");
#endif
}
