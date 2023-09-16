;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname half-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Number -> Number ;signature
;; produces 1/2 times the given number ;purpose
(check-expect (half 6) 3) ;examples
(check-expect (half 8.4) 4.2)

;(define (half n) 0) ;stub

;(define (half n) ;template
;  (... n))

(define (half n) ;function body
  (/ n 2))