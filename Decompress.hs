module Decompress where

import qualified Data.ByteString as Bs
import HuffmanTree as H

decompress :: Bs.ByteString -> Bs.ByteString
