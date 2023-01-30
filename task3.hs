{-
1. Построить бинарное дерево, соответствующее данному
выражению (корень дерева соответствует операции, выполняющейся
последней). Дерево должно выводиться на экран в таком виде, чтобы
была понятна его структура.
2. Реализовать концевой обход дерева (так, чтобы в итоге
получилась обратная польская запись (ОПЗ) выражения).
3. Реализовать вычисление выражения по построенной ОПЗ.
Такая функция описана в книге М.Липовача «Изучай Haskell…» стр.
283-286. В данном примере операцию деления «/» следует выполнять
как целочисленное деление.
-}

data Tree a = EmptyTree | Node a (Tree a) (Tree a)

foo str = printTree (buildTree (words str)) where
--foo str = postfix (words str) [] [] where
  buildTree [] = EmptyTree
  buildTree str = buildTree' (postfix str [] []) []

  buildTree' [] [] = EmptyTree
  buildTree' [] [x] = x
  buildTree' [x] stack = if isOper x
    then Node x (head stack) (head (tail stack))
    else Node x EmptyTree EmptyTree
  buildTree' (x : xs) stack = if isOper x
    then buildTree' xs (Node x (head stack) (head (tail stack)) : tail (tail stack))
    else buildTree' xs (Node x EmptyTree EmptyTree : stack)

  isOper "+" = True
  isOper "-" = True
  isOper "*" = True
  isOper "/" = True
  isOper x = False

  postfix [] [] [] = []
  postfix [] q [] = reverse q
  postfix [] q (x : xs) = postfix [] (x : q) xs
  postfix (x : xs) q []
    | isOper x = postfix xs q [x]
    | otherwise = postfix xs (x : q) []
  postfix [x] q stack = postfix [] (x : q) stack
  postfix (x : xs) q stack
    | not (isOper x) = postfix xs (x : q) stack
    | isLPrior x (head stack) = postfix (x : xs) (head stack : q) (tail stack)
    | otherwise = postfix xs q (x : stack)

  isLPrior "*" "+" = False
  isLPrior "*" "-" = False
  isLPrior "/" "+" = False
  isLPrior "/" "-" = False
  isLPrior a b = True
  
  printTree EmptyTree = ""
  printTree (Node a l r) = "(" ++ printTree l ++ a ++ printTree r ++ ")"

{-

-}