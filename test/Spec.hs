import Test.Hspec
import Network.Slack.Webhook
import System.Environment (getEnv)

main :: IO ()
main = hspec $ do
  describe "sendMessage" $ do
    it "should succeed" $ do
      x <- getEnv "SLACK_INCOMING_WEBHOOK_URL"
      sendMessage x "This is test from hspec"

