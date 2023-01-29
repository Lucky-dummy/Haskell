{-
Булева функция задана вектором (то есть списком, состоящим из 0 и 1).
Определить, является ли функция самодвойственной.
-}

foo [] = False
foo lst = lst == map (\x -> if x == 0 then 1 else 0) (reverse lst)

{-
  [0, 1] -> True
  [0, 0] -> False
  [1, 1] -> False
  [0, 1, 1, 1] -> False
  [0, 1, 1, 0] -> False
  [0, 1, 0, 1] -> True
-}