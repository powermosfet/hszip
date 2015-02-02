module BitString where

data Bit = Zero | One

instance Show Bit where
    show Zero = "0"
    show One  = "1"

type BitString = [ Bit ]

