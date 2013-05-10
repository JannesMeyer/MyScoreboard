//
//  ScoreAPI.m
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "ScoreAPI.h"
#import "TouchXML.h"

@interface ScoreAPI()
@property (strong, nonatomic) NSMutableData* webData;
@end

@implementation ScoreAPI

-(id) init {
    self = [super init];
    if (self) {
        // Do initialization
        NSString *soapString = @"<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"> <SOAP-ENV:Body> <m:GetLastMatch xmlns:m=\"http://msiggi.de/Sportsdata/Webservices\"> <m:leagueShortcut>BL1</m:leagueShortcut> </m:GetLastMatch> </SOAP-ENV:Body> </SOAP-ENV:Envelope>";
        
        NSURL *url = [NSURL URLWithString:@"http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapString length]];
        
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://msiggi.de/Sportsdata/Webservices/GetLastMatch" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        if( theConnection )
        {
            self.webData = [NSMutableData data];
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConnection");
    //[connection release];
    //[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %d", [self.webData length]);
    NSString *theXML = [[NSString alloc] initWithBytes: [self.webData mutableBytes] length:[self.webData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",theXML);
    [self parseXMLString:theXML];
    //[theXML release];
}

- (void)parseXMLString:(NSString *)xmlString {
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    NSLog(@"CXMLDoc=%@",[doc rootElement]);
    
    NSArray *nodes;
    
    // Returns 'matchId'
    nodes = [doc nodesForXPath:@"//GetLastMatchResponse:Goal" namespaceMappings:[NSDictionary dictionaryWithObject:@"http://msiggi.de/Sportsdata/Webservices" forKey:@"GetLastMatchResponse"] error:nil];
    
    
    for (CXMLElement *node in nodes){
        
        NSString *goalName = [[[node elementsForName:@"goalGetterName"]objectAtIndex:0] stringValue];
        NSString *goalMatchMinute = [[[node elementsForName:@"goalMatchMinute"]objectAtIndex:0] stringValue];
        NSLog(@"node = %@: %@", goalMatchMinute, goalName);
        
    }
    
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"XML" message:matchId delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alert show];
    
    
}

-(Match*) getMatchesForMatchday {
    return nil;
}

-(Match*) getMatchesForToday {
    return nil;
}

-(void) setUpdateAction {
    
}

-(void) triggerUodate {
    
}


@end
