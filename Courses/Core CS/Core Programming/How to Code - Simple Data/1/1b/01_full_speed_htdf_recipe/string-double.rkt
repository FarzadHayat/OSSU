;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname string-double) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; String -> String ;signature
;; produces two of the given string concatenated together ;purpose
(check-expect (string-double "abc") "abcabc") ;examples
(check-expect (string-double "hi there ") "hi there hi there ")

;(define (string-double s) "a") ;stub

;(define (string-double s) ;template
;  (... s))

(define (string-double s) ;function body
  (string-append s s))