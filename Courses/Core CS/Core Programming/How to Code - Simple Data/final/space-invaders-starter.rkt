;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 50)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define INVADER-WIDTH/2 (/ (image-width INVADER) 2))

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-WIDTH/2 (/ (image-width TANK) 2))
(define TANK-HEIGHT/2 (/ (image-height TANK) 2))
(define TANK-Y (- HEIGHT TANK-HEIGHT/2))

(define MISSILE (ellipse 5 15 "solid" "red"))



;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game ListOfInvader ListOfMissile Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below ListOfMissile data definition

#;
(define (fn-for-game g)
  (... (fn-for-loi (game-invaders g))
       (fn-for-lom (game-missiles g))
       (fn-for-tank (game-tank g))))



(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t)
       (tank-dir t)))


(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right
(define I4 (make-invader 100 150 -11))          ;not landed, moving left


#;
(define (fn-for-invader i)
  (... (invader-x i)
       (invader-y i)
       (invader-dx i)))

;; ListOfInvader is one of:
;;  - empty
;;  - (cons Invader ListOfInvader)
;; interp a list of invaders
(define LOI0 empty)
(define LOI1 (cons I1 (cons I4 empty)))

#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (fn-for-invader (first loi)) ;Invader
              (fn-for-loi (rest loi)))]))  ;ListOfInvader


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                               ;not hit I1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit I1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit I1

#;
(define (fn-for-missile m)
  (... (missile-x m)
       (missile-y m)))

;; ListOfMissile is one of:
;;  - empty
;;  - (cons Missile ListOfMissile)
;; interp a list of missiles
(define LOM0 empty)
(define LOM1 (cons M1 (cons M2 empty)))

#;
(define (fn-for-lom lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom)) ;Missile
              (fn-for-lom (rest lom)))]))  ;ListOfMissile



(define G0 (make-game empty        empty        T0))
(define G1 (make-game empty        empty        T1))
(define G2 (make-game (list I1 I4) (list M1 M2) T1)) ;invader 1 shot
(define G3 (make-game (list I2)    (list M1)    T1)) ;game over
(define G4 (make-game (list I3)    empty        T1)) ;game over



;; Functions:

;; Game -> Game
;; start the world with (main G0)
;; no tests required for main function
(define (main g)
  (big-bang g                ; Game
    (on-tick   next-game)    ; Game -> Game
    (to-draw   render-game)  ; Game -> Image
    (on-key    handle-key)   ; Game KeyEvent -> Game
    (stop-when game-over?))) ; Game -> Boolean

;; Game -> Game
;; first tick game, then handle collisions.
(check-expect (next-game G2) (handle-collisions (tick-game G2)))

;(define next-game g) g) ;stub

;template from Game
(define (next-game g)
  (handle-collisions (tick-game g)))

;; Game -> Game
;; get next invaders, missiles, and tank.
;; filters missiles that have left the screen.
;; randomly adds new invaders at the top of th screen.
(check-expect (tick-game G0)
              (make-game (spawn-invader (next-invaders (game-invaders G0)))
                         (filter-missiles (next-missiles (game-missiles G0)))
                         (next-tank (game-tank G0))))

;(define (tick-game g) g) ;stub

;template from Game
(define (tick-game g)
  (make-game (spawn-invader (next-invaders (game-invaders g)))
             (filter-missiles (next-missiles (game-missiles g)))
             (next-tank (game-tank g))))

;; Game -> Game
;; produce game with collided invaders and missiles removed
(check-expect (handle-collisions G0) G0)
(check-expect (handle-collisions G2) (make-game (list I4) (list M1) T1))
(check-expect (handle-collisions (make-game
                                  (list I1 (make-invader 10 10 1))
                                  (list M3 (make-missile 0 10)) T1))
              (make-game empty empty T1))

;(define (handle-collisions g) g) ;stub

;template from Game
(define (handle-collisions g)
  (make-game (remove-hit-invaders (game-invaders g) (game-missiles g))
             (remove-hit-missiles (game-missiles g) (game-invaders g))
             (game-tank g)))

