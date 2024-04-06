// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2022. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

using CP;

/* ------------------------------------------------------------

Problem Description
-------------------

Qui-Gon is on Tatooine and needs to organize a tournament of podraces to fix the Royal Starship. 
He is hoping that young Anakin will win the tournament.
The podrace tournament involves n competitors (where n is even) who all race against each other 
over the course of n-1 day. 
Each competitor races once a day and each competitor must race against every other competitor 
over the course of a tournament. 
For each race, the two competitors have starting positions (called tracks). 
The left track (named 0) is a better starting position than the right track (named 1). 
As a result, each competitor cannot start too many consecutive times on the left track 
(and vice versa for the right track) to ensure as much fairness as possible.
------------------------------------------------------------ */

// Declarations
int nbCompetitors = 20;
int nbDays = nbCompetitors-1;
range Days = 1..nbDays;
range Competitors = 1..nbCompetitors;
range Tracks = 0..1;
int maxSucc = 2;

dvar int opp[Competitors][Days] in Competitors;  // opp[c][d] is the opponent of c on day d
dvar int track[Competitors][Days] in Tracks; // track[c][d] is the track of c on day d

execute {
    cp.param.timeLimit=60;
    cp.param.logPeriod=10000;
    cp.param.DefaultInferenceLevel="Extended";
}

// actually the object function is not needed
//dexpr int object = sum(c in Competitors) 1;
//
//minimize object;

subject to {
  	// Each competitor cannot game with himself
	forall (c in Competitors) {
	  forall (d in Days) {
	     opp[c][d] != c;
	  }
	}
  
  	// Each competitor game with only one competitor
	forall (c in Competitors) {
	  forall (d in Days) {
	     opp[opp[c][d]][d] == c;
	     track[c][d] + track[opp[c][d]][d] == 1;
	  }
	}

	// Each competitor must race against every other competitor over the course of a tournament.
	forall (c in Competitors) {
	  forall (d1 in 1..nbDays-1) {
	    forall (d2 in d1+1..nbDays){
	      opp[c][d1] != opp[c][d2];
	    }
	  }
	}
    
    // each competitor cannot start too many consecutive times on the left track	
	// (and vice versa for the right track)
	forall (c in Competitors) {
	  forall (d1 in 1..nbDays-maxSucc) {
	      sum(d2 in d1..d1+maxSucc) track[c][d2] > 0;
	      sum(d2 in d1..d1+maxSucc) track[c][d2] < maxSucc+1;
	  }
	}
}

execute {
	writeln("Game schedules");
	for (d in Days) {
		writeln("Day " + d);	  
	  	for (c in Competitors) {
	  	  	writeln("Competitor " + c + " in Track " + track[c][d] + " vs " + opp[c][d]);
	  	}
	}
	
}
