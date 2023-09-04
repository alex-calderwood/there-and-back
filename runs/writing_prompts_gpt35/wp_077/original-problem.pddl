(define (problem poem-problem)
  (:domain poem)
  (:objects
    reader - object
    poem - object
    love - word
    echo - word
    tempo - word
    song - word
    confess - word
    know - word
    gone - word
    act - word
    kill - word
    heard - word
    alive - word
    peruse - word
    question - word
    accuracy - word
    right - word
    wrong - word
    feel - word
    worry - word
    race - word
    hurry - word)
  (:init
    (word love)
    (word echo)
    (word tempo)
    (word song)
    (word confess)
    (word know)
    (word gone)
    (word act)
    (word kill)
    (word heard)
    (word alive)
    (word peruse)
    (word question)
    (word accuracy)
    (word right)
    (word wrong)
    (word feel)
    (word worry)
    (word race)
    (word hurry)
    (alive reader)
    (alive poem)
    (intends reader (peruse poem))
    (intends reader (question poem))
    (intends reader (kill poem))
    (intends poem (confess confess))
    (intends poem (acknowledge-mortality gone))
    (intends poem (declare-love love))
    (intends poem (become-echo echo))
    (intends poem (become-tempo tempo))
    (intends poem (become-song song)))
  (:goal
    (and
      (echo love)
      (tempo echo)
      (song tempo)
      (love song)))
)