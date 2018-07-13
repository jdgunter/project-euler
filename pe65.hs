import Data.List
import Data.Ratio

newtype ContinuedFraction = ContinuedFraction { coefs :: [Integer] }

integralPart :: ContinuedFraction -> Integer
integralPart = head . coefs

fractionalPart :: ContinuedFraction -> ContinuedFraction
fractionalPart = ContinuedFraction . tail . coefs

computeConvergent :: ContinuedFraction -> Int -> Rational
computeConvergent cf 1     = toRational $ integralPart cf
computeConvergent cf index
    | index > 0 = (toRational $ integralPart cf) + (recip $ computeConvergent (fractionalPart cf) (index - 1))
    | otherwise = error "Convergent index must be greater than 0"  

e :: ContinuedFraction
e = ContinuedFraction $ 2 : (concat $ transpose [ones, twok, ones])
    where ones = iterate id 1
          twok = iterate (+2) 2

sumDigits :: Integer -> Integer
sumDigits 0 = 0
sumDigits n = (n `mod` 10) + sumDigits (n `div` 10)

main :: IO ()
main = print . sumDigits . numerator $ computeConvergent e 100