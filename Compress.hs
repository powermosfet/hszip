module Compress where 

import HuffmanTree
import qualified BitString as Bi
import qualified Data.List as L

import Data.ByteString 

compress :: ByteString -> ByteString
compress input = Bi.to_bytestring $
                     (to_bits tree)  ++
                     (encode tree input)
    where tree = build_tree input
          encode tree input = L.foldl (++) [] $ L.map (tree !#) input
