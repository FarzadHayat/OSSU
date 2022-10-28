import numpy

def main():
    x = int(input("Enter number x: "))
    y = int(input("Enter number y: "))
    answer1 = x**y
    print("x**y = " + str(answer1))
    print("log(x) = " + str(numpy.log2(x)))

if (__name__ == "__main__"):
    main()