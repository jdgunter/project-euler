import System.IO
import Control.Monad
import qualified Data.Vector.Unboxed as V

triangulate :: V.Vector Int -> [V.Vector Int]
triangulate xs = go xs 0 1
  where
    go xs index length
      | index + length == V.length xs = [V.slice index length xs]
      | otherwise = (V.slice index length xs) : go xs (index + length) (length + 1)

findMaxPath :: [V.Vector Int] -> Int
findMaxPath (v:[]) = V.maximum v
findMaxPath (u:v:vs) =
  let left = V.zipWith (+) (V.snoc u 0) v
      right = V.zipWith (+) (V.cons 0 u) v
  in findMaxPath $ (V.zipWith max left right) : vs

main :: IO ()
main = print . findMaxPath . triangulate . V.fromList . map readInt . words =<< readFile "triangle2.txt"
  where
    readInt = read :: String -> Int
