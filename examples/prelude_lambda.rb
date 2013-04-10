require 'functional'

module PreludeLambdaUsage

  include Functional::Prelude

  Power = ->(p,x) { x**p }.curry
  Square = Power.(2)
  Squares = Map.(Square)
  Sum_Of_Squares1 = Compose.(Sum).(Squares)
  Sum_Of_Squares2 = Sum < Squares
  Sum_Of_Squares = Sum_Of_Squares2

  #Divide = ->(a) { a[0]/a[1] }
  Average1 = After.( Parallel.(Sum).(Length) ).( Divide )
  Average2 = After.( Par.([Sum,Length]) ).( Divide )
  Average3 = After.( [Sum,Length] ).( Divide )
  Average4 = Parallel.(Sum,Length) > Divide
  Average = Average4

  Inc_With = ->(f, n, m) { n + f.(m) }.curry
  Sum_Of1 = ->(f,arr) { Foldl.( Inc_With.(f), 0, arr) }.curry
  Sum_Of2 = ->(f) { ->(arr) { Foldl.( Inc_With.(f), 0, arr) } }
  Sum_Of = Sum_Of1

end