;; ListOfInvader ListOfMissile -> ListOfInvader
;; produce list with invaders hit removed
(check-expect (remove-hit-invaders empty empty) empty)
(check-expect (remove-hit-invaders (list I1) empty) (list I1))
(check-expect (remove-hit-invaders (list I1) (list M1)) (list I1))
(check-expect (remove-hit-invaders (list I1 I4) (list M1 M2)) (list I4))
(check-expect (remove-hit-invaders (list I1 (make-invader 10 10 1))
                                   (list M3 M3 (make-missile 0 10))) empty) ;two missiles hit the same invader
(check-expect (remove-hit-invaders (list I1 I1) (list M3)) empty) ;missile hit two invaders at the same time

;(define (remove-hit-invaders loi lom) loi) ;stub

;template from ListOfInvader
(define (remove-hit-invaders loi lom)
  (cond [(empty? loi) empty]
        [else
         (if (invader-hit? lom (first loi))
             (remove-hit-invaders (rest loi) lom)
             (cons (first loi) (remove-hit-invaders (rest loi) lom)))]))

;; ListOfMissile Invader -> Boolean
;; produce true if invader has been hit by any missiles
(check-expect (invader-hit? empty I1) false)
(check-expect (invader-hit? (list M1) I1) false)
(check-expect (invader-hit? (list M1 M2) I1) true)
(check-expect (invader-hit? (list M1 M3) I1) true)
(check-expect (invader-hit? (list M2 M3) I1) true) ;hit by two missiles at once

;(define (invader-hit? lom i) false) ;stub

;template from ListOfMissile with Invader parameters
(define (invader-hit? lom i)
  (cond [(empty? lom) false]
        [else
         (or (collided? i (first lom))
             (invader-hit? (rest lom) i))]))

;; ListOfMissile ListOfInvader -> ListOfMissile
;; produce list with missiles hit removed
(check-expect (remove-hit-missiles empty empty) empty)
(check-expect (remove-hit-missiles (list M1) empty) (list M1))
(check-expect (remove-hit-missiles (list M1) (list I1)) (list M1))
(check-expect (remove-hit-missiles (list M1 M2) (list I1 I4)) (list M1))
(check-expect (remove-hit-missiles (list M3 (make-missile 0 10))
                                   (list I1 (make-invader 10 10 1))) empty)

;(define (remove-hit-missiles lom loi) lom) ;stub

;template from ListOfMissile
(define (remove-hit-missiles lom loi)
  (cond [(empty? lom) empty]
        [else
         (if (missile-hit? loi (first lom))
             (remove-hit-missiles (rest lom) loi)
             (cons (first lom) (remove-hit-missiles (rest lom) loi)))]))

;; ListOfInvader Missile -> Boolean
;; produce true if missile has hit any invaders
(check-expect (missile-hit? empty M1) false)
(check-expect (missile-hit? LOI1 M1) false)
(check-expect (missile-hit? LOI1 M2) true)
(check-expect (missile-hit? LOI1 M3) true)
(check-expect (missile-hit? (list I1 (make-invader 150 100 12)) M3) true) ;hit two invaders at once

;(define (missile-hit? loi m) false) ;stub

;template from ListOfInvader with Missile parameters
(define (missile-hit? loi m)
  (cond [(empty? loi) false]
        [else
         (or (collided? (first loi) m)
             (missile-hit? (rest loi) m))]))

;; Invader Missile -> Boolean
;; produce true if invader is within hit range of missile.
(check-expect (collided? I1 M1) false)
(check-expect (collided? I1 M2) true)
(check-expect (collided? I1 M3) true)

;(define (collided? i m) false) ;stub

;template from Invader with Missile parameters
(define (collided? i m)
  (<= (distance i m) HIT-RANGE))

;; Invader Missile -> Number
;; produce distance between invader and missile
(check-expect (distance (make-invader 10 10 1) (make-missile 10 10)) 0)
(check-expect (distance (make-invader 10 10 1) (make-missile 13 14)) 5)
(check-within (distance (make-invader 100 100 1) (make-missile 70 80))
              (sqrt (+ (sqr 30) (sqr 20))) 0.01)

