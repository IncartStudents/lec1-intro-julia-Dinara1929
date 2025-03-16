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
using Pkg
Pkg.add("Colors")
using Colors
palette = distinguishable_colors(100) #выводит ленту цветов
rand(palette, 3, 3) #выводит палитру 3*3
#------------------
#Plotting
using Plots
x = -3:0.1:3
f(x)=x^2
y=f.(x)
gr()
plot(x,y, label="line")
scatter!(x,y, label="points")
#рисует параболу в большем маштабе
globaltemps = [14.4,14.5,14.8]
nump = [45000,20000,15000]
plot(nump,globaltemps, legend=false)
scatter!(nump,globaltemps, legend=false)
#рисует график температур
xflip!()
#рисует отзераленную версию последнего графика
xlabel!("approximate")
ylabel!("(C)")
title!("global warming")
#подписи
p1=plot(x,x)
p2=plot(x,x.^2)
p3=plot(x,x.^3)
p4=plot(x,x.^4)
plot(p1,p2,p3,p4,layout=(2,2),legend=false)
#рисует 4 графика
#----------------
#Multiple Dispatch
methods(+)
@which 3+3
#+(x::T, y::T) where T<:Union{Int128, Int16, Int32, Int64, Int8, UInt128, UInt16, UInt32, UInt64, UInt8}
#@ Base int.jl:87
@which 3+3.0
#+(x::Number, y::Number)
#@ Base promotion.jl:429
@which 3.0+3.0
#+(x::T, y::T) where T<:Union{Float16, Float32, Float64}
#@ Base float.jl:491
import Base: +
"hello" + "world!"
@which "hello" + "world!"
#MethodError: no method matching invoke +(::String, ::String)
+(x::String,y::String)=string(x,y)
"hello "+"world!"
@which "hello" + "world!"
#"hello world!" +(x::String, y::String)
foo(x,y)=println("duck-type foo!")
foo(x::Int,y::Float64)=println("foo with an int and a flo")
foo(x::Float64,y::Float64)=println("foo with two flo")
foo(x::Int,y::Int)=println("foo with two int")
foo(1,1)
foo(1.,1.)
foo(1,1.)
foo(true,false)
#=
foo with two int
foo with two flo
foo with an int and a flo
duck-type foo!
=#