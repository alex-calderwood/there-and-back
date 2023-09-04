(define (problem make-cake)
  (:domain skelly-cake)
  (:objects
    skelly friend1 friend2 friend3 - character
    house mixing-bowl flour sugar eggs milk oven - object)
  (:init
    (at skelly house)
    (at friend1 house)
    (at friend2 house)
    (at friend3 house)
    (at mixing-bowl house)
    (at flour house)
    (at sugar house)
    (at eggs house)
    (at milk house)
    (at oven house)
    (intends skelly (has-mixing-bowl))
    (intends skelly (has-flour))
    (intends skelly (has-sugar))
    (intends skelly (has-eggs))
    (intends skelly (has-milk))
    (intends skelly (has-oven))
    (intends friend1 (has-mixing-bowl))
    (intends friend2 (has-flour))
    (intends friend3 (has-sugar))
    (intends friend1 (has-eggs))
    (intends friend2 (has-milk))
    (intends friend3 (has-oven)))
  (:goal
    (and (at skelly house)
    (at friend1 house)
    (at friend2 house)
    (at friend3 house)
    (at mixing-bowl house)
    (at oven house)
    (at cake house)
    (not (at flour house)))
    (not (at sugar house))
    (not (at eggs house))
    (not (at milk house)))
)