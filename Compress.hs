module Compress where 

import qualified Data.ByteString as Bs
import HuffmanTree as H

compress :: Bs.ByteString -> Bs.ByteString
