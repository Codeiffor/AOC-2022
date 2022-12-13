(defparameter monkeys (make-array '0 :adjustable t :fill-pointer t))

(setf monkey (make-array '7 :initial-element :unset))

(defun update_monkey ()
  (vector-push-extend monkey monkeys)
  (setf monkey (make-array '7 :initial-element :unset)))

(defun parse-list (s)
  (setf l '())
  (loop for n = (position #\, s)
    while n do
      (setf l (cons (parse-integer (substring s 0 n)) l))
      (setf s (substring s (+ n 2)))
      )
  (setf l (cons (parse-integer s) l))
  l)

(defun parse (line c)
  (if (= 0 (mod c 7))
    (setf (aref monkey 0) 0))
  (if (= 1 (mod c 7))
    (setf (aref monkey 1) (parse-list (substring line 18))))
  (if (= 2 (mod c 7))
    (if (and (= 28 (length line)) (string= "old" (substring line 25)) )
      (setf (aref monkey 2) "^")
      (progn
        (setf (aref monkey 2) (substring line 23 24))
        (setf (aref monkey 3) (parse-integer (substring line 25))))))
  (if (= 3 (mod c 7))
    (setf (aref monkey 4) (parse-integer (substring line 21))))
  (if (= 4 (mod c 7))
    (setf (aref monkey 5) (parse-integer (substring line 29))))
  (if (= 5 (mod c 7))
    (setf (aref monkey 6) (parse-integer (substring line 30))))
  (if (= 6 (mod c 7))
    (update_monkey)))

(let ((c 0))
  (with-open-file (stream "input.txt")
    (loop for line = (read-line stream nil)
      while line do
        (parse line c)
        (incf c))))
(update_monkey)

;; main logic

(setf mul 1)
(loop for monkey across monkeys do
  (setf mul (* mul (aref monkey 4))))

(defun simulate_round (divide_by_3)
  (loop for i from 0 and monkey across monkeys do
    (loop for item in (reverse (aref monkey 1)) do
      (setf (aref (aref monkeys i) 0) (+ 1 (aref monkey 0)))
      (if (string= "*" (aref monkey 2)) (setf item (* item (aref monkey 3))))
      (if (string= "+" (aref monkey 2)) (setf item (+ item (aref monkey 3))))
      (if (string= "^" (aref monkey 2)) (setf item (* item item)))
      (if divide_by_3 (setf item (floor item 3)))
      (setf item (mod item mul))
      (if (= (mod item (aref monkey 4)) 0)
        (setf m (aref monkey 5))
        (setf m (aref monkey 6)))
      (setf (aref (aref monkeys m) 1)
        (cons item (aref (aref monkeys m) 1)))
      (setf (aref (aref monkeys i) 1)
        (cdr (reverse (aref monkey 1)))))))

(defun print_max ()
  (setf m1 0)
  (setf m2 0)
  (defun update_max (c)
    (if (> c m1) (progn (setf m2 m1) (setf m1 c))
      (if (> c m2) (setf m2 c))))
  (loop for monkey across monkeys do
    (update_max (aref monkey 0)))
  (print (* m1 m2)))

;; run 1 at a time
;; (loop for i from 1 to 20 do (simulate_round t))
(loop for i from 1 to 10000 do (simulate_round (not t)))

(print_max)
