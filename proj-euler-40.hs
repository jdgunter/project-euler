splitIntoDigits :: Integer -> [Integer]
splitIntoDigits = reverse . map (`mod` 10) . takeWhile (> 0) . iterate (`div` 10)

chDigits :: [Integer] -> Integer -> [Integer] -> Integer -> [Integer]
chDigits [] _ _ _ = []
chDigits (i:is) currNum (d:[]) currIndex 
  | i == currIndex = d : chDigits is (succ currNum) (splitIntoDigits $ succ currNum) (succ currIndex)
  | otherwise      = chDigits (i:is) (succ currNum) (splitIntoDigits $ succ currNum) (succ currIndex)
chDigits (i:is) currNum (d:ds) currIndex 
  | i == currIndex = d : chDigits is currNum ds (succ currIndex)
  | otherwise      = chDigits (i:is) currNum ds (succ currIndex)

main :: IO ()
main = do
  putStrLn . show . product $ chDigits [1,10,100,1000,10000,100000,1000000] 0 [0] 0
