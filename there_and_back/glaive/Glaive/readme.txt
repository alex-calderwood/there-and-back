===============================================================================
                         The Glaive Narrative Planner
                              By Stephen G. Ware
===============================================================================

                                 Version  1.1
                                March 16, 2016

-------------------------------------------------------------------------------
 About
-------------------------------------------------------------------------------

Glaive is a forward-chaining state-space narrative planner.  This means that it
is a classical planner in the family of HSP which also reasons about the
actions of intentional agents who may cooperate and compete.

It takes as input a domain and problem file, both written in the syntax of the
Planning Domain Definition Language (or PDDL).  The domain specifies the types
of objects that exist and the types of actions that can be taken.  Each action
specifies the preconditions that must be true before it can be executed, the
effects that become true after it is executed, and optionally a list of agents
who must intend to execute the action.  The problem specifies all the objects
in the story world, the initial state of the world, and the author's goal for
the story world.

As a state space planner, Glaive first creates a list of every possible step
which can occur in the world.  This is potentially a very large list, so Glaive
has some built-in features for reading and writing state spaces to file and for
automatically simplifying state spaces.

A valid plan is one which achieves the author's goal and which, for every step
that must be intended by agents, that step is directed toward some goal for
each agent.  Glaive supports partially-executed agent plans.  This means that
not every plan that an agent forms for a goal will succeed.  As long as there
exists some possible world in which that agent's plan could succeed, any subset
of that plan may appear in a solution.

-------------------------------------------------------------------------------
 Contents
-------------------------------------------------------------------------------

The planner can be found in this directory as 'glaive.jar'.

The complete Java 7 source is packaged as an Eclipse project in this directory
as 'source.zip'.

Also included in this directory is a set of test files in 'tests' and a batch
file for running all tests.

-------------------------------------------------------------------------------
 Features
-------------------------------------------------------------------------------

Glaive supports the following standard PDDL planning features:
  :strips                       STRIPS-style actions
  :negative-preconditions       Negated preconditions and goals
  :typing                       Hierarchical typed constants
  :equality                     Equality and inequality predicates
  :disjunctive-preconditions    'or' preconditions and goals
  :existential-preconditions    'exists' preconditions and goals
  :universal-preconditions      'forall' preconditions and goals
  :quantified-preconditions     :existential-preconditions and
                                  :universal-preconditions
  :universal-effects            'forall' effects
  :conditional-effects          'when' effects
  :adl                          :strips, :negative-preconditions, :typing
                                  :equality, :quantified-preconditions,
                                  :universal-effects, and :conditional-effects
  :domain-axioms                Automatic changes to the state

It also supports a some non-standard features:
  :expression-variables         Variables my be type 'expression,' meaning they
                                  can be bound to any logical expression, or of
                                  type 'imposable' meaning they can be bound to
                                  any expression which is a valid effect.
  :intentionality               Operators can declare a list of :agents, each
                                  of whom must intend that action.
  :delegation                   Provides the 'delegated' modality and an axiom
                                  for performing goal delegation.  See Aladdin
                                  domain for an example.
  
-------------------------------------------------------------------------------
 Usage
-------------------------------------------------------------------------------

To run Glaive from the command line, use the following syntax:
  java -jar glaive.jar -d <domain file> -p <problem file> [-options]

There are a number of command line options that can also be given:
  -help              Prints usage information.
  -pp <plan file>    Read a partial plan which must appear in the solution.
  -s                 Simplify the state space befor planning.
  -ws <output file>  Write the state space to a file and halt.
  -rs <space file>   Read the state space from a file.
  -b                 Debug mode: prints verbose description of each node visited.
  -tl <time>         Max number of milliseconds before aborting the search.
  -nl <nodes>        Max number of nodes to search before aborting.
  -n <number>        Return the nth solution found (default is 1).
  -v                 Prints a verbose explanation of every intentional chain.
  -cpocl             Output the solution as a Conflict Partial Order Causal Link plan.
  -o <output file>   Outputs the resulting plan to a file.

-------------------------------------------------------------------------------
 Example
-------------------------------------------------------------------------------

Several example planning domains, problems, and state spaces are included in
the 'tests' directory.  'ark' represent a highly simplified version of the plot
of "Indiana Jones and the Raiders of the Lost Ark."  This example domain
demonstrates the use of intentional actions, non-executed steps, domain axioms,
and some of Glaive's other features.

Use the following command to load the domain and problem, simplify the state
space, and write that state space out to file for future use:
  java -jar glaive.jar -d tests/ark-domain.pddl -p tests/ark-problem.pddl -s -ws tests/ark-space.pddl

Use the following command to load the domain, problem, and state space and then
find a valid plan.  The search must take no more than 1 second and search no
more than 100 nodes.  The resulting plan will be written to a file.
  java -jar glaive.jar -d tests/ark-domain.pddl -p tests/ark-problem.pddl -rs tests/ark-space.pddl -tl 1000 -nl 100 -o tests/ark-solution.pddl

The output file should contain the following solution:

(define (plan get-ark-solution)
  (:problem get-ark)
  (:steps (travel indiana usa tanis)
          (excavate indiana ark tanis)
          (travel indiana tanis usa)
          (non-executed (give indiana ark army usa))
          (travel nazis tanis usa)
          (take nazis ark indiana usa)
          (open-ark nazis)
          (take army ark nazis usa)))

A batch file for running all the example test problems is also provided in this
directory.
		  
-------------------------------------------------------------------------------
 Known Issues
-------------------------------------------------------------------------------

Some requirements interfere with one another in ways that Glaive cannot detect.
For example, when using both the :domain-axioms and :intentionality
features, :domain-axioms must be listed first or the axioms will not be parsed.
This is an unfortunate consequence of the way Glaive's extensible IO system
is designed.  As a general rule, requirements should be listed in the order
they appear in the "Features" section above.

-------------------------------------------------------------------------------
 Version History
-------------------------------------------------------------------------------
Version 1.1: Fixed a bug where actions with 0 parameters get ignored.
Version 1.0: First release.