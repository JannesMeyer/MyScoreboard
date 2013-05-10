//
//  ScoreAPI.m
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "ScoreAPI.h"
#import "TouchXML.h"

@implementation ScoreAPI

// ###########################
// API - Public Methods


-(Match *) getMatchesForMatchday {
    
    NSString* meinName = [self printVorname:@"David" PlusNachname:@"Mohr"];
    
    return nil;
}


-(Match *) getMatchesForToday {
    return nil;
}



// ###########################
// API - Internal Methods


-(NSArray *) getTeamsByLeagueSaison: (NSString*) leagueSaison AndLeagueShortcut:(NSString *)leagueShortcut {
    
    // Anfangsgeplaenkel
    NSString* completeString = @"<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><SOAP-ENV:Body><m:GetTeamsByLeagueSaison xmlns:m=\"http://msiggi.de/Sportsdata/Webservices\">";
    
    // XML-Parameterliste
    
    // 1. Parameter
    completeString = [completeString stringByAppendingString: @"<m:leagueShortcut>"];
    completeString = [completeString stringByAppendingString: leagueShortcut];
    completeString = [completeString stringByAppendingString: @"</m:leagueShortcut>"];
    // 2. Parameter
    completeString = [completeString stringByAppendingString: @"<m:leagueSaison>"];
    completeString = [completeString stringByAppendingString: leagueSaison];
    completeString = [completeString stringByAppendingString: @"</m:leagueSaison>"];
    
    // Endgeplaenkel
    completeString = [completeString stringByAppendingString: @"</m:GetTeamsByLeagueSaison></SOAP-ENV:Body></SOAP-ENV:Envelope>"];
    
    NSString* xmlresponse = [xmlConnectionStub getSOAPResponse:completeString];
    
    // X-Path mit Namespace!!!
    NSArray *nodes = [self getNodesByXPath:xPath XMLResponse:xmlresponse];
    
    for (CXMLElement *node in nodes){
        
        NSString *goalName = [[[node elementsForName:@"goalGetterName"]objectAtIndex:0] stringValue];
        NSString *goalMatchMinute = [[[node elementsForName:@"goalMatchMinute"]objectAtIndex:0] stringValue];
        NSLog(@"node = %@: %@", goalMatchMinute, goalName);
        
    }
    
}


-(void) initialize {
    
}

-(id)init {
    self = [super init];
    if(self) {
        [self initialize];
    }
    return self;
}


// Syntaxvorlage / Uebung
-(NSString *)printVorname:(NSString *)vorname PlusNachname:(NSString *)nachname {
    return [[vorname stringByAppendingString:@" "] stringByAppendingString:nachname];
}



-(NSArray *) getNodesByXPath:(NSString*) xpath AndXMLResponse:(NSString*) xmlResponse {
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithXMLString:xmlResponse options:0 error:nil];
    
    // Extrahieren des Namespace aus dem XPath
    NSString *namespace = [[[xpath componentsSeparatedByString:@":"] objectAtIndex:1] stringByReplacingOccurrencesOfString:@"//" withString: @""];
    
    // Holen des Blattknotens mit dem Namen //namespace:knot
    NSArray *nodes = [doc nodesForXPath:xpath namespaceMappings:[NSDictionary dictionaryWithObject:@"http://msiggi.de/Sportsdata/Webservices" forKey:namespace] error:nil];
    
    // Zu Testzwecken
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"XML" message:matchId delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alert show];
    
    return nodes;
}



@end
