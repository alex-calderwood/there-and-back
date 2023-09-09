from there_and_back.one_shot_examples.story_scaffold import StoryScaffold

domain = """
(define (domain space)
  (:requirements :adl :intentionality)
  (:types ; A creature is any living thing
          creature
          ; There are two types of places: landforms and ships.
          landform ship - place)
  (:predicates ; A creature is alive.
               (alive ?creature - creature)
               ; A creature is stunned.
               (stunned ?creature - creature)
			   ; A place is habitable.
			   (habitable ?place - place)
			   ; A place is safe.
			   (safe ?place - place)
			   ; A creature is safe.
			   (safe ?creature - creature)
			   ; A landform is erupting lava.
			   (erupting ?landform - place)
               ; An creature is at a place.
               (at ?creature - creature ?place - place)
               ; Two creatures are fighting.
               (fighting ?creature1 - creature ?creature2 - creature)
			   ; Two creatures are friends.
			   (friends ?creature1 - creature ?creature2 - creature)
			   ; A creature is captain of a ship
			   (captain ?creature - creature ?ship - ship)
			   ; A creature is a guardian of a place.
			   (guardian ?creature - creature ?place - place))


  (:action teleport-from-ship
    :parameters   (?creature - creature ?from - ship ?to - place)
    :precondition (and (not (= ?from ?to))
                       (alive ?creature)
                       (not (stunned ?creature))
                       (at ?creature ?from)
                       (habitable ?to)
                       (safe ?to)
                       (captain ?creature ?from))
    :effect       (and (at ?creature ?to)
                       (not (at ?creature ?from))
                       (when (not (safe ?creature))
                             (safe ?creature))
                       (forall (?c - creature)
                               (and (not (fighting ?creature ?c))
                                    (not (fighting ?c ?creature))
                                    (when (guardian ?c ?to)
                                          (intends ?c (not (alive ?creature)))))))
    :agents       (?creature))

  ;; A creature teleports from a place to a ship.
  (:action teleport-to-ship
    :parameters   (?creature - creature ?from - place ?to - ship)
    :precondition (and (not (= ?from ?to))
                       (alive ?creature)
                       (not (stunned ?creature))
                       (at ?creature ?from)
                       (habitable ?to)
                       (safe ?to)
                       (captain ?creature ?to))
    :effect       (and (at ?creature ?to)
                       (not (at ?creature ?from))
                       (when (not (safe ?creature))
                             (safe ?creature))
                       (forall (?c - creature)
                              (and (not (fighting ?creature ?c))
                                   (not (fighting ?c ?creature)))))
    :agents       (?creature))
  ;; One creature starts a fight with another.
  (:action attack
    :parameters   (?attacker - creature ?victim - creature ?place - place)
    :precondition (and (alive ?attacker)
                       (not (stunned ?attacker))
                       (at ?attacker ?place)
                       (alive ?victim)
                       (not (stunned ?victim))
                       (at ?victim ?place))
    :effect       (and (fighting ?attacker ?victim)
                       (intends ?victim (not (fighting ?attacker ?victim))))
    :agents       (?attacker))

  ;; One creatures kills another to end a fight.
  (:action kill
    :parameters   (?killer - creature ?victim - creature)
    :precondition (and (alive ?killer)
                       (not (stunned ?killer))
                       (alive ?victim)
                       (or (fighting ?killer ?victim)
                           (fighting ?victim ?killer)))
    :effect       (and (not (alive ?victim))
                       (when (fighting ?killer ?victim)
                             (not (fighting ?killer ?victim)))
                       (when (fighting ?victim ?killer)
                             (not (fighting ?victim ?killer))))
    :agents       (?killer))

  ;; One creatures stuns another to end a fight.
  (:action stun
    :parameters   (?stunner - creature ?victim - creature)
    :precondition (and (alive ?stunner)
                       (not (stunned ?stunner))
                       (alive ?victim)
                       (not (stunned ?victim))
                       (or (fighting ?stunner ?victim)
                           (fighting ?victim ?stunner)))
    :effect       (and (stunned ?victim)
                       (when (fighting ?stunner ?victim)
                             (not (fighting ?stunner ?victim)))
                       (when (fighting ?victim ?stunner)
                             (not (fighting ?victim ?stunner))))
    :agents       (?stunner))

  ;; A stunned creature breaks free.
  (:action break-free
    :parameters   (?victim - creature)
    :precondition (and (alive ?victim)
                       (stunned ?victim))
    :effect       (not (stunned ?victim))
    :agents       (?victim))

  ;; One creature makes peace with another.
  (:action make-peace
    :parameters   (?peacemaker - creature ?creature - creature ?place - place)
    :precondition (and (alive ?peacemaker)
                       (not (stunned ?peacemaker))
                       (at ?peacemaker ?place)
                       (alive ?creature)
                       (at ?creature ?place)
                       (not (fighting ?peacemaker ?creature))
                       (not (fighting ?creature ?peacemaker)))
    :effect       (and (friends ?peacemaker ?creature)
                       (friends ?creature ?peacemaker))
    :agents       (?peacemaker))

  ;; A volcano begins to errupt.
  (:action begin-erupt
    :parameters   (?landform - landform)
    :effect       (and (erupting ?landform)
                       (forall (?c - creature)
                               (when (at ?c ?landform)
                                     (and (not (safe ?c))
                                          (intends ?c (safe ?c)))))))

  ;; A volcano errupts.
  (:action erupt
    :parameters   (?landform - landform)
    :precondition (erupting ?landform)
    :effect       (and (not (habitable ?landform))
                       (not (erupting ?landform))
                       (forall (?c - creature)do
                               (when (at ?c ?landform)
                                     (not (alive ?c)))))))
"""