;(define (distance i m) 0) ;stub

;template from Invader with Missile parameters
(define (distance i m)
  (sqrt
   (+ (sqr (abs (- (invader-x i) (missile-x m))))
      (sqr (abs (- (invader-y i) (missile-y m)))))))


;; ListOfInvader -> ListOfInvader
;; produce list with chance of new invader spawning.
(check-random (spawn-invader empty) (if (= (random INVADE-RATE) 0)
                                        (cons (make-invader (random WIDTH) 0 1) empty)
                                        empty))

;(define (spawn-invader loi) loi) ;stub

;template from ListOfInvader
(define (spawn-invader loi)
  (if (= (random INVADE-RATE) 0)
      (cons (make-invader (random WIDTH) 0 1) loi)
      loi))

;; ListOfMissile -> ListOfMissile
;; produce list with missiles that are not visible removed
(check-expect (filter-missiles empty) empty)
(check-expect (filter-missiles LOM1) LOM1)
(check-expect (filter-missiles (list M1 (make-missile 50 0) (make-missile 50 -10))) (list M1))

;(define (filter-missiles lom) lom) ;stub

;template from ListOfMissile
(define (filter-missiles lom)
  (cond [(empty? lom) empty]
        [else
         (if (visible? (first lom))
             (cons (first lom) (filter-missiles (rest lom)))
             (filter-missiles (rest lom)))]))

;; Missile -> Missile
;; produce true if missile position is visible on screen
;; ASSUMES: missile only moves upwards
(check-expect (visible? M1) true)
(check-expect (visible? (make-missile 50 0)) false)
(check-expect (visible? (make-missile 50 -10)) false)

;(define (visible? m) false) ;stub

;template from Missile
(define (visible? m)
  (> (missile-y m) 0))

;; ListOfInvader -> ListOfInvader
;; produce next list of invaders
(check-expect (next-invaders empty) empty)
(check-expect (next-invaders (list I1 I2)) (list (next-invader I1) (next-invader I2)))

;(define (next-invaders loi) loi) ;stub

;template from ListOfInvader
(define (next-invaders loi)
  (cond [(empty? loi) empty]
        [else
         (cons (next-invader (first loi))
               (next-invaders (rest loi)))]))

;; Invader -> Invader
;; produce next invader changing direction if bounce? is true and then moving downwards at a diagonal
(check-expect (next-invader I1) (make-invader
                                 (+ (invader-x I1) (* INVADER-X-SPEED (invader-dx I1)))
                                 (+ (invader-y I1) (abs (* INVADER-Y-SPEED (invader-dx I1))))
                                 (invader-dx I1)))
(check-expect (next-invader I2) (make-invader
                                 (+ (invader-x I2) (* INVADER-X-SPEED (invader-dx I2)))
                                 (+ (invader-y I2) (abs (* INVADER-Y-SPEED (invader-dx I2))))
                                 (invader-dx I2)))

(check-expect (next-invader (make-invader (- WIDTH INVADER-WIDTH/2) 50 10)) ;bounce off right edge
              (make-invader (+ (- WIDTH INVADER-WIDTH/2) (* INVADER-X-SPEED -10))
                            (+ 50 (abs (* INVADER-Y-SPEED -10)))
                            -10))
(check-expect (next-invader (make-invader INVADER-WIDTH/2 50 -10))          ;bounce off left edge
              (make-invader (+ INVADER-WIDTH/2 (* INVADER-X-SPEED 10))
                            (+ 50 (abs (* INVADER-Y-SPEED 10)))
                            10))

;(define (next-invader i) i) ;stub

;template from Invader
(define (next-invader i)
  (if (bounce? i)
      (make-invader (+ (invader-x i) (* INVADER-X-SPEED (* -1 (invader-dx i))))
                    (+ (invader-y i) (abs (* INVADER-Y-SPEED (* -1 (invader-dx i)))))
                    (* -1 (invader-dx i)))
      (make-invader (+ (invader-x i) (* INVADER-X-SPEED (invader-dx i)))
                    (+ (invader-y i) (abs (* INVADER-Y-SPEED (invader-dx i))))
                    (invader-dx i))))

