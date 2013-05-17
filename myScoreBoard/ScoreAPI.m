//
//  ScoreAPI.m
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "ScoreAPI.h"
#import "MatchGroup.h"
#import "TouchXML.h"
#import "XMLConnectionStub.h"

@implementation ScoreAPI

// ###########################
// API - Public Methods


// Nur zum Testen
-(id) init {
    self = [super init];
    if (self) {
        // Testaufruf
        [self getTeamsByLeagueSaison:@"2013" AndLeagueShortcut:@"BL1"];
    }
    return self;
}

- (MatchGroup*)getMatchesForToday {
    return nil;
}

- (MatchGroup*)getMatchesForMatchday {
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
    
    
    
    NSString* xmlResponse;
    
    XMLConnectionStub *xmlConnectionStub = [[XMLConnectionStub alloc] init];
    xmlResponse = [xmlConnectionStub getSOAPResponse:completeString AndNamespace:@"GetTeamsByLeagueSaison"];
    
    //NSLog(xmlResponse);
    
    // X-Path mit Namespace!!!
    NSArray *nodesTeamID = [self getNodesByXPath:@"//GetTeamsByLeagueSaison:teamID" AndXMLResponse:xmlResponse];
    NSArray *nodesTeamName = [self getNodesByXPath:@"//GetTeamsByLeagueSaison:teamName" AndXMLResponse:xmlResponse];
    NSArray *nodesTeamIconURL = [self getNodesByXPath:@"//GetTeamsByLeagueSaison:teamIconURL" AndXMLResponse:xmlResponse];
    
    NSMutableArray *teams = [[NSMutableArray alloc] initWithCapacity:[nodesTeamID count]];
    
    for (int i = 0; i <= [nodesTeamID count]; i++) {
        id team = [[Team alloc] init];
        [team setTeamId:(NSUInteger)[nodesTeamID objectAtIndex:i]];
        [team setName:[nodesTeamName objectAtIndex:i]];
        [team setTeamIconURL:[nodesTeamIconURL objectAtIndex:i]];
        [teams addObject:team];
    }
    
    return teams;
    
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

-(void) triggerUpdate {
    
}


@end