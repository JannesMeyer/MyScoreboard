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
#import "Goal.h"

@interface OpenLigaScoreAPI()

//@property (nonatomic) (void (^)(void)) updateAction;

@end

@implementation OpenLigaScoreAPI

// ###########################
// API - Public Methods

- (void) test {
    // Testaufruf
    MatchGroup *matchGroup = [self getMatchesForMatchday];
    
    for(Match *match in [matchGroup matches]) {
        NSLog(@"Match: %@ - %@", [[match team1] name], [[match team2] name]);
        for(Goal *goal in [match goals]) {
            NSLog(@"Tor von: %@", [[goal byTeam] name]);
        }
        NSLog(@"-------");
        //NSLog(@"MatchId: %d", [match matchId]);
    }
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
    
    
    // Stellt Verbindung her und ...
    XMLConnectionStub *xmlConnectionStub = [[XMLConnectionStub alloc] init];
    
    // ... startet SOAP-Request
    xmlResponse = [xmlConnectionStub getSOAPResponse:completeString AndNamespace:@"GetMatchdataByGroupLeagueSaison"];
    
    NSArray *nodes = [self getNodesByXPath:@"//GetMatchdataByGroupLeagueSaison:Matchdata" AndXMLResponse:xmlResponse];
    
    NSMutableArray *matches = [[NSMutableArray alloc] init];
    
    for (CXMLElement *node in nodes) {
        
        // XML-Extract of...
        // matchID
        NSString *matchID = [[[node elementsForName:@"matchID"] objectAtIndex:0] stringValue];
        Match *match = [[Match alloc] initWithId:[matchID intValue]];
        
        // team1
        NSUInteger team1ID = (NSUInteger) [[[node elementsForName:@"idTeam1"] objectAtIndex:0] stringValue];
        Team *team1 = [[Team alloc] initWithId:team1ID];
        [team1 setName:[[[node elementsForName:@"nameTeam1"] objectAtIndex:0] stringValue]];
        [team1 setTeamIconURL:[[[node elementsForName:@"iconUrlTeam1"] objectAtIndex:0] stringValue]];
        [match setTeam1:team1];
        
        // team2
        NSUInteger team2ID = (NSUInteger) [[[node elementsForName:@"idTeam2"] objectAtIndex:0] stringValue];
        Team *team2 = [[Team alloc] initWithId:team2ID];
        [team2 setName: [[[node elementsForName:@"nameTeam2"] objectAtIndex:0] stringValue]];
        [team2 setTeamIconURL: [[[node elementsForName:@"iconUrlTeam2"] objectAtIndex:0] stringValue]];
        [match setTeam2:team2];
        
        // startTime
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *startTime = [dateFormatter dateFromString:[[[node elementsForName:@"matchDateTime"] objectAtIndex:0] stringValue]];
        [match setStartTime:startTime];
        
        // goals/Goal
        NSArray *xmlGoals = [[[node elementsForName:@"goals"] objectAtIndex:0] elementsForName:@"Goal"];
        
        NSMutableArray *goals = [[NSMutableArray alloc] init];
        
        int goalNumber = 0;        
        
        for (CXMLElement *xmlGoal in xmlGoals) {
            Goal *goal = [[Goal alloc] init];
            
            int time = [[[[xmlGoal elementsForName:@"goalMatchMinute"] objectAtIndex:0 ] stringValue] intValue];
            
            [goal setTime: time];
            
            if(time <= 45) {
                [goal setHalftime:1];
            } else {
                [goal setHalftime:2];
            }
            
            [goal setByPlayer:[[[xmlGoal elementsForName:@"goalGetterName"] objectAtIndex:0] stringValue]];
            
            [goal setByTeam:[self getTeamBy:xmlGoals AndNumber:goalNumber AndTeam1:team1 AndTeam2:team2]];
            
            goalNumber++;
            
            [goals addObject:goal];
        }
        [match setGoals:goals];
        
//        // ScoreTeam1
//        NSString *pointsTeam1 = [[[node elementsForName:@"pointsTeam1"] objectAtIndex:0] stringValue];
//        [match setTeam1Score:(NSUInteger) pointsTeam1];
//        
//        // ScoreTeam2
//        NSString *pointsTeam2 = [[[node elementsForName:@"pointsTeam2"] objectAtIndex:0] stringValue];
//        [match setTeam2Score:(NSUInteger) pointsTeam2];
        
        // StadiumName
        NSString *stadiumName = [[[[[node elementsForName:@"location"] objectAtIndex:0 ] elementsForName:@"locationStadium"] objectAtIndex:0] stringValue];
        [match setStadiumName:stadiumName];
        
        // LocationCity
        NSString *locationCity = [[[[[node elementsForName:@"location"] objectAtIndex:0 ] elementsForName:@"locationCity"] objectAtIndex:0] stringValue];
        [match setLocationName:locationCity];
        
        // Adding to MatchArray
        [matches addObject:match];
    }
    
    MatchGroup *matchGroup = [[MatchGroup alloc] initWithMatches:matches];
    
//    matchGroup.name = [[[[nodes lastObject] elementsForName:@"groupName"] objectAtIndex:0] stringValue];
    matchGroup.name = [[[nodes lastObject] elementsForName:@"leagueName"][0] stringValue];
    
    return matchGroup;

}


// ###########################
// API - Internal Methods

/**
 * Gibt anhand der Änderung des Spielstands das Team zurück, welches das Tor geschossen hat. Vorbedingung: mit 'goalNumber' geht die laufende
 * Nummer des Treffers ein. Works fine ;-) 28.05.2013, dmohr
 */
- (Team *) getTeamBy: (NSArray*) xmlGoals AndNumber: (int) goalNumber AndTeam1: (Team*) team1 AndTeam2: (Team*) team2 {
    
    NSString* scoreTeam1 = [[[[xmlGoals objectAtIndex:goalNumber] elementsForName:@"goalScoreTeam1"] objectAtIndex:0] stringValue];
    Boolean ownGoal = [[[[[xmlGoals objectAtIndex:0] elementsForName:@"goalOwnGoal"] objectAtIndex:0] stringValue] boolValue];
    
    if(goalNumber == 0) {
        // Wenn Team1 das erste Tor geschossen hat und es kein Eigentor ist, dann hat Team 1 das Tor geschossen
        if([scoreTeam1 isEqualToString:@"1"] && !ownGoal) {
            return team1;
        // Ansonsten Team2
        } else {
            return team2;
        }
    } else {
        NSString* scoreTeam1Minus1 = [[[[xmlGoals objectAtIndex:goalNumber-1] elementsForName:@"goalScoreTeam1"] objectAtIndex:0] stringValue];
        // Wenn Team1 einen anderen Torstand hat als ein Goal-Element vorher und dieses kein Eigentor war, dann hat Team 1 das Tor geschossen
        //NSLog(@"ScoreTeam1: %@ :: ScoreTeam1Min1: %@", scoreTeam1, scoreTeam1Minus1);
        if(![scoreTeam1 isEqualToString: scoreTeam1Minus1] && !ownGoal) {
            return team1;
        // Ansonsten Team2
        } else {
            return team2;
        }
    }
    return nil;
}

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
        NSUInteger teamId = (NSUInteger) [[[node elementsForName:@"teamID"] objectAtIndex:0] stringValue];
        id team = [[Team alloc] initWithId:teamId];
        
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






#pragma mark - Update

- (void)setUpdateAction:(void (^)(void)) action {
    
}

- (void)triggerUpdate {
    
}

@end