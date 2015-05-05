-- this mosaic explores the way laid out by Robert Atkey in
--  http://bentnib.org/posts/2015-04-19-algebraic-approach-typechecking-and-elaboration.html

{-# LANGUAGE TypeOperators #-}

data Type = A | B | C | Type :-> Type deriving (Eq, Show)

type TypeChecker = [Type] -> Maybe Type

-- a TypeChecker is basically something that maybe has a type in a context
--   (e.g. a Term)

var :: Int -> TypeChecker
var i ctxt = Just $ ctxt !! i

lam :: Type -> TypeChecker -> TypeChecker
lam = undefined

app :: TypeChecker -> TypeChecker -> TypeChecker
app = undefined


data Term = Var Int | Lam Type Term | Term `App` Term deriving Show

typeCheck :: Term -> TypeChecker
typeCheck (Var i) = var i
typeCheck (Lam ty tm) = lam ty $ typeCheck tm
typeCheck (f `App` a) = typeCheck f `app` typeCheck a
