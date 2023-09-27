# coastguard-logical-agent

## Project Overview

Welcome to the Coastguard Logical Agent Project! In this project, I have developed an intelligent agent using Prolog that simulates the actions of a Coast Guard agent. The agent utilizes the situation calculus to reason about its environment and make informed decisions. The primary goal of this project is to demonstrate my expertise in logic-based programming and knowledge representation.

## Project Implementation

### Knowledge Base Integration

To establish a solid foundation for the CoastGuard Logic Agent, I integrated a Prolog knowledge base stored in the `KB2.pl` file. This knowledge base provides essential information about the initial state of the environment, including details about the grid layout, the agent's starting location, ship locations, and capacity constraints.

```prolog
:- include('KB2.pl').
```

### State Representation

The heart of the project lies in state representation, which is crucial for decision-making and planning. The state representation is designed as follows:

```prolog
s(loc(X,Y), c(C), r([]), s0):- %state-representation(agent_location, capacity, rescued_ships, state_name)
    agent_loc(X,Y),
    capacity(C).
```
Here, s0 represents the initial state, capturing the agent's location, its capacity, and an empty list for rescued ships.

### Actions and Transitions

The CoastGuard Logic Agent is capable of various actions to navigate the environment and rescue passengers. I implemented these actions and transitions using Prolog rules. For instance:

```prolog
s(loc(X,Y), c(C), r(R), result(right, S)):-
    s(loc(X,Y2), c(C), r(R), S),
    Y is Y2+1,
    grid(D1,D2),
    Y2 < D2-1.
```

This rule defines the agent's movement to the right, updating its state accordingly. Similar rules exist for left, up, and down movements, as well as pickup and drop actions.

### Goal Query

To determine the success of the CoastGuard mission, I implemented a goal query that checks whether all ship passengers have been successfully rescued and dropped off at the station. Depth-limit search is applied to ensure completeness in finding a solution.

```prolog
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
```

## How to Run the Project

To run the CoastGuard Logic Agent project and explore its capabilities, follow these steps:

### Prerequisites

Ensure that you have the following prerequisites installed on your system:

- [SWI-Prolog](https://www.swi-prolog.org/Download.html) (Prolog interpreter)

### Clone the Repository

Clone this GitHub repository to your local machine using the following command (replace `<repository-url>` with the actual URL of your GitHub repository):

```bash
git clone https://github.com/Ziaad-Khaled/coastguard-logical-agent
```
### Navigate to the Project Directory

Change your working directory to the project folder:

```bash
cd coastguard-logic-agent
```

### Execute the Prolog Program

Run the Prolog program that contains the CoastGuard Logic Agent logic. In this case, it's assumed that the Prolog program is named CG.pl. You can run it using the SWI-Prolog interpreter:
```bash
swipl -s CG.pl
```

### Query the Agent

With the Prolog interpreter running, you can now interact with the CoastGuard Logic Agent. You can start by querying the agent for its goal as shown in the previous section's example:

```bash
goal(result(A, S)).
```

### Explore Different Scenarios

Feel free to modify the knowledge base (KB2.pl) to define different scenarios and initial conditions. You can experiment with various queries to test the agent's decision-making and planning capabilities.
