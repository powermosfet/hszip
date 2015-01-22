module HuffmanTree where

import Data.Word
import qualified Data.ByteString as Bs

data Tree = Node Tree Tree
          | Leaf Word8
          deriving(Eq, Show)

data WeightTree = Tree Int
    deriving(Eq, Show, Ord)

-- count::Bs.ByteString->M.Map Word8 Int
-- count = Bs.foldl akk M.empty
--     where akk m c = if c `M.member` m
--         then M.insert c (m M.!c + 1) m
--         else M.insert c 1 m

-- instance Ord HuffmanTree where
--     EmptyTree <= _ = True
--     _ <= EmptyTree = False
--     HuffmanNode n _ _ <= HuffmanNode n' _ _ = n <= n'
--     HuffmanNode n _ _ <= HuffmanLeaf n' _ = n <= n'
--     HuffmanLeaf n _ <= HuffmanNode n' _ _ = n <= n'
--     HuffmanLeaf n _ <= HuffmanLeaf n' _ = n <= n'
-- 
-- combine::HuffmanTree->HuffmanTree->HuffmanTree
-- combine t@(HuffmanNode n _ _) t'@(HuffmanNode n' _ _) = HuffmanNode (n+n') t t'
-- combine t@(HuffmanLeaf n _) t'@(HuffmanNode n' _ _) = HuffmanNode (n+n') t t'
-- combine t@(HuffmanNode n _ _) t'@(HuffmanLeaf n' _) = HuffmanNode (n+n') t t'
-- combine t@(HuffmanLeaf n _) t'@(HuffmanLeaf n' _) = HuffmanNode (n+n') t t'
-- 
-- leafList::M.Map Word8 Int->[HuffmanTree]
-- leafList = M.foldWithKey addLeaf []
--     where addLeaf k a ls = HuffmanLeaf a k : ls
-- 
-- buildTree::[HuffmanTree]->HuffmanTree
-- buildTree [t] = t
-- buildTree (t1:t2:ts) = buildTree (sort ((combine t1 t2):ts))
