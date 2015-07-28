-- |
-- Module      :  Text.MegaParsec.Text
-- Copyright   :  © 2011 Antoine Latter, © 2015 MegaParsec contributors
-- License     :  BSD3
--
-- Maintainer  :  Mark Karpov <markkarpov@opmbx.org>
-- Stability   :  provisional
-- Portability :  portable
--
-- Convenience definitions for working with 'Text.Text'.

module Text.MegaParsec.Text
    ( Parser
    , GenParser
    , parseFromFile )
where

import Text.MegaParsec.Error
import Text.MegaParsec.Prim
import qualified Data.Text as T
import qualified Data.Text.IO as T

type Parser       = Parsec T.Text ()
type GenParser st = Parsec T.Text st

-- | @parseFromFile p filePath@ runs a lazy text parser @p@ on the
-- input read from @filePath@ using 'Prelude.readFile'. Returns either a
-- 'ParseError' ('Left') or a value of type @a@ ('Right').
--
-- @
--  main = do
--    result <- parseFromFile numbers "digits.txt"
--    case result of
--      Left err  -> print err
--      Right xs  -> print (sum xs)
-- @

parseFromFile :: Parser a -> String -> IO (Either ParseError a)
parseFromFile p fname = runP p () fname <$> T.readFile fname
