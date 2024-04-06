# Qui-Gon_LP
 
Qui-Gon is on Tatooine and needs to organize a tournament of podraces to fix the Royal Starship. He is hoping that young Anakin will win the tournament.
The podrace tournament involves n competitors (where n is even) who all race against each other over the course of n-1 day. Each competitor races once a day and each competitor must race against every other competitor over the course of a tournament. For each race, the two competitors have starting positions (called tracks). The left track (named 0) is a better starting position than the right track (named 1). As a result, each competitor cannot start too many consecutive times on the left track (and vice versa for the right track) to ensure as much fairness as possible. The number of successive times a competitor can start on a specific track is given by the constant maxSucc (e.g., maxSucc = 2)
Can you help Qui-Gon solve this problem for 20 competitors in less than 1 minute (terminating on its own)?
Here are the declarations

int nbCompetitors = ..;
int nbDays = nbCompetitors-1;
range Days = 1..nbDays;
range Competitors = 1..nbCompetitors;
range Tracks = 0..1;
int maxSucc = ..;
The solution array is of the form
int opp[Competitors,Days];  // opp[c,d] is the opponent of c on day d
int track[Competitors,Days]; // track[c,d] is the track of c on day d
