;; BEGIN DEFINES

;; Kakuro board
; (define board 
;     (vector 
;         (vector 0 0 0)  (vector 0 12 0) (vector 0 21 0) (vector 0 0 0)   (vector 0 16 0) (vector 0 13 0)
;         (vector 0 0 17) (vector 1 0 0)  (vector 1 0 0)  (vector 0 22 11) (vector 1 0 0)  (vector 1 0 0)
;         (vector 0 0 15) (vector 1 0 0)  (vector 1 0 0)  (vector 1 0 0)   (vector 1 0 0)  (vector 1 0 0)
;         (vector 0 0 0)  (vector 0 4 13) (vector 1 0 0)  (vector 1 0 0)   (vector 1 0 0)  (vector 0 10 0)
;         (vector 0 0 18) (vector 1 0 0)  (vector 1 0 0)  (vector 1 0 0)   (vector 1 0 0)  (vector 1 0 0)
;         (vector 0 0 10) (vector 1 0 0)  (vector 1 0 0)  (vector 0 0 14)  (vector 1 0 0)  (vector 1 0 0)))
(define board
    (vector (vector 0 0 0) (vector 0 14 0) (vector 0 29 0) (vector 0 10 0) (vector 0 0 0) (vector 0 0 0) (vector 0 0 0) (vector 0 24 0) (vector 0 16 0) (vector 0 22 0) (vector 0 0 0) (vector 0 0 0) 
    (vector 0 0 23) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 3 0) (vector 0 0 0) (vector 0 12 24) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 24 0) (vector 0 0 0) 
    (vector 0 0 11) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 6 34) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 17 0) 
    (vector 0 0 13) (vector 1 0 0) (vector 1 0 0) (vector 0 39 16) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 9 19) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) 
    (vector 0 0 0) (vector 0 0 16) (vector 1 0 0) (vector 1 0 0) (vector 0 4 3) (vector 1 0 0) (vector 1 0 0) (vector 0 7 29) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) 
    (vector 0 0 0) (vector 0 4 0) (vector 0 7 8) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 10 7) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 10 0) (vector 0 0 0) 
    (vector 0 0 10) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 6 4) (vector 1 0 0) (vector 1 0 0) (vector 0 4 3) (vector 1 0 0) (vector 1 0 0) (vector 0 15 0) 
    (vector 0 0 11) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 4 11) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 4 11) (vector 1 0 0) (vector 1 0 0) 
    (vector 0 0 0) (vector 0 0 16) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 0 11) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) 
    (vector 0 0 0) (vector 0 0 0) (vector 0 0 13) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) (vector 0 0 0) (vector 0 0 0) (vector 0 0 7) (vector 1 0 0) (vector 1 0 0) (vector 1 0 0) )
)

(define solved 0)               ;; Solved board.
(define unsolvable 1)           ;; Unsolvable board.
(define continue 2)             ;; Continue compute branch.

(define black 0)                ;; Black position.
(define white 1)                ;; White position.

(define limit 10)

(define height 10)               ;; Height of board.
(define width 12)                ;; Width of board.

(define last_i (- height 1))    ;; Last possible index on collumn.
(define last_j (- width 1))     ;; Last possible index on line.

;; END OF DEFINES

;; BEGIN AUXILIARES

;; Has the board been solved?
(define (solved? status)
    (= status solved))

;; Position up of pos.
(define (down pos)
    (cons (+ (car pos) 1) (cdr pos)))

;; Position right of pos.
(define (right pos)
    (cons (car pos) (+ (cdr pos) 1)))

;; Position down of pos.
(define (up pos)
    (cons (- (car pos) 1) (cdr pos)))

;; Position left of pos.
(define (left pos)
    (cons (car pos) (- (cdr pos) 1)))

;; Convert 2d position to linear 
(define (index pos)
    (+ (* (car pos) width) (cdr pos)))

;; Last position on collumn?
(define (last_i? pos)
    (= (car pos) last_i))

