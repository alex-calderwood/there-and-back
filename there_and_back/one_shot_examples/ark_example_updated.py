from there_and_back.one_shot_examples.story_scaffold import StoryScaffold
from templates.ark_example import ark_example

# the updates needed to "fix" the broken ark-example in ark_example_broken.py

extra_actions = """
;; A character tells another the location of an item
(:action give-intel
  :parameters
    (?giver - character ?receiver - character ?item - item ?place - place)
  :precondition
    (and (not (= ?giver ?receiver))
    (alive ?giver)
    (knows-location ?giver ?item ?place)
    (alive ?receiver))
  :effect
    (and (knows-location ?reciever ?item ?place))
  :agents
    (?giver ?receiver))"""

extra_predicates = """"""

problem = """
(define (problem get-ark)
  (:domain indiana-jones-ark)
  (:objects
    indiana nazis army - character
    usa tanis - place
    gun - weapon)
  (:init
    (buried ark tanis)
    (alive indiana)
    (at indiana usa)
    (knows-location army ark tanis)
    (intends indiana (alive indiana))
    (intends indiana (has army ark))
    (alive army)
    (at army usa)
    (intends army (alive army))
    (intends army (has army ark))
    (alive nazis)
    (at nazis tanis)
    (intends nazis (alive nazis))
    (intends nazis (open ark))
    (has nazis gun))
  (:goal
    (and (at army usa)
    (has army ark)
    (not (alive nazis)))))
"""

solution = """
(define (plan get-ark-solution)
  (:problem get-ark)
  (:steps
    (start)
    (give-intel army indiana ark tanis)
    (excavate indiana ark tanis)
    (travel indiana tanis usa)
    (non-executed (give indiana ark army usa))
    (travel nazis tanis usa)
    (take nazis ark indiana usa)
    (open-ark nazis)
    (take army ark nazis usa)
    (end)))
"""

story = """
Once upon a time, Indiana Jones was on a mission to retrieve the Ark of the Covenant. A representative of the U.S. army arrived on his university campus, and placed in his hands a dossier containing the precise location of the powerful artifact in Tanis, Egypt. They were, according to them, desparate to get the powerful artifact back in their hands. Their spies had tipped them off to the exact location of the ark in Tanis. They were up against the Nazis who were also after the Ark.

Indiana and the army started their journey from the United States and traveled to Tanis. Indiana was able to excavate the priceless artifact. However, they were not alone. The Nazis had also arrived at the site and were waiting for the right moment to strike.

Indiana and the army quickly left Tanis and headed back to the United States with the Ark. He insisted on carrying the ark with him on the flight, and as he was about to hand it over, they were ambushed by the Nazis who had followed them back. The Nazis demanded that Indiana hand over the Ark, but he refused.

A fight broke out between the two groups, and the Nazis, using their weapons and wiles, managed to wrestle Indiana to the ground and wrangle the Ark from his hands. Immediately, they unlock the Ark and open it.

The power of the Ark was unleashed, and the Nazis were destroyed. The Army took possession of the Ark. The mission was a success, and the Ark was now in the hands of the good guys. Indiana and Army had saved the world from the evil intentions of the Nazis, and they were hailed as heroes.
"""

ark_example_updated = StoryScaffold(
  domain=ark_example.domain,
  extra_actions=extra_actions, 
  extra_predicates=extra_predicates, 
  problem=problem, 
  solution=solution, 
  story=story
)


