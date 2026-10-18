/*
* CSCK504 Activity 3.3 Sample solution
* Author: Tom Carroll
* With Thanks to the Jason team: Adapted from Jason Mars Rover example code, available on GitHub https://jason-lang.github.io/ 
*/

/* Initial goal */

!check(slots). 

/* Plans */

//In the event that I need to check slots
//And there is NO garbage here
//Then I keep going
+!check(slots) : not garbage(r1) & not pos(r1,6,6)
   <- next(slot);
      !check(slots).

//In the event that I need to check slots
//And there IS garbage here
//Then shout about it and try to pick it up
+!check(slots) : garbage(r1)
   <- .print("Garbage!");
   	!ensurePick(garb).   


//In the event that I need to check slots
//And I am at the end of the world
//Then I stop
+!check(slots) : pos(r1,6,6)
   <- .print("Done!").


	  
+!check(slots).


//Ensure that I pick up garbage
+!ensurePick(garb) : garbage(r1)
   <- pick(garb);
   !ensurePick(garb);
   !check(slots).

+!ensurePick(garb).