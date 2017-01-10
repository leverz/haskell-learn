respondPalindromes contents = unlines 
    (map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") (lines contents))
    where isPalindrome xs = xs == reverse xs

-- point-free版
respondPalindromes' = unlines . map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") . lines
    where isPalindrome xs = xs == reverse xs

main = interact respondPalindromes'