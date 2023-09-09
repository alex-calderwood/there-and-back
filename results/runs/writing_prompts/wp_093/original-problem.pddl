(define (problem reddit-unity)
  (:domain
    reddit-civil-war)
  (:objects
    spez - character
    jeans tshirt hoodie - object
    fellowkids gonewild nofap atheism changemyview TumblrInAction shitredditsays The_Donald - subreddit)
  (:init
    (intends spez (wearing spez jeans))
    (intends spez (wearing spez tshirt))
    (intends spez (wearing spez hoodie))
    (intends gonewild (united gonewild nofap))
    (intends atheism (united atheism changemyview))
    (intends TumblrInAction (truce TumblrInAction shitredditsays))
    (intends shitredditsays (truce TumblrInAction shitredditsays))
    (intends spez (exists The_Donald))
    (intends spez (wall-built))
    (intends spez (filled-with-water))
  )
  (:goal
    (and (wearing spez jeans)
    (wearing spez tshirt)
    (wearing spez hoodie)
    (united gonewild nofap)
    (united atheism changemyview)
    (truce TumblrInAction shitredditsays)
    (exists The_Donald)
    (wall-built)
    (filled-with-water))
  )
)