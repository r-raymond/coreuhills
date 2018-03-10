{-# LANGUAGE DeriveGeneric #-}

module Types
    ( Path(..)
    )
    where

import           Protolude  hiding (group)

import           Data.Aeson

data Path
    = Path
    { path        :: FilePath
    , owner       :: Maybe Text
    , group       :: Maybe Text
    , permissions :: Maybe Text
    , size        :: Maybe Integer
    , lastChange  :: Maybe Text
    }

instance ToJSON Path where
    toJSON p = object $ [ "path" .= path p ]
        <> case (owner p) of
               Just value -> [ "owner" .= value ]
               Nothing    -> []
        <> case (group p) of
               Just value -> [ "group" .= value ]
               Nothing    -> []
        <> case (permissions p) of
               Just value -> [ "permissions" .= value ]
               Nothing    -> []
        <> case (size p) of
               Just value -> [ "size" .= value ]
               Nothing    -> []
        <> case (lastChange p) of
               Just value -> [ "lastChange" .= value ]
               Nothing    -> []

instance FromJSON Path where
    parseJSON = withObject "path" $ \obj -> do
        a <- obj .: "path"
        b <- obj .:? "owner"
        c <- obj .:? "group"
        d <- obj .:? "permissions"
        e <- obj .:? "size"
        f <- obj .:? "lastChange"
        return $ Path a b c d e f
