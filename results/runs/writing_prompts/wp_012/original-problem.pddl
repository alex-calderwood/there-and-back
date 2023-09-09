(define (problem carl-creates-carl-jr)
  (:domain
    carl-and-carl-jr)
  (:objects
    me carl carl-jr - character
    garage house - object)
  (:init
    (at me house)
    (at carl garage)
    (intends carl (assembled carl-jr))
    (intends carl (has-robot carl carl-jr))
    (intends carl (playing-game carl))
    (intends me (playing-game me)))
  (:goal
    (and (assembled carl-jr)
    (has-robot carl carl-jr)
    (working-on-task carl-jr)
    (playing-game carl)
    (playing-game me)))
)