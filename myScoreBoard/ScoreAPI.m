//
//  ScoreAPI.m
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "ScoreAPI.h"

@implementation ScoreAPI

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
    
    NSString* response = [xmlConnectionStub getSOAPResponse:completeString];
    
    
    
    // Response
    
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

-(NSString *)printVorname:(NSString *)vorname PlusNachname:(NSString *)nachname {
    return [[vorname stringByAppendingString:@" "] stringByAppendingString:nachname];
}

-(Match *) getMatchesForMatchday {
    
    NSString* meinName = [self printVorname:@"David" PlusNachname:@"Mohr"];
    
    return nil;
}

-(Match *) getMatchesForToday {
    return nil;
}



@end