;; Last position on line?
(define (last_j? pos)
    (= (cdr pos) last_j))

;; Next position on board.
(define (nextPos pos)
    (if (last_j? pos)
        (cons (+ (car pos) 1) 0)
        (cons (car pos) (+ (cdr pos) 1))))

;; Last position on board?
(define (lastPos? pos)
    (and (= (car pos) last_i) (= (cdr pos) last_j)))

;; Last position on board.
(define last_pos (cons last_i last_j))

;; END AUXILIARES

;; BEGIN VECTOR INTERFACE

(define (write! pos val)
    (vector-set! (vector-ref board (index pos)) 1 val))

(define (black? pos)
    (= (vector-ref (vector-ref board (index pos)) 0) black))

(define (white? pos)
    (= (vector-ref (vector-ref board (index pos)) 0) white))

(define (first pos)
    (vector-ref (vector-ref board (index pos)) 1))

(define (second pos)
    (vector-ref (vector-ref board (index pos)) 2))

;; END VECTOR INTERFACE

;; BEGIN KAKURO

;; Check if line sums up to hint.
(define (checkLine pos sum)
    (if (white? pos)
        (checkLine (left pos) (+ sum (first pos)))
        (= sum (second pos))))

;; Check if collumn sums up to hint.
(define (checkCol pos sum)
    (if (white? pos)
        (checkCol (up pos) (+ sum (first pos)))
        (= sum (first pos))))

;; Check if element repeats on given line.
(define (lineRepeats? pos w)
    (cond ((black? pos)  #f)
          ((= (first pos) w) #t)
          (else (lineRepeats? (left pos) w))))

;; Check if element repeats on given collumn.
(define (colRepeats? pos w)
    (cond ((black? pos) #f)
          ((= (first pos) w) #t)
          (else (colRepeats? (up pos) w))))

;; Check if compute branch can continue.
(define (continue? pos w)
    (cond ((lineRepeats? (left pos) w) #f) 
          ((colRepeats? (up pos) w) #f)
          ((and (or (last_j? pos) (and (not (last_j? pos)) (black? (right pos)))) (not (checkLine pos 0))) #f)
          ((and (or (last_i? pos) (and (not (last_i? pos)) (black? (down pos)))) (not (checkCol pos 0))) #f)
          (else #t)))

;; Returns next white position on board.
;; If there isn't one left, returns last_pos
;; instead.
(define (nextWhitePos pos)
    (if (> (car pos) last_i)
        last_pos
        (if (white? pos)
            pos
            (nextWhitePos (nextPos pos)))))

;; Test finish conditions. Calls next position to try.
(define (finished? pos)
    (define nextP (nextWhitePos (nextPos pos)))
    (if (and (lastPos? nextP) (or (last_j? pos) (black? last_pos)))
        solved
        (if (solved? (solve nextP))
            solved
            continue)))

;; Skip impossible board states, also propagate finished state.
(define (work pos w)
    (begin
        (write! pos w)
        (if (continue? pos w)
            (finished? pos)
            continue)))

;; Try one iteration of work.
(define (try pos w)
    (if (= w limit)
        unsolvable
        (if (solved? (work pos w))
            solved
            (try pos (+ w 1)))))

;; Solves Kakuro boards!
(define (solve pos)
    (try pos 1))

;; Print solved board
(define (display-board)
    (define (print-pos pos)
        (if (black? pos)
            (display "*")
            (display (first pos))))
    (define (iter pos)
            (if (= (car pos) height)
                (newline)
                (begin
                    (print-pos pos)
                    (if (last_j? pos)
                        (begin 
                            (newline) (iter (nextPos pos)))
                        (iter (nextPos pos))))))
    (iter (cons 0 0)))

;; ENTRY POINT
(define nex (nextWhitePos(cons 0 0)))

(newline)

;; Solve the board
(if (solved? (solve nex))
    (display-board)
    (display "Unsolvable!"))