;; Invader -> Boolean
;; produce true if touching left edge and going left OR touching right edge and going right
(check-expect (bounce? I1) false)
(check-expect (bounce? I2) false)

(check-expect (bounce? (make-invader INVADER-WIDTH/2 50 -10)) true) ;left side going left
(check-expect (bounce? (make-invader 0 50 -10)) true)
(check-expect (bounce? (make-invader INVADER-WIDTH/2 50 10)) false) ;left side going right
(check-expect (bounce? (make-invader 0 50 10)) false)

(check-expect (bounce? (make-invader (- WIDTH INVADER-WIDTH/2) 50 10)) true) ;right side going right
(check-expect (bounce? (make-invader WIDTH 50 10)) true)
(check-expect (bounce? (make-invader (- WIDTH INVADER-WIDTH/2) 50 -10)) false) ;right side going left
(check-expect (bounce? (make-invader WIDTH 50 -10)) false)

;(define (bounce? i) false) ;stub

;template from Invader
(define (bounce? i)
  (or
   (and
    (<= (invader-x i) INVADER-WIDTH/2)           ;left side and
    (negative? (invader-dx i)))                  ;going left
   (and
    (>= (invader-x i) (- WIDTH INVADER-WIDTH/2)) ;right side and
    (positive? (invader-dx i)))))                ;going right

;; ListOfMissile -> ListOfMissile
;; produce next list of missiles
(check-expect (next-missiles empty) empty)
(check-expect (next-missiles (list M1 M2)) (list (next-missile M1) (next-missile M2)))

;(define (next-missiles lom) lom) ;stub

;template from ListOfMissile
(define (next-missiles lom)
  (cond [(empty? lom) empty]
        [else
         (cons (next-missile (first lom))
               (next-missiles (rest lom)))]))

;; Missile -> Missile
;; produce next missile position going upwards.
(check-expect (next-missile M1) (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)))
(check-expect (next-missile M2) (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED)))

;(define (next-missile m) m) ;stub

;template from Missile
(define (next-missile m)
  (make-missile (missile-x m)
                (- (missile-y m) MISSILE-SPEED)))

;; Tank -> Tank
;; produce next tank position by changing direction if touching sides, and then moving to new position.
(check-expect (next-tank T1)
              (make-tank (+ (tank-x T1) (* TANK-SPEED (tank-dir T1)))
                         (tank-dir T1)))
(check-expect (next-tank T2)
              (make-tank (+ (tank-x T2) (* TANK-SPEED (tank-dir T2)))
                         (tank-dir T2)))

(check-expect (next-tank (make-tank (- WIDTH TANK-WIDTH/2) 1)) ;bounce off right side
              (make-tank (+ (- WIDTH TANK-WIDTH/2) (* TANK-SPEED -1)) -1))
(check-expect (next-tank (make-tank TANK-WIDTH/2 -1))          ;bounce off left side
              (make-tank (+ TANK-WIDTH/2 (* TANK-SPEED 1)) 1))

;(define (next-tank t) t) ;stub

;template from Tank
(define (next-tank t)
  (if (touching-sides? t)
      (make-tank (+ (tank-x t) (* TANK-SPEED (tank-dir (change-dir t))))
                 (tank-dir (change-dir t)))
      (make-tank (+ (tank-x t) (* TANK-SPEED (tank-dir t)))
                 (tank-dir t))))

;; Tank -> Boolean
;; produce true if tank touching left edge and going left OR touching right edge and going right
(check-expect (touching-sides? T1) false)
(check-expect (touching-sides? T2) false)

(check-expect (touching-sides? (make-tank TANK-WIDTH/2 -1)) true) ;left side going left
(check-expect (touching-sides? (make-tank 0 -1)) true)
(check-expect (touching-sides? (make-tank TANK-WIDTH/2 1)) false) ;left side going right
(check-expect (touching-sides? (make-tank 0 1)) false)