problem = """
(define (problem explore)
  (:domain space)
  (:objects ;; People
            zoe - creature
            lizard - creature
            ;; Places
            ship - ship
            surface - landform)
  (:init (habitable ship)
         (safe ship)
         (habitable surface)
         (safe surface)
         (alive zoe)
         (safe zoe)
         (at zoe ship)
         (captain zoe ship)
         (alive lizard)
         (safe lizard)
         (at lizard surface)
         (guardian lizard surface)
         (intends zoe (friends zoe lizard))
         (intends zoe (not (fighting zoe lizard)))
         (intends zoe (safe zoe))
         (intends zoe (alive zoe))
         (intends lizard (safe lizard))
         (intends lizard (alive lizard)))
  (:goal (and
       (not (habitable surface))
       (friends zoe lizard)
       (not (alive lizard))
       (alive zoe)
       (stunned lizard)
       )))
"""


solution = """
(define (plan explore-solution)
  (:problem explore)
  (:steps (teleport-from-ship zoe ship surface)
          (make-peace zoe lizard surface)
          (begin-erupt surface)
          (attack lizard zoe surface)
          (stun zoe lizard)
          (non-executed (kill lizard zoe))
          (teleport-to-ship zoe surface ship)
          (erupt surface)))
"""


story = """
Zoe is the lone of the Tocqueville, a deep space vessel that aims to understand the sociology and psychology of planetary governance. Zoe spent her early years studying indiginous land-rights management, before joining the fleet. She is a skilled diplomat and a capable captain.

The lizard meanwhile, is the gaurdian of the unnamed planet. The lizard is a large, bipedal sauropsid with a long tail and a large head. It has studied the philosophy of gaurdianship since its abiogenic conception around 3 billion years ago. It is a formidable warrior.

Zoe has been in orbit for a few years, and one day readings tell her that an eruption from the largest volcano is imminent. She has identified the location of the guardian and has decided to make contact with it, hoping to engage it in a dialogue before time runs out. She admires it and would personally like to make a friend. Her teleporter is able to directly beam her to the surface, in front of its roaming ground.

Immediately he is saddened as he knows he is ordained to still any life that is not of the planet. Readying his spit poison, which is capable of delivering cosmic awe so vast it can remove the will to life, he is struck by her calm. She extends her family crystals in a gesture of peace, just as rumbles begin in the distance. "This planet will soon be covered in lava," she says, "and I would like to know you before that happens."

The lizard nods, "Consider us friends." It projects a glob of the poison onto her. In a deft motion her own crystals envelop her body arms and she deflects the glob back onto the eyes of the lizard, who is stunned by the transcendence of its beauty.

She beams herself back to the ship, and the volcano erupts. The lizard is killed by the lava, but Zoe is safe. She is sad that she could not save the lizard.
"""

prompt = """
The story takes place in a space setting. Zoe is the captain of a spaceship, and the lizard is the guardian of a planet. Zoe wants to make friends with the lizard, but the lizard guardian will desire to kill any offworld creature. Both Zoe and the lizard want to stay safe and alive.

The key events in the story should consist of the following: a captain and teleport to and from their ship to a place. Characters can fight each other and kill each other once a fight has begun. Characters can be stunned, and once they are stunned they are immobile until they break free. A character can make friends with another character if they aren't fighting. A volcano on the planet can begin to erupt at any time, at which point all characters will try to find safety. When the volcano erupts, anyone on the surface will die.

The story should end with the surface uninhabitable, Zoe alive, the lizard stunned and dead.
"""

space_example = StoryScaffold(
    domain=domain,
    problem=problem,
    solution=solution,
    story=story,
    conditions_prompt=prompt,
)