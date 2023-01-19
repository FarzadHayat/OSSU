;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname demo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

empty
(cons "test" '())

(define L1 (cons "Flames" empty))                ; a list of 1 element
(cons "Leafs" (cons "Flames" empty)) ; a list of 1 element

(cons (string-append "C" "anucks") empty)

(define L2 (cons 10 (cons 9 (cons 10 empty))))  ; a list of 3 elements

(define L3 (cons (square 10 "solid" "blue")
      (cons (triangle 20 "solid" "green")
            empty)))

(first L1)
(first L2)
(first L3)

(rest L1)
(rest L2)
(rest L3)

;(... L2) ; how do I get the second element of L2?
;(... L2) ; how do I get the third element of L2?

(rest (rest L2))
(first (rest (rest L2)))

(empty? empty)
(empty? L1)
(empty? L2)
(empty? L3)