(check-expect (touching-sides? (make-tank (- WIDTH TANK-WIDTH/2) 1)) true) ;right side going right
(check-expect (touching-sides? (make-tank WIDTH 1)) true)
(check-expect (touching-sides? (make-tank (- WIDTH TANK-WIDTH/2) -1)) false) ;right side going left
(check-expect (touching-sides? (make-tank WIDTH -1)) false)

;(define (touching-sides? t) false) ;stub

;template from Tank
(define (touching-sides? t)
  (or
   (and
    (<= (tank-x t) TANK-WIDTH/2)           ;left side and
    (negative? (tank-dir t)))              ;going left
   (and
    (>= (tank-x t) (- WIDTH TANK-WIDTH/2)) ;right side and
    (positive? (tank-dir t)))))            ;going right


;; Game -> Image
;; first render tank, then render missiles, then render invaders.
(check-expect (render-game G3) (render-invaders    ;top layer invaders
                                (game-invaders G3)
                                (render-missiles   ;middle layer missiles
                                 (game-missiles G3)
                                 (render-tank      ;bottom layer tank
                                  (game-tank G3)
                                  BACKGROUND))))

;(define (render-game g) BACKGROUND) ;stub

;template from Game, function composition
(define (render-game g)
  (render-invaders (game-invaders g)
                   (render-missiles (game-missiles g)
                                    (render-tank (game-tank g) BACKGROUND))))

;; ListOfInvader Image -> Image
;; render invaders onto given img at appropriate positions.
(check-expect (render-invaders empty BACKGROUND) BACKGROUND)
(check-expect (render-invaders (list I1) BACKGROUND)
              (place-image INVADER (invader-x I1) (invader-y I1) BACKGROUND))
(check-expect (render-invaders (list I1 I2 I3) BACKGROUND)
              (place-image INVADER (invader-x I3) (invader-y I3)
                           (place-image INVADER (invader-x I2) (invader-y I2)
                                        (place-image INVADER (invader-x I1) (invader-y I1) BACKGROUND))))

;(define (render-invaders lom img) img) ;stub

;template from ListOfInvader
(define (render-invaders loi img)
  (cond [(empty? loi) img]
        [else
         (render-invader (first loi)
                         (render-invaders (rest loi) img))]))

;; Invader Image -> Image
;; render invader at invader-x i, invader-y i onto img.
(check-expect (render-invader I1 BACKGROUND) (place-image INVADER (invader-x I1) (invader-y I1) BACKGROUND))
(check-expect (render-invader I2 BACKGROUND) (place-image INVADER (invader-x I2) (invader-y I2) BACKGROUND))

;(define (render-invader i img) img) ;stub

;template from Invader
(define (render-invader i img)
  (place-image INVADER
               (invader-x i)
               (invader-y i)
               img))

;; ListOfMissile Image -> Image
;; render missiles onto given img at appropriate positions.
(check-expect (render-missiles empty BACKGROUND) BACKGROUND)
(check-expect (render-missiles (list M1) BACKGROUND)
              (place-image MISSILE (missile-x M1) (missile-y M1) BACKGROUND))
(check-expect (render-missiles (list M1 M2 M3) BACKGROUND)
              (place-image MISSILE (missile-x M3) (missile-y M3)
                           (place-image MISSILE (missile-x M2) (missile-y M2)
                                        (place-image MISSILE (missile-x M1) (missile-y M1) BACKGROUND))))

;(define (render-missiles lom img) img) ;stub

;template from ListOfMissile
(define (render-missiles lom img)
  (cond [(empty? lom) img]
        [else
         (render-missile (first lom)
                         (render-missiles (rest lom) img))]))

;; Missile Image -> Image
;; render missile at missile-x m, missile-y m onto img.
(check-expect (render-missile M1 BACKGROUND) (place-image MISSILE (missile-x M1) (missile-y M1) BACKGROUND))
(check-expect (render-missile M2 BACKGROUND) (place-image MISSILE (missile-x M2) (missile-y M2) BACKGROUND))

;(define (render-missile m img) img) ;stub

;template from Missile
(define (render-missile m img)
  (place-image MISSILE
               (missile-x m)
               (missile-y m)
               img))

