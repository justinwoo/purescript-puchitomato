# Purescript-PuchiTomato

A small module for a string literal type that guarantees a `String` value the same as its `Symbol` parameter.

![](https://i.imgur.com/NkDWYEv.jpg)

## Usage

```purs
appleP = TP.SProxy :: TP.SProxy "apple"

type AppleSL = PT.StringLiteral "apple"

appleSL :: AppleSL
appleSL = PT.mkStringLiteral appleP

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
```

See the [API Docs](https://pursuit.purescript.org/packages/purescript-puchitomato/) or the [tests](test/Main.purs) for usage.
