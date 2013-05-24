//
//  ScoreAPI.m
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "OpenLigaScoreAPI.h"
#import "MatchGroup.h"
#import "TouchXML.h"
#import "XMLConnectionStub.h"

@implementation OpenLigaScoreAPI

// ###########################
// API - Public Methods


// Nur zum Testen
-(id) init {
    self = [super init];
    if (self) {
        // Testaufruf
        //NSArray *teams = [self getTeamsByLeagueSaison:@"2013" AndLeagueShortcut:@"BL1"];
        NSString *currGroupOrderID = [self getCurrentGroupOrderID: @"BL1"];
        NSLog(@"GroupOrderId : %@", currGroupOrderID);
        
//        for (Team *team in teams) {
//            NSLog(@"TeamID : %@",[team teamId]);
//            NSLog(@"TeamName : %@", [team name]);
//            NSLog(@"TeamIconURL : %@", [team teamIconURL]);
//            
//        }
        
    }
    return self;
}

- (MatchGroup*)getMatchesForToday {
    return nil;
}

- (MatchGroup*)getMatchesForMatchday {
    // default: Current matchday
    
    NSString *ligaShortcut = @"BL1";
    NSString *leagueSaison = @"2012";
    NSString *currentGroupOrderID = [self getCurrentGroupOrderID:ligaShortcut];
    
    NSString *completeString = @"<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><SOAP-ENV:Body><m:GetMatchdataByGroupLeagueSaison xmlns:m=\"http://msiggi.de/Sportsdata/Webservices\">";
    
    // XML-Parameterliste
    // 1. Parameter
    completeString = [completeString stringByAppendingString:@"<m:groupOrderID>"];
    completeString = [completeString stringByAppendingString:currentGroupOrderID];
    completeString = [completeString stringByAppendingString:@"</m:groupOrderID>"];
    
    // 2. Parameter
    completeString = [completeString stringByAppendingString:@"<m:leagueShortcut>"];
    completeString = [completeString stringByAppendingString:ligaShortcut];
    completeString = [completeString stringByAppendingString:@"</m:leagueShortcut>"];
    
    // 3. Parameter
    completeString = [completeString stringByAppendingString:@"<m:leagueSaison>"];
    completeString = [completeString stringByAppendingString:leagueSaison];
    completeString = [completeString stringByAppendingString:@"</m:leagueSaison>"];
    
    // Endgeplaenkel
    completeString = [completeString stringByAppendingString: @"</m:GetMatchdataByGroupLeagueSaison></SOAP-ENV:Body></SOAP-ENV:Envelope>"];
    
    NSString *xmlResponse;
    
    XMLConnectionStub *xmlConnectionStub = [[XMLConnectionStub alloc] init];
    
    xmlResponse = [xmlConnectionStub getSOAPResponse:completeString AndNamespace:@"GetMatchdataByGroupLeagueSaison"];
    
    NSArray *nodes = [self getNodesByXPath:@"//GetMatchdataByGroupLeagueSaison:Matchdata" AndXMLResponse:xmlResponse];
    
    MatchGroup *matchGroup = [[MatchGroup alloc] init];
    
    for (CXMLElement *node in nodes) {
        
        Match *match = [[Match alloc] init];
        
        NSString *matchID = [[node elementsForName:@"matchID"] objectAtIndex:0];
        
        Team *team1 = [[Team alloc] init];
        [team1 setTeamId: (NSUInteger) [[node elementsForName:@"idTeam1"] objectAtIndex:0]];
        [team1 setName:[[node elementsForName:@"nameTeam1"] objectAtIndex:0]];
        [team1 setTeamIconURL:[[node elementsForName:@"iconUrlTeam1"] objectAtIndex:0]];
        
        Team *team2 = [[Team alloc]init];
        [team2 setTeamId: (NSUInteger) [[node elementsForName:@"idTeam2"] objectAtIndex:0]];
        [team2 setName: [[node elementsForName:@"nameTeam2"] objectAtIndex:0]];
        [team2 setTeamIconURL: [[node elementsForName:@"iconUrlTeam2"] objectAtIndex:0]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *startTime = [dateFormatter dateFromString:[[node elementsForName:@"matchDateTime"] objectAtIndex:0]];
        
        
        
    }
    
    
    
    return nil;
}


// ###########################
// API - Internal Methods

/**
 * Holt den aktuellen Spieltag der als Parameter einzugebenden Liga
 */
- (NSString *) getCurrentGroupOrderID: (NSString*) leagueShortcut {
    
    NSString* completeString = @"<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><SOAP-ENV:Body><m:GetCurrentGroupOrderID xmlns:m=\"http://msiggi.de/Sportsdata/Webservices\">";
    
    // XML-Parameterliste
    
    // 1. Parameter
    completeString = [completeString stringByAppendingString: @"<m:leagueShortcut>"];
    completeString = [completeString stringByAppendingString: leagueShortcut];
    completeString = [completeString stringByAppendingString: @"</m:leagueShortcut>"];
    
    // Endgeplaenkel
    completeString = [completeString stringByAppendingString: @"</m:GetCurrentGroupOrderID></SOAP-ENV:Body></SOAP-ENV:Envelope>"];
    
    NSString *xmlResponse;
    
    
    XMLConnectionStub *xmlConnectionStub = [[XMLConnectionStub alloc] init];
    xmlResponse = [xmlConnectionStub getSOAPResponse:completeString AndNamespace:@"GetCurrentGroupOrderID"];
    
    NSArray *nodes = [self getNodesByXPath:@"//GetCurrentGroupOrderID:GetCurrentGroupOrderIDResult" AndXMLResponse:xmlResponse];
    
    NSString *currentGroupOrderID = [[nodes objectAtIndex:0] stringValue];
    
    
    return currentGroupOrderID;
    
}


/**
 Works fine ;-) 24.05.2013
 */
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
    
    // Verbindung zum Stub, gibt XML-Antwort zum SOAP Request
    XMLConnectionStub *xmlConnectionStub = [[XMLConnectionStub alloc] init];
    xmlResponse = [xmlConnectionStub getSOAPResponse:completeString AndNamespace:@"GetTeamsByLeagueSaison"];
    
    // Knoten des Path <Team> holen
    NSArray *nodes = [self getNodesByXPath:@"//GetTeamsByLeagueSaison:Team" AndXMLResponse:xmlResponse];
    
    // Array aus Team-Objekten zum fuellen initialisieren
    NSMutableArray *teams = [[NSMutableArray alloc] initWithCapacity:[nodes count]];
    
    for (CXMLElement *node in nodes) {
        id team = [[Team alloc] init];
        
        // TeamId hinzufügen
        NSString *teamId = [[[node elementsForName:@"teamID"] objectAtIndex:0] stringValue];
        [team setTeamId:(NSUInteger) teamId];
        
        // TeamNamen hinzufügen
        NSString *teamName = [[[node elementsForName:@"teamName"] objectAtIndex:0] stringValue];
        [team setName:teamName];
        
        // TeamIconURL hinzufügen
        NSString *teamIconURL = [[[node elementsForName:@"teamIconURL"] objectAtIndex:0] stringValue];
        [team setTeamIconURL:teamIconURL];
        
        // TeamObject in Liste packen
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
    NSString *namespace = [[[xpath componentsSeparatedByString:@":"] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"//" withString: @""];
    
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