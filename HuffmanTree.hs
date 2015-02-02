module HuffmanTree where

import BitString

import Data.Word
import Data.Map
import qualified Data.List as L
import Data.ByteString
import Control.Monad

data Tree = Branch Tree Tree
          | Leaf Word8
          deriving(Eq, Show)

data WeightTree = WeightTree Int Tree
    deriving(Eq, Show)

instance Ord WeightTree where
    (WeightTree a _) <= (WeightTree b _) = a <= b

get_weights :: ByteString -> [ WeightTree ]
get_weights bytes = [ WeightTree  weight (Leaf byte) | (byte, weight) <- toList weightMap ]
    where weightMap = fromListWith (+) [ (c, 1) | c <- unpack bytes ]

build_tree :: [ WeightTree ] -> Tree
build_tree leaves = build [] $ L.sort leaves
    where combine (WeightTree wa a) (WeightTree wb b) = WeightTree (wa + wb) (Branch a b)
          build [WeightTree _ t] [] = t 
          build branches leaves = build ((combine small1 small2):branches'') leaves''
              where smallest [] (b:bs) = (b, [], bs)
                    smallest (a:as) [] = (a, as, [])
                    smallest (a:as) (b:bs) | a < b     = (a, as, b:bs)
                                           | otherwise = (b, a:as, bs)
                    (small1, branches', leaves') = smallest branches leaves
                    (small2, branches'', leaves'') = smallest branches' leaves'
          
get_bitstring :: Tree -> Word8 -> Maybe BitString
get_bitstring (Leaf w) x | w == x = Just []
                         | otherwise = Nothing
get_bitstring (Branch a b) x = (liftM (Zero:) ( get_bitstring a x))
                               `mplus`
                               (liftM (One:) ( get_bitstring b x))
