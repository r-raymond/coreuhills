{-# LANGUAGE DeriveGeneric #-}

module Common
    ( Failure(..)
    , Success(..)
    ) where

import           Protolude

import           Data.Aeson       (FromJSON, ToJSON, object, parseJSON, toJSON,
                                   withObject, (.:), (.=))
import           Data.Aeson.Types (Parser)

import           Control.Monad    (fail)

data Failure
    = Failure
    { errorMsg :: Text
    } deriving Show

data Success a
    = Success
    { payload :: a
    }

instance ToJSON Failure where
    toJSON (Failure error) =
        object [ "result" .= ("failure" :: Text)
               , "errorMsg" .= error
               ]

instance FromJSON Failure where
    parseJSON = withObject "failure" $ \obj -> do
        result <- obj .: "result" :: Parser Text
        if result == "failure"
            then do
                error <- obj .: "errorMsg"
                return (Failure error)
            else fail "Not a failure"

instance (ToJSON a) => (ToJSON (Success a)) where
    toJSON (Success x) =
        object [ "result" .= ("success" :: Text)
               , "payload" .= (toJSON x)
               ]

instance (FromJSON a) => (FromJSON (Success a)) where
    parseJSON = withObject "success" $ \obj -> do
        result <- obj .: "result" :: Parser Text
        if result == "success"
            then do
                content <- obj .: "payload"
                return (Success content)
            else fail "Not a success"
