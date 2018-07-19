module Test.Main where

import Prelude

import Data.Either (isLeft, isRight)
import Data.Maybe (Maybe, isJust, isNothing)
import Effect (Effect)
import Effect.Console (log)
import PuchiTomato as PT
import Simple.JSON as JSON
import Test.Assert (assert)
import Type.Prelude as TP

appleP = TP.SProxy :: TP.SProxy "apple"

type AppleSL = PT.StringLiteral "apple"

appleSL :: AppleSL
appleSL = PT.mkStringLiteral appleP

main :: Effect Unit
main = do
  let (res1 :: JSON.E AppleSL) = JSON.readJSON "\"apple\""
  assert (isRight res1)

  let (res2 :: JSON.E AppleSL) = JSON.readJSON "\"apples\""
  assert (isLeft res2)

  assert (JSON.writeJSON appleSL == "\"apple\"")

  assert (PT.extractString appleSL == "apple")

  assert (show appleSL == "apple")

  let (res4 :: Maybe AppleSL) = PT.parseStringLiteral "apple"
  assert (isJust res4)

  let (res5 :: Maybe AppleSL) = PT.parseStringLiteral "apples"
  assert (isNothing res5)

  log "tests passed."
