;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname plural) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; String -> String ;signature
;; Pluralizes the given word by adding s onto the end. ;purpose
(check-expect (plural "tree") "trees") ;examples
(check-expect (plural "chubby bear") "chubby bears")

;(define (plural s) "a") ;stub

;(define (plural s) ;template
;  (... s))

(define (plural s) ;function body
  (string-append s "s"))