at(P) :- pos(P,X,Y) & pos(r1,X,Y). //Agent R1 is at the same location as Agent P if the X,Y vals of the location percepts are the same

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
   	!take(garb, r2).


//In the event that I need to check slots
//And I am at the end of the world
//Then I stop
+!check(slots) : pos(r1,6,6)
   <- .print("Done!").

//If none of the above apply, then do nothing	  
+!check(slots).

//Take something "G" to an agent "L"
+!take(G,L) : true
   <- .print("Taking", G, " to ", L);
   ?pos(r1,X,Y); //Save current location
   .print("R1 curr loc is ", X, ",", Y);
   !ensurePick(G); //Pick up G
   !at(L); //Move agent R1 to Agent L
   drop(G); //Drop G at Agent L
   !goTo(X,Y); //Move agent R1 to their previous location
   !check(slots). //Carry on checking slots of environment
   

//Ensure that I pick up garbage
+!ensurePick(garb) : garbage(r1)
   <- pick(garb); //If there is garbage where I am stood, then try to pick it up
   !ensurePick(garb).

+!ensurePick(_). //If there is no garbage where I am stood, then do nothing

//Move agent R1 to the location of Agent L
//If I am NOT at the same location as Agent L, then I need to move
+!at(L): not at(L) 
   <- ?pos(L,X,Y); //Query the location of Agent L
   !goTo(X,Y). //Move Agent R1 to the known location of Agent L

+!at(L): at(L). //If I am already at the location of Agent L, then do nothing

//Make Agent R1 go to a known location X,Y
//If agent R1 is NOT currently at location X, Y then I need to move
+!goTo(X,Y): not pos(r1,X,Y)  
   <- .print("Moving Towards ", X, ",", Y); 
   moveTowards(X,Y); //Move one step towards X,Y
   !goTo(X,Y). //And check again if I still need to move

//If the above is not applicable, then Agent R1 is already at X,Y
//So do nothing
+!goTo(X,Y): true.
