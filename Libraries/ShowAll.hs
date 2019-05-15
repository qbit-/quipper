-- This file is part of Quipper. Copyright (C) 2011-2016. Please see the
-- file COPYRIGHT for a list of authors, copyright holders, licensing,
-- and other details. All rights reserved.
-- 
-- ======================================================================

{-# LANGUAGE FlexibleInstances #-}


-- | This module extends the 'show' function to be able to convert any
-- term to a string, even if its type is not an instance of the 'Show'
-- type class. This is useful, e.g., for generating debugging output,
-- where one does not necessarily want to provide 'Show' instances for
-- every auxiliary data structure that needs debugging.
-- 
-- Functions are shown as \"fun\", and everything else is shown as
-- \"term\".

module Libraries.ShowAll where

-- * Documentation

-- $ We provide a catch-all 'Show' instance using the GHC language
-- option \"OverlappingInstances\". Since instance declarations don't
-- generate any exported symbols, the documentation is empty. Please
-- see the source code.

instance {-# OVERLAPPABLE #-} Show (a -> b) where
  show x = "fun"

instance {-# OVERLAPPABLE #-} Show s where
  show x = "term"
