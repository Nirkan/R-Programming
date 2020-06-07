# Vectors


# Logical

vtr1 = c(TRUE, FALSE)

# Numerical

vtr2 = c(15, 85.674941, 9999999)

# Integer

vtr3 = c(35L, 58L, 146L)

vtr4 = c(58.465L)


vtr5 = c(TRUE, 35L, 3.14)

vtr6 = c("Hello", FALSE, 65L)



# Matrix 

mtr  = matrix(c(5:29), 5, 5)


# Array

arr = array(c(1:9), dim = c(3,3,4,2))


# List

vtr7 = c(5.678, 32, 95, 31.6)

vtr8 = c("hello", "world", "R")

mylist = list(vtr7, vtr8, vtr1)   # List shows all the units of a vector seperately


# DataFrame

vtr9 = c(1:5)

vtr10  = c("Neel", "Nitin", "Jonas", "Sebastian", "Dirk")

vtr11 = c(15, 25, 65, 145, 74)

data.frame(vtr9, vtr10, vtr11)


data.frame(airquality)


# Arithematic Operators

print(6+9.87)

print(6/3.0)

print(6%%4)    # Modular division gives remainder

print(2^8)

print(22%/%7)  # Floor division, gets rounded off to 3 instead of 3.1428..



# Relational Operators

var = 25

var1 = 60

print(var > var1)    # gives FALSE

print(var != var1)   # gives TRUE


# Assignment Operators

value1 = c(TRUE, FALSE, TRUE, FALSE)

value2 = c(FALSE, TRUE, TRUE, FALSE)

print(value1 & value2)  # prints TRUE when value matches

print(value1 | value2)  # prints TRUE if one value is TRUE

print(value1 || value2)  # print TRUE if any of the value are same.

print(value1 && value2) # if atleast one element in value1 & value2 is not same returns FALSE

print(!value1)  # TRUE becomes FALSE and FALSE becomes TRUE.


### Conditional statement

# If statement

var1 = 25

var2 = 35

if ((var1 + var2) > 50) {
  
  print("Value is greater than 50")
}


# Else if statement

if ((var1+var2)>75){
  print("value is greater than 100")
  
}else if ((var1+var2)>75){
  
  print("value is greater than 75")
  
}else if ((var1+var2)>65){
  
  print("value is greater than 65")

}else {
  
  print("value is greater than 50")         # Else statement
  
}



# Switch Case Statement

switch('?',
       '1' = print("Monday"),
       '2' = print("Tuesday"),
       '3' = print("Wednesday"),
       '4' = print("Thrusday"),
       '5' = print("Friday"),
       '6' = print("Saturday"),
       '7' = print("Sunday"),
       print("Invalid Input")
       )




### Loops in R

# repeat loop

var1 = 5

repeat{
  print(var1)
  var1 = var1 + 2
  if (var1 > 21){
    break
  }
}


# while loop

var2 = 3

while(var2 < 21){
  print(var2)
  var2 = var2 +2
}


# for loop

for (x in 1:25){
  print(x)
}



## String in R

str1 <- 'Hello world, R'
print(str1)

str2 <- "Hello there, R"
print(str2)


# concatination

str3 <- paste(str1, str2)

str3

# count characters

nchar(str3)

# convert to upper case

str4 = toupper(str1)

str5 = tolower(str2)

print(str4)
print(str5)


# Extracting the substring

str6 = substr(str3, 5,16)

print(str6)



### Functions

# Fibonacci series

fibo <- function(a){
  var1 = 0
  var2 = 1
  print(var1)
  print(var2)
  for (x in 1:a){
    var3 = var1 + var2
    print(var3)
    var1 = var2
    var2 = var3
  }
}


fibo(7)

fibo(11)
