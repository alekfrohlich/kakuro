;; BEGIN DEFINES

;; Kakuro board
(define board ...)

(define solved 0)
(define unsolvable 1)
(define continue 2)

(define black 0)
(define white 1)

;; END OF DEFINES

;; BEGIN AUXILIARES

(define (solved? status)
    (= status solved))

;;
(define last_pos (cons last_i last_j))

;;
(define (lastPos? pos)
    (and (= (car pos) last_i) (= (cdr pos) last_j))

;; END AUXILIARES

;; BEGIN VECTOR INTERFACE

(define (write! pos val)
    (vector-set! (vector-ref board (index pos)) 1 val))

;; END VECTOR INTERFACE

;; BEGIN KAKURO

;; Check if line sums up to hint.
(define (checkLine pos sum)
    (if (white? pos)
        (checkLine (left pos) (+ sum (first pos))
        (= sum (second pos))))

;; Check if collumn sums up to hint.
(define (checkCol pos sum)
    (if (white? pos)
        (checkCol (up pos) (+ sum (first pos))
        (= sum (second pos))))

;; Check if element repeats on given line.
(define (lineRepeats? pos w)
    (cond ((black? pos) #f)
          ((= (first pos) w) #t)
          (else (lineRepeats (left pos) w))))

;; Check if element repeats on given collumn.
(define (colRepeats? pos w)
    (cond ((black? pos) #f)
          ((= (first pos) w) #t)
          (else (colRepeats (up pos) w))))

;; FIX ME!
(define (continue? pos board w)
    (if (or (lineRepeats? (POS) board w) (colRepeats? (POS) board w))
        #f
        (if (or () ()))))

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
    (if (and (lastPos? nextP) (or (last_i? pos) (black? pos)))
        solved
        (if (solved? (solve nextP))
            solved
            continue)))

;; Skip impossible board states, also propagate finished state.
(define (work pos w)
    (write! pos w)
    (if (continue? pos w)
        (finished? pos)
        continue)

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

;; ENTRY POINT
(define nex (nextWhitePos(cons 0 0)))

;; Solve the board
(if (solved? (solve nex board))
    (display board) (newline)
    (display "Unsolvable!") (newline))