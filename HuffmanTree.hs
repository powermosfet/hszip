module HuffmanTree where

import BitString

import Data.Word
import Data.Map
import qualified Data.List as L
import Data.ByteString
import Control.Monad

data Tree = Branch Tree Tree
          | Leaf Word8
          | EofLeaf
          deriving(Eq, Show)

data WeightTree = WeightTree Int Tree
    deriving(Eq, Show)

instance Ord WeightTree where
    (WeightTree a _) <= (WeightTree b _) = a <= b

get_weights :: ByteString -> [ WeightTree ]
get_weights bytes = (WeightTree 1 EofLeaf):[ WeightTree  weight (Leaf byte) | (byte, weight) <- toList weightMap ]
    where weightMap = fromListWith (+) [ (c, 1) | c <- unpack bytes ]

build_tree :: ByteString -> Tree
build_tree bytes = build [] $ L.sort $ get_weights bytes
    where combine (WeightTree wa a) (WeightTree wb b) = WeightTree (wa + wb) (Branch a b)
          build [WeightTree _ t] [] = t 
          build branches leaves = build ((combine small1 small2):branches'') leaves''
              where smallest [] (b:bs) = (b, [], bs)
                    smallest (a:as) [] = (a, as, [])
                    smallest (a:as) (b:bs) | a < b     = (a, as, b:bs)
                                           | otherwise = (b, a:as, bs)
                    (small1, branches', leaves') = smallest branches leaves
                    (small2, branches'', leaves'') = smallest branches' leaves'

to_bits :: Tree -> BitString
to_bits Leaf 
          
(!#) :: Tree -> Word8 -> Maybe BitString
(Leaf w) !# x | w == x = Just []
              | otherwise = Nothing
(Branch a b) !# x = (liftM (Zero:) ( a !# x))
                    `mplus`
                    (liftM (One:) ( b !# x))