;; Tank Image -> Image
;; render tank onto given img at tank-x t, TANK-Y.
(check-expect (render-tank T0 BACKGROUND) (place-image TANK (tank-x T0) TANK-Y BACKGROUND))
(check-expect (render-tank T2 BACKGROUND) (place-image TANK (tank-x T2) TANK-Y BACKGROUND))

;(define (render-tank t img) img) ;stub

;template from Tank
(define (render-tank t img)
  (place-image TANK (tank-x t) TANK-Y img))



;; Game KeyEvent -> Game
;; handle the following player key presses:
;;  - arrow key:   change tank direction to left
;;  - arrow right: change tank direction to right
;;  - space bar:   fire missile
(check-expect (handle-key (make-game empty empty T1) "left") ;change to left
              (make-game empty empty (change-dir T1)))
(check-expect (handle-key (make-game empty empty T2) "left") ;already left
              (make-game empty empty T2))
(check-expect (handle-key (make-game empty empty T1) "right") ;change to right
              (make-game empty empty T1))
(check-expect (handle-key (make-game empty empty T2) "right") ;already right
              (make-game empty empty (change-dir T2)))
(check-expect (handle-key G2 " ") (make-game (game-invaders G2)
                                       (fire-missile (game-missiles G2) (game-tank G2))
                                       (game-tank G2)))

(check-expect (handle-key G2 "up") G2)

;(define (handle-key g ke) g) ;stub

;template from HtDW recipe page
(define (handle-key g ke)
  (cond [(key=? ke "left")  (if (positive? (tank-dir (game-tank g)))
                                (make-game (game-invaders g)
                                           (game-missiles g)
                                           (change-dir (game-tank g)))
                                g)]
        [(key=? ke "right") (if (negative? (tank-dir (game-tank g)))
                                (make-game (game-invaders g)
                                           (game-missiles g)
                                           (change-dir (game-tank g)))
                                g)]
        [(key=? ke " ")     (make-game (game-invaders g)
                                       (fire-missile (game-missiles g) (game-tank g))
                                       (game-tank g))]
        [else g]))

;; Tank -> Tank
;; produce tank with direction reversed
(check-expect (change-dir T1) T2)
(check-expect (change-dir T2) T1)

;(define (change-dir t) t) ;stub

;template from Game
(define (change-dir t)
  (make-tank (tank-x t) (* -1 (tank-dir t))))

;; ListOfMissile Tank -> ListOfMissile
;; produce list with new missile at tank-x t, (- TANK-Y (image-height MISSILE))
(check-expect (fire-missile empty T0) (cons (make-missile
                                             (tank-x T0)
                                             (- TANK-Y (image-height MISSILE)))
                                            empty))
(check-expect (fire-missile (list M1 M2) T0) (cons (make-missile
                                                    (tank-x T0)
                                                    (- TANK-Y (image-height MISSILE)))
                                                   (list M1 M2)))

;(define (fire-missile lom t) lom) ;stub

;template from ListOfMissile
(define (fire-missile lom t)
  (cons (make-missile
         (tank-x t)
         (- TANK-Y (image-height MISSILE)))
        lom))



;; Game -> Boolean
;; produce true if an invader has landed
(check-expect (game-over? G0) false)
(check-expect (game-over? G2) false)
(check-expect (game-over? G3)  true)
(check-expect (game-over? G4)  true)

;(define (game-over? g) false) ;stub

;template from Game
(define (game-over? g)
  (cond [(empty? (game-invaders g)) false]
        [else
         (or (landed? (first (game-invaders g)))
             (game-over?
              (make-game (rest (game-invaders g))
                         (game-missiles g)
                         (game-tank g))))]))

;; Invader -> Boolean
;; produce true if (invader-y i) is greater than or equal to HEIGHT
(check-expect (landed? I1) false)
(check-expect (landed? I2)  true)
(check-expect (landed? I3)  true)

;(define (landed? i) false) ;stub

;template from Invader
(define (landed? i)
  (>= (invader-y i) HEIGHT))
