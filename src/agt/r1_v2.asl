/*
* CSCK504 Activity 3.2 Sample solution
* Author: Tom Carroll
* With Thanks to the Jason team: Adapted from Jason Mars Rover example code, available on GitHub https://jason-lang.github.io/ 
*/

/* Initial goal */

!check(slots). 

/* Plans */

//In the event that I need to check slots
//And there is NO garbage here
//Then I keep going
+!check(slots) : not garbage(r1)
   <- next(slot);
      !check(slots).


//In the event that I need to check slots
//And there IS garbage here
//And I am not at the end of the world...
//Then shout about it and then keep going
+!check(slots) : garbage(r1) & not pos(r1,6,6)
   <- .print("Garbage!");
   		next(slot);
      !check(slots).   


//In the event that I need to check slots
//And there IS garbage here
//And I AM at the end of the world...
//Then shout about it and stop	  
+!check(slots) : garbage(r1) & pos(r1,6,6)
   <- .print("Garbage! DONE!").   

//In the event that I need to check slots
//And there is NO garbage here
//And I am at the end of the world
//Then I stop
+!check(slots) : pos(r1,6,6)
   <- .print("Done!").
	  
	  
+!check(slots).
