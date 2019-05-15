-- This file is part of Quipper. Copyright (C) 2011-2016. Please see the
-- file COPYRIGHT for a list of authors, copyright holders, licensing,
-- and other details. All rights reserved.
-- 
-- ======================================================================

import Quipper

and_gate :: (Qubit, Qubit) -> Circ (Qubit)
and_gate (a, b) = do
  c <- qinit False
  qnot_at c `controlled` [a, b]
  return c

and_list :: [Qubit] -> Circ Qubit
and_list [] = do
  c <- qinit True
  return c
and_list [q] = do
  return q
and_list (q:t) = do
  d <- and_list t
  e <- and_gate (d, q)
  return e

main = print_generic Preview and_list (replicate 10 qubit)
