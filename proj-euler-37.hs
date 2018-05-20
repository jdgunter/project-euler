module Main where

import Data.List
import Data.Numbers.Primes

readInt :: String -> Int
readInt = read

-- starting with the primes [2, 3, 5, 7], we add on a digit to either the left or right depending on
-- the function passed in, and then check whether this new number is still a prime
truncPrimes_ :: ((String, String) -> String) -> [String]
truncPrimes_ f = go ["2", "3", "5", "7"]
  where go tPrimes
          | null newPrimes = tPrimes
          | otherwise = (go newPrimes) ++ tPrimes
          where newPrimes = map show .
                            filter isPrime .
                            map readInt $
                            map f [(x,y) | x <- tPrimes, y <- ["1", "2", "3", "5", "7", "9"]]

truncPrimes :: [Int]
truncPrimes = map readInt $ intersect leftTruncPrimes rightTruncPrimes
  where leftTruncPrimes = truncPrimes_ (\(x,y) -> x ++ y)
        rightTruncPrimes = truncPrimes_ (\(x,y) -> y ++ x)

-- we subtract 17 to remove the sum of [2, 3, 5, 7], as they are not considered truncatable primes
main :: IO ()
main = print . flip (-) 17 $ sum truncPrimes
