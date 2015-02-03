module Base7 where

import qualified BitString as B

encode :: Int -> B.BitString
encode n = enc n ++ [B.One,B.One,B.One]
    where b = [ [B.Zero,B.Zero,B.Zero], [B.Zero,B.Zero,B.One], [B.Zero,B.One,B.Zero], [B.Zero,B.One,B.One],
                [B.One,B.Zero,B.Zero], [B.One,B.Zero,B.One], [B.One,B.One,B.Zero] ]
          enc n | n < 7     = b!!n
                | otherwise = (enc (n`div`7)) ++ (b!!(n`mod`7))
