{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Network.Slack.Webhook (sendMessage) where

import Data.Aeson
import GHC.Generics
import qualified Data.ByteString.Lazy as L
import Network.HTTP.Conduit as C

data Payload = Payload { text :: String } deriving (Show, Generic)
instance FromJSON Payload
instance ToJSON Payload

sendMessage :: String -> String -> IO ()
sendMessage url text = do
  initReq <- parseUrlThrow url
  let payload = Payload text
  let req' = initReq { secure = True, method = "POST" }
  let req = urlEncodedBody [ ("payload", L.toStrict $ encode payload) ] req'
  response <- withManager $ httpLbs req
  L.putStr $ responseBody response

