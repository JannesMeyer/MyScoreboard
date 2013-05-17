//
//  XMLConnectionStub.m
//  myScoreBoard
//
//  Created by stud on 17.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "XMLConnectionStub.h"

@implementation XMLConnectionStub

- (void) requestSOAPResponse:(NSString *)completeString AndNamespace:(NSString *) namespace {
    
    NSURL *url = [NSURL URLWithString:@"http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [completeString length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: [@"http://msiggi.de/Sportsdata/Webservices/" stringByAppendingString:namespace] forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [completeString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [[self webData] setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self webData] appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConnection");
    //[connection release];
    //[webData release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %d", [[self webData] length]);
    _xmlResponse = [[NSString alloc] initWithBytes: [[self webData] mutableBytes] length:[[self webData] length] encoding:NSUTF8StringEncoding];
    
    NSLog(_xmlResponse);
    
    //NSLog(@"%@",theXML);
    
    //[theXML release];
}

-(NSString *) getSOAPResponse:(NSString *)completeString AndNamespace:(NSString *)nameSpace {
    [self requestSOAPResponse:completeString AndNamespace:nameSpace];
    
    return _xmlResponse;
}

@end
