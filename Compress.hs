module Compress where 

import Data.ByteString 
import Data.BitString 
import HuffmanTree as H

compress :: ByteString -> ByteString
