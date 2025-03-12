# переписать ниже примеры из первого часа из видеолекции: 
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции
#=
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
#----------
#Strings
s1 = "I am a string"
s2 = """I am also a string"""
@show s1
@show s2

#=
s0 = "Here, we get an "error" because it's ambiguous where this string"
@show s0
выдаст ошибку
=#
s00 = """Look, Mom, no "errors"!!!"""
@show s00

@show typeof('s')
#=
s000 = 'We will get an error here'
@show s000
выдаст ошибку
=#

name = "Jane"
num_fingers = 10
num_toes = 10
println("Hello, my name is $name")
println("I have $num_fingers fingers and $num_toes toes. That is $(num_fingers+num_toes) digits in all")

@show string("How many cats ", "are too many cats?")
@show string("I don't know, but ", 10, " too few")

s3 = "How many cats "
s4 = "are too many cats?"
@show s3*s4
println("$s3$s4")
#-----------
#Data structures
###Dictionaries
myphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-2302")
println(myphonebook)
myphonebook["Kramer"] = "555-FILK"
println(myphonebook)
println(myphonebook["Kramer"])
pop!(myphonebook, "Kramer")
println(myphonebook)
#println(myphonebook[1]) - выдаст ошибку
###Tuples
myfavoriteanimales = ("penguins", "cats", "dogs")
println(myfavoriteanimales)
println(myfavoriteanimales[1])
#myfavoriteanimales[1] = "otters" - выдаст ошибку
###Arrays
myfriends = ["Ted", "Robyn", "Lily"]
println(myfriends)
fibonacci = [1, 1, 2, 3, 5, 8, 13]
println(fibonacci)
mix = [1, 2, 3.0, "hi"]
println(mix)
println(myfriends[3])
println(myfriends)
myfriends[3] = "Baby Bop"
println(myfriends)
push!(fibonacci, 21)
println(fibonacci)
pop!(fibonacci)
println(fibonacci)
favorites = [["chocolate", "eggs"], ["cats", "dogs"]]
println(favorites)
numbers = [[1,2], [3, 4], [5, 6]]
println(numbers)
@show rand(4, 3)
@show rand(4, 3, 2)
#-------------
#Loops
n=0
while n < 10
    global n += 1
    println(n)
end

myfriends = ["Ted", "Robyn", "Lily"]
i=1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi $friend, it's great to see you")
    global i += 1
end

for n in 1:10
    println(n)
end

for n = 1:10
    println(n)
end

myfriends = ["Ted", "Robyn", "Lily"]
for friend in myfriends
    println("Hi $friend, it's great to see you")
end

m, n = 5, 5
A = zeros(m, n)
for i in 1:m
    for j in 1:n
        global A[i,j]=i+j 
    end
end
println(A)

B = zeros(m, n)
for i in 1:m, j in 1:n
    global B[i,j]=i+j 
end
println(B)

C = [i/j for i in 1:m, j in 1:n]
println(C)
#--------------
#Conditionals
x = 3
y = 90
if x > y 
    println("$x is larger than $y")
elseif y > x 
    println("$y is larger than $x")
else 
    println("$x and $y are equal")
end

if x > y 
    @show x
else
    @show y
end 

(x>y) ? x : y 

@show (x > y) && println("$x is larger than $y")
@show (x < y) && println("$y is larger than $x")
#-----------------
#Functions and broadcasting
function sayhi(name)
    println("Hi $name, it's great to see you")
end

function f(x)
    x^2
end

sayhi("C-3PO")
@show f(42)

sayhi2(name) = println("Hi $name, it's great to see you")
f2(x) = x^2
sayhi2("R2D2")
@show f2(42)

sayhi3 = name -> println("Hi $name, it's great to see you")
f3 = x -> x^2
sayhi3("Chewbacca")
@show f3(42)

sayhi(55595472)
A = rand(3, 3)
@show A 
@show f(A)

v = rand(3)
#f(v) - программа не завершит работу
#-----------------------
#Basic linear algebra
A = rand(1:4,3,3)
B = A
C = copy(A)
[ B C]
A[1]=17
[B C]
x=ones(3)
b=A*x 
Asym = A + A'
Apd = A'A
A\b 
v = [3, 5, 2]
sort!(v)
@show v
#-----------------
#Packages
=#
methods(+)
@which (3.0+3.0)
using Plots
x = 1:10; y = rand(10); # These are the plotting data
plot(x,y, label="my label")
