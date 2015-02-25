module BitString where

import qualified Data.ByteString as By
import Data.Word

data Bit = Zero | One
    deriving (Eq, Ord)

instance Show Bit where
    show Zero = "0"
    show One  = "1"

to_byte :: BitString -> Word8
to_byte bits = foldl (\n i -> n*2 + (if bits!!i == One then 1 else 0)) 0 [ 0 .. 7 ]

from_bool :: Bool -> Bit
from_bool True = One
from_bool False = Zero

from_byte :: Word8 -> BitString
from_byte b = reverse $ pad8 $ from_byte' b
    where from_byte' 0 = []
          from_byte' b = (from_bool $ (b `mod` 2) /= 0):(from_byte' $ b `div` 2)

type BitString = [ Bit ]

to_bytestring :: BitString -> By.ByteString
to_bytestring bits = By.pack (to_bytestring' (pad8 bits))
    where to_bytestring' [] = []
          to_bytestring' bits = (to_byte $ take 8 bits):(to_bytestring' $ drop 8 bits)

pad8 :: BitString -> BitString
pad8 bits | (length bits `mod` 8) == 0 = bits
          | otherwise = pad8 $ bits ++ [Zero]
          
