# переписать ниже примеры из первого часа из видеолекции: 
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции

#Getting Started
println("I'm excited to learn Julia")

my_answer = 42
@show typeof(my_answer)
my_pi = 3.14159
@show typeof(my_pi)
my_name = "Jane"
@show typeof(my_name)

my_answer = my_name
@show typeof(my_answer)

#comment

#=
comment
=#

sum = 3+7
@show sum
difference = 10-3
@show difference
product = 20*5
@show product
quotient = 100/10
@show quotient
power = 10^2
@show power
modulus = 101%2
@show modulus
