//
//  NiceWindowScripting.m
//  NicePlayer
//
//  Created by Robert Chin on 2/13/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "NiceWindow.h"
#import "NiceDocument.h"
#import "NiceControllerScripting.h"

@implementation NiceWindow (NiceWindowScripting)

-(void)handleFullScreenCommand:(id)sender
{
	[[NiceController controller] handleEnterFullScreen:self];
}

-(void)handleNormalScreenCommand:(id)sender
{
	[[NiceController controller] handleExitFullScreen:self];
}

-(void)handleToggleFullScreenCommand:(id)sender
{
	[[NiceController controller] handleToggleFullScreen:self];
}

-(void)handleAddURLToPlaylistCommand:(id)sender
{
	NSDictionary *eArgs = [sender evaluatedArguments];
	NSURL *newURL = (NSURL *)CFURLCreateWithFileSystemPath(NULL, (CFStringRef)[eArgs objectForKey:@"file"],
														   kCFURLHFSPathStyle, NO);
	if([eArgs objectForKey:@"atIndex"] != nil)
		[[[self windowController] document] addURLToPlaylist:newURL
													 atIndex:[[eArgs objectForKey:@"atIndex"] intValue]];
	else
		[[[self windowController] document] addURLToPlaylist:newURL];
    
	[newURL release];
}

-(BOOL)playlistShowing
{
	return [[[self windowController] document] isPlaylistEmpty];
}

-(void)setPlaylistShowing:(BOOL)aBool
{
	if(aBool)
		[[[self windowController] document] openPlaylistDrawer:nil];
	else
		[[[self windowController] document] closePlaylistDrawer:nil];
}

-(void)handleTogglePlaylistDrawer:(id)sender
{
	[[[self windowController] document] togglePlaylistDrawer:sender];
}

-(void)handleCloseCommand:(NSCloseCommand *)command
{
	[self close];
}

@end
