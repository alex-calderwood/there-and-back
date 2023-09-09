from there_and_back.one_shot_examples.story_scaffold import StoryScaffold

domain = """
(define (domain fantasy)
  (:requirements :adl :intentionality)
  (:types ; Person and monster are a types of creature.
    person monster - creature
    ; Items exist.
    valuable - item
    ; Places exist.
    place)
  (:predicates
    ; A creature is alive.
    (alive ?creature - creature)
    ; A person is single.
    (single ?person - person)
    ; A creature is rich.
    (rich ?creature - creature)
    ; A creature is happy.
    (happy ?creature - creature)
    ; A creature is hungry.
    (hungry ?creature - creature)
    ; An object is at a place.
    (at ?object - object ?place - place)
    ; A creature has an item.
    (has ?creature - creature ?item - item)
    ; An item belongs to a creature
    (belongsto ?item - item ?creature - creature)
    ; One creature loves another.
    (loves ?lover - creature ?love - creature)
    ; One person has proposed to another.
    (hasproposed ?proposer - person ?proposee - person)
    ; One person has accepted another's proposal.
    (hasaccepted ?person1 - person ?person2 - person)
    ; Two people are married.
    (marriedto ?person1 - person ?person2 - person)
  )

;; A creature travels from one place to another.
(:action travel
  :parameters
    (?creature - creature ?from - place ?to - place)
  :precondition
    (and (alive ?creature)
    (at ?creature ?from))
  :effect
    (and (at ?creature ?to)
    (not (at ?creature ?from)))
  :agents
    (?creature)
  )

;; One person proposes to another.
(:action propose
  :parameters
    (?proposer - person ?proposee - person ?place - place)
  :precondition
    (and (alive ?proposer)
    (at ?proposer ?place)
    (alive ?proposee)
    (at ?proposee ?place)
    (loves ?proposer ?proposee))
  :effect
    (hasproposed ?proposer ?proposee)
  :agents
    (?proposer)
  )

  ;; One person accepts another's proposal.
  (:action accept
    :parameters
      (?accepter - person ?proposer - person ?place - place)
  :precondition
    (and (alive ?accepter)
    (at ?accepter ?place)
    (alive ?proposer)
    (at ?proposer ?place)
    (hasproposed ?proposer ?accepter))
  :effect
    (hasaccepted ?accepter ?proposer)
  :agents
    (?accepter)
  )

;; Two people marry.
(:action marry
  :parameters
    (?groom - person ?bride - person ?place - place)
  :precondition
    (and (alive ?groom)
    (at ?groom ?place)
    (hasproposed ?groom ?bride)
    (single ?groom)
    (alive ?bride)
    (at ?bride ?place)
    (hasaccepted ?bride ?groom)
    (single ?bride))
  :effect
    (and (marriedto ?groom ?bride)
    (marriedto ?bride ?groom)
    (not (single ?groom))
    (not (single ?bride))
    (forall (?v - valuable)
      (when (has ?groom ?v)
      (rich ?bride)))
    (when (loves ?groom ?bride)
      (happy ?groom))
    (when (loves ?bride ?groom)
      (happy ?bride)))
  :agents
    (?groom ?bride)
)

;; A creature steals an object from another creature.
(:action steal
  :parameters
    (?thief - creature ?victim - creature ?item - item ?place - place)
  :precondition
    (and (not (= ?thief ?victim))
    (alive ?thief)
    (at ?thief ?place)
    (at ?item ?place)
    (belongsto ?item ?victim))
  :effect
    (and (has ?thief ?item)
    (when (at ?victim ?place)
    (intends ?victim (has ?victim ?item)))
    (when (forall (?v - valuable)
      (not (has ?victim ?v)))
      (not (rich ?victim))))
  :agents
    (?thief)
)

;; A creature becomes hungry.
(:action get-hungry
  :parameters
    (?creature - creature)
  :precondition
    (not (hungry ?creature))
  :effect
    (and (hungry ?creature)
    (intends ?creature (not (hungry ?creature))))
  :agents
    (?creature)
)

;; A monster eats another creature.
(:action eat
  :parameters
    (?monster - monster ?creature - creature ?place - place)
  :precondition
    (and (alive ?monster)
    (at ?monster ?place)
    (hungry ?monster)
    (alive ?creature)
    (at ?creature ?place))
  :effect
    (and (not (hungry ?monster))
    (not (alive ?creature))
    (not (rich ?creature))
    (not (happy ?creature)))
  :agents
    (?monster)
)
"""

