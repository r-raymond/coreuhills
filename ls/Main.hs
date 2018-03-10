module Main where

import           Protolude

import           Data.Aeson       (encode)
import           Data.List        (isPrefixOf)
import           Data.Text.IO     (getContents)
import           System.Directory (getDirectoryContents)

import           Types

hidden :: FilePath -> Bool
hidden p = "." `isPrefixOf` p

main :: IO ()
main = do
    --input <- getContents
    --return getContents
    dc <- getDirectoryContents "."
    let d1 = filter (not . hidden) dc
        d2 = sort d1
    let paths = fmap (\p -> Path p Nothing Nothing Nothing Nothing Nothing) d2
    putStrLn $ encode paths

