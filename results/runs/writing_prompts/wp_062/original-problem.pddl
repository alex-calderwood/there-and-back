(define (problem dragonborn-legacy)
  (:domain
    skyrim-dragonborn)
  (:objects
    dragonborn town-guard winterhold-shopkeeper priest bandit-corpse jarl-of-windhelm
    thieves-guild riften khajith college-of-winterhold dark-brotherhood thalmor
    unnamed-companion ysolda whiterun-blacksmith unnamed-courier former-adventurer
    dragon - character
    skyrim - place
  )
  (:init
    (alive dragonborn)
    (at dragonborn skyrim)
    (intends dragonborn (alive dragonborn))
    (intends dragonborn (dragon-soul-absorbed dragonborn))
    (intends dragonborn (blessed-by-talos dragonborn))
    (intends dragonborn (enchanted-goods-sold dragonborn))
    (intends dragonborn (relics-sold dragonborn))
    (intends dragonborn (werewolf dragonborn))
    (intends dragonborn (married dragonborn ysolda))
    (intends dragonborn (weapon-crafted dragonborn))
    (intends dragonborn (saved dragonborn former-adventurer))
  )
  (:goal
    (and (dragon-soul-absorbed dragonborn)
    (blessed-by-talos dragonborn)
    (enchanted-goods-sold dragonborn)
    (relics-sold dragonborn)
    (werewolf dragonborn)
    (married dragonborn ysolda)
    (weapon-crafted dragonborn)
    (saved dragonborn former-adventurer))
  )
)