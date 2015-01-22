import System.Environment
import qualified Data.ByteString as Bs
import Compress as C
import Decompress as D

data Option = Decompress

parse_args args = p [] args
    where p opts ("-d":args) = p Decompress:opts args
          p opts [] = opts

main = do
    args <- getArgs
    let opts = parse_args args
    if Decompress `elem` opts
        then Bs.interact D.decompress
        else Bs.interact C.compress
