:- include('KB2.pl').

s(loc(X,Y), c(C), r([]), s0):- %state-representation(agent_location, capacity, rescued_ships, state_name)
    agent_loc(X,Y),
    capacity(C).


s(loc(X,Y), c(C), r(R), result(right, S)):-
    s(loc(X,Y2), c(C), r(R), S),
    Y is Y2+1,
    grid(D1,D2),
    Y2 < D2-1.
s(loc(X,Y), c(C),  r(R), result(left, S)):-
    s(loc(X,Y2), c(C), r(R), S),
    Y is Y2-1,
    grid(D1,D2),
    Y2 > 0.
s(loc(X,Y), c(C),  r(R), result(up, S)):-
    s(loc(X2,Y), c(C), r(R), S),
    X is X2-1,
    grid(D1,D2),
    X2 > 0.
s(loc(X,Y), c(C),  r(R), result(down, S)):-
    s(loc(X2,Y), c(C), r(R), S),
    X is X2+1,
    grid(D1,D2),
    X2 < D1-1.
s(loc(X,Y), c(C), r(R), result(pickup, S)):-
    s(loc(X,Y), c(C2), r(R2), S),
    C2>0,
    C is C2-1,
    ships_loc(Ships),
    memberchk([X,Y], Ships),
    \+memberchk([X,Y], R2),
    append(R2, [[X,Y]], R). 
s(loc(X,Y), c(C), r(R), result(drop, S)):-
    s(loc(X,Y), c(C2), r(R), S),
    capacity(Original_Capacity),
    C2 \= Original_Capacity,
    C is Original_Capacity,
    station(X,Y).

goal(result(A, S)):-
    call_with_depth_limit(goal_helper(result(A, S)), 13, R).

goal_helper(result(A, S)):-
    A = drop,
    s(loc(X,Y), c(C), r(R), S),
    station(X,Y),
    ships_loc(Ships),
    length(R, Rescued_count),
    length(Ships, Ships_count),
    Rescued_count=Ships_count.

