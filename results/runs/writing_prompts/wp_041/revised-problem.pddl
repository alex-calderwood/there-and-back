(define (problem save-humanity)
  (:domain
    mark-implant)
  (:objects
    mark col dr-linkens - character
    lab-a lab-b - lab
    prototype-small prototype-large - prototype)
  (:init
    (at mark lab-a)
    (at col lab-a)
    (at dr-linkens lab-a)
    (working-3d-printer lab-a)
    (intends mark (awake mark))
    (intends col (awake col))
    (intends dr-linkens (awake dr-linkens))
    (intends mark (prototype-successful prototype-large))
    (intends mark (has-implant mark prototype-large))
  )
  (:goal
    (and (has-implant mark prototype-large)
    (prototype-successful prototype-large))
  )
)