/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComLightappsIcloudkeyvalueModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComLightappsIcloudkeyvalueModule
@synthesize keyStore;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"99a48cef-4aa3-444b-8f40-e4e63e2d793b";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.lightapps.icloudkeyvalue";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
    keyStore = [[NSUbiquitousKeyValueStore alloc] init];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)getString:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSString *keyString = [TiUtils stringValue:@"key" properties:args def:@""];
    NSString *storedString = [keyStore stringForKey:keyString];
    return storedString;
}

-(void)setString:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSString *keyString = [TiUtils stringValue:@"key" properties:args def:@""];
    NSString *valueString = [TiUtils stringValue:@"value" properties:args def:@""];
    [keyStore setString:valueString forKey:keyString];
    [keyStore synchronize];
}

-(id)getAllValues:(id)args
{
    [keyStore synchronize];
    return [keyStore dictionaryRepresentation];
}

-(void)removeObject:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSString *keyString = [TiUtils stringValue:@"key" properties:args def:@""];
    [keyStore removeObjectForKey: keyString];
}

@end
