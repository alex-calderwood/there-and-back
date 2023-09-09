from there_and_back.one_shot_examples.story_scaffold import StoryScaffold
from .ark_example_decompose import story, solution

# An edited version of ark-example that does not parse (for auto-debugging)

domain = """
(define (domain indiana-jones-ark)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object weapon - item)
  (:constants ark - item)
  (:predicates
    (open ark)
    (alive ?character - character)
    (buried ?item - item ?place - place)
    (knows-location ?character - character ?item - item ?place - place)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (safe ?character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character excavates an item.
  (:action excavate
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (buried ?item ?place)
      (knows-location ?character ?item ?place))
    :effect
      (and (not (buried ?item ?place))
      (has ?character ?item))
    :agents  (?character)
  )

  ;; One character gives an item to another.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character ?place - place)
    :precondition
      (and (not (= ?giver ?receiver))
      (alive ?giver)
      (at ?giver ?place)
      (has ?giver ?item)
      (alive ?receiver)
      (at ?receiver ?place))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; One character kills another.
  (:action kill
    :parameters
      (?killer - character ?weapon - weapon ?victim - character ?place - place)
    :precondition
      (and (alive ?killer)
      (at ?killer ?place)
      (has ?killer ?weapon)
      (alive ?victim)
      (at ?victim ?place))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; One character takes an item from another at weapon-point.
  (:action take
    :parameters
      (?taker - character ?item - item ?victim - character ?place - place)
    :precondition
      (and (not (= ?taker ?victim))
      (alive ?taker)
      (at ?taker ?place)
      (or (not (alive ?victim))
      (and (armed ?taker)
      (not (armed ?victim))))
      (at ?victim ?place)
      (has ?victim ?item))
    :effect
      (and (not (has ?victim ?item))
      (has ?taker ?item))
    :agents
      (?taker)
  )

  ;; A character opens the Ark.
  (:action open-ark
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (has ?character ark))
    :effect
      (and (open ark)
      (not (alive ?character)))
    :agents
      (?character)
  )

  ;; The Ark closes.
  (:action close-ark
    :precondition
      (open ark)
    :effect
      (not (open ark))
  )

  ;; When a character has a weapon, they are armed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (not (armed ?character))
      (exists (?w - weapon)
      (has ?character ?w)))
    :implies
      (armed ?character)
  )

  ;; When a character does not have a weapon, they are unarmed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (armed ?character)
      (forall (?w - weapon)
      (not (has ?character ?w))))
    :implies
      (not (armed ?character))
  )
"""

problem = """
(define (problem get-ark)
  (:domain
    indiana-jones-ark)
  (:objects
    indiana nazis army - character
    ark - item
    usa tanis - place
    gun - weapon)
  (:init
    (buried ark tanis)
    (alive indiana)
    (at indiana usa)
    (knows-location indiana ark tanis)
    (alive army)
    (at army usa)
    (alive nazis)
    (at nazis tanis)
    (has nazis gun))
  (:goal
    (and (at army usa)
    (has army ark)
    (not (alive nazis)))
  )
)
"""

error="""
Reading domain............
java.lang.RuntimeException: com.stephengware.java.planware.io.ParseException: Expected end of list, but encountered end of document (at line 142).

With extra parenthesis:
The Glaive Narrative Planner, by Stephen G. Ware
Reading domain............
java.lang.RuntimeException: com.stephengware.java.planware.io.ParseException: The document "(armed ?taker)" could not be parsed as Expression (at line 86).
"""

ark_example_broken = StoryScaffold(
  domain=domain, problem=problem, solution=solution,
  story=story, error=error,
)

