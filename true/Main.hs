module Main where

import           Protolude

import           Data.Aeson (encode)

import           Common (Success(..))

main :: IO ()
main = putStrLn $ encode $ Success ()
