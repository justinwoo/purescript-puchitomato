module PuchiTomato where

import Prelude

import Control.Monad.Except (throwError)
import Data.Maybe (Maybe(..))
import Foreign as F
import Simple.JSON as JSON
import Type.Prelude as TP
import Unsafe.Coerce (unsafeCoerce)

-- | A string literal type, where the runtime representation is a String that is the same as the Symbol parameter
-- | Equivalent to `reflectSymbol (SProxy :: SProxy sym)`
data StringLiteral (sym :: Symbol)

-- | Make a String Literal by using a SProxy
mkStringLiteral :: forall sym. TP.IsSymbol sym => TP.SProxy sym -> StringLiteral sym
mkStringLiteral p = unsafeCoerce (TP.reflectSymbol p)

-- | Extract the string value out of the String Literal type
extractString :: forall sym. StringLiteral sym -> String
extractString = unsafeCoerce

instance showStringLiteral :: Show (StringLiteral sym) where
  show = unsafeCoerce

instance readForeignStringLiteral ::
  ( TP.IsSymbol sym
  ) => JSON.ReadForeign (StringLiteral sym) where
  readImpl f = do
    str <- F.readString f
    if str == sym
       then pure (unsafeCoerce str :: StringLiteral sym)
       else throwError <<< pure $ F.TypeMismatch "String" ("(StringLiteral " <> sym <> ")")
    where
      sym = TP.reflectSymbol (TP.SProxy :: TP.SProxy sym)

instance writeForeignStringLiteral :: JSON.WriteForeign (StringLiteral sym) where
  writeImpl = unsafeCoerce

parseStringLiteral :: forall sym. TP.IsSymbol sym => String -> Maybe (StringLiteral sym)
parseStringLiteral str = do
  if str == sym
     then Just (unsafeCoerce str :: StringLiteral sym)
     else Nothing
  where
    sym = TP.reflectSymbol (TP.SProxy :: TP.SProxy sym)
