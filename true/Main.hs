module Main where

import Protolude

import Data.Aeson (encode)

import Common

main :: IO ()
main = putStrLn $ encode (Success ())
