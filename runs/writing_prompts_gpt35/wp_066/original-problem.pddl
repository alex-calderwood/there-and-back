(define (problem dr-vertigo-attack)
  (:domain
    dr-vertigo)
  (:objects
    dr-vertigo security intern - character
    un-building safe-room - place
    minibot-1 minibot-2 minibot-3 minibot-4 minibot-5 minibot-6 minibot-7 minibot-8 minibot-9 minibot-10 - minibot)
  (:init
    (alive dr-vertigo)
    (at dr-vertigo un-building)
    (intends dr-vertigo (intends minibot-1 (damaged un-building)))
    (intends dr-vertigo (intends minibot-2 (damaged un-building)))
    (intends dr-vertigo (intends minibot-3 (damaged un-building)))
    (intends dr-vertigo (intends minibot-4 (damaged un-building)))
    (intends dr-vertigo (intends minibot-5 (damaged un-building)))
    (intends dr-vertigo (intends minibot-6 (damaged un-building)))
    (intends dr-vertigo (intends minibot-7 (damaged un-building)))
    (intends dr-vertigo (intends minibot-8 (damaged un-building)))
    (intends dr-vertigo (intends minibot-9 (damaged un-building)))
    (intends dr-vertigo (intends minibot-10 (damaged un-building)))
    (alive security)
    (at security un-building)
    (armed security)
    (intends security (kill dr-vertigo))
    (alive intern)
    (at intern un-building)
    (intends intern (alive intern))
    (intends intern (not (damaged un-building)))
    (intends intern (not (captured secretary-general)))
    (at secretary