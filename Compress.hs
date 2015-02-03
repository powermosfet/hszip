module Compress where 

import qualified HuffmanTree as Hf
import qualified BitString as Bits
import qualified Base7 as B7

import Data.ByteString 

compress :: ByteString -> ByteString
compress input = Bits.to_bytestring $
                     (Hf.to_bits tree)      ++
                     (B7.encode $ len input) ++
                     (encode tree input)
    where tree = Hf.build_tree input