problem = """
(define (problem marriage)
(:domain fantasy)
(:objects
  ;; People
  talia - person
  rory - person
  vince - person
  gargax - monster
  ;; Places
  village - place
  cave - place
  ;; Things
  money - valuable
  treasure - valuable)
(:init
  (alive talia)
  (at talia village)
  (single talia)
  (loves talia rory)
  (alive vince)
  (at vince village)
  (has vince money)
  (rich vince)
  (single vince)
  (loves vince talia)
  (alive rory)
  (at rory village)
  (single rory)
  (loves rory talia)
  (alive gargax)
  (at gargax cave)
  (at treasure cave)
  (belongsto treasure gargax)
  (rich gargax)
  (intends talia (alive talia))
  (intends talia (rich talia))
  (intends talia (happy talia))
  (intends vince (alive vince))
  (intends vince (rich vince))
  (intends vince (happy vince))
  (intends rory (alive rory))
  (intends rory (happy rory))
  (intends gargax (alive gargax))
  (intends gargax (rich gargax)))
(:goal
  (and (happy talia)
  (rich talia)
  (alive vince)))
)
"""


solution = """
(define (plan marriage-solution)
  (:problem marriage)
  (:steps (propose rory talia village)
    (accept talia rory village)
    (travel rory village cave)
    (steal rory gargax treasure cave)
    (travel rory cave village)
    (marry rory talia village)))
"""


story = """
Once upon a time, in a small village, there lived a beautiful woman named Talia. She was single and lived a simple life. However, she had caught the eye of two men: Rory and Vince.

Rory was a handsome man who had been in love with Talia for a long time. Vince, on the other hand, was a wealthy man who had just arrived in the village. Both men were determined to win Talia's heart.

One day, Rory decided to take a chance and propose to Talia. He took her to a beautiful spot in the village and got down on one knee. Talia was surprised but also delighted. She had always had a soft spot for Rory. She said yes, and they embraced.

Meanwhile, Vince was not happy about this turn of events. He had also been planning to propose to Talia, and now he felt like he had lost his chance. He decided to take matters into his own hands and went to Talia to express his feelings. Talia was flattered but told Vince that she had already accepted Rory's proposal.

Feeling rejected, Vince decided to steal something from the village to make himself feel better. He went to a nearby cave where a monster named Gargax lived. Gargax was known to have a valuable treasure, and Vince thought that stealing it would make him feel better.

He snuck into the cave and found the treasure. However, Gargax caught him in the act. Vince tried to run away, but Gargax chased him down. In the end, Gargax ate Vince, and the village was rid of a thief.

Meanwhile, Rory and Talia were planning their wedding. They decided to have it in the village, and everyone was invited. The day of the wedding arrived, and it was a beautiful ceremony. Rory and Talia exchanged vows, and they became husband and wife.

After the wedding, Rory and Talia went on a honeymoon. They traveled to many different places and had a wonderful time together. They were happy and in love, and nothing could come between them.

As for Gargax, he continued to live in his cave, guarding his treasure. He was happy and content, and he never bothered the village again. The end.
"""

prompt = """
The story takes place in a fantasy setting. Talia, Vince, and Rory live in the same village. Vince and Rory both love Talia. Each of them is single. Talia loves Rory, but he's poor and Vince is quite wealthy. Gargax is a monster who lives in a nearby cave and guards a valuable treasure.

The key events in the story should consist of the following events. Characters can propose to one another, accept each other's proposals, get married, move from place to place, and steal valuables. Gargax can eat the characters if they are in the cave.

The story should end with Talia happy and rich, and Vince should be alive.
"""

fantasy_example = StoryScaffold(
    domain=domain,
    problem=problem,
    solution=solution,
    story=story,
    conditions_prompt=prompt,
)