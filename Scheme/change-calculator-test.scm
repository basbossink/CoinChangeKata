;; Copyright 2013 Bas Bossink 
;; <bas.bossink@gmail.com>
;; http://basbossink.github.com/

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
(require-extension change-calculator)
(require-extension test)

(test-begin "change-calculator-test")

(define (euro-coin-set) 
  (list 1 5 10 20 50 100 200))

(test 
  "When there's no change to give it should return the empty list"
  '() 
  (calculate-change (euro-coin-set) 0))

(test-end)
