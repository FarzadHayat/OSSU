# part C: Finding the right amount to save away

def savings_36(start_salary, portion_saved):
    # savings after 36 months
    savings = 0
    salary = start_salary
    savings_rate = portion_saved / 10000
    for month in range(36):
        if (month % 6 == 0 and month > 0):
            salary += salary * SEMI_ANNUAL_RAISE
        savings += savings * ANNUAL_RETURN / 12
        savings += salary * savings_rate / 12
    return savings

def bisearch_one_step(savings, lower, upper, portion_saved, steps):
    # new search bounds
    new_lower = lower
    new_upper = upper
    if (savings < DOWN_PAYMENT):
        new_lower = portion_saved
    else:
        new_upper = portion_saved
    new_portion_saved = (new_lower + new_upper) // 2
    new_steps = steps + 1
    return new_lower, new_upper, new_portion_saved, new_steps

def bisearch(salary):
    # find optimal saving rate using bisection search
    lower, upper, portion_saved, steps = 0, 10000, 5000, 1
    while (True):
        savings = savings_36(salary, portion_saved)
        if (abs(savings - DOWN_PAYMENT) <= EPSILON):
            return portion_saved, steps
        lower, upper, portion_saved, steps = bisearch_one_step(savings, lower, upper, portion_saved, steps)

def optimal_saving_rate(salary):
    # edge case if saving enough for down payment is not possible
    maximum_savings = savings_36(salary, 10000)
    if (maximum_savings < DOWN_PAYMENT):
        print("It is not possible to pay the down payment in three years.")
    else:
        # bisearch
        portion_saved, steps = bisearch(salary)
        savings_rate = portion_saved / 10000

        # output
        print("Best savings rate: " + str(savings_rate))
        print("Steps in bisection search: " + str(steps))

def tests():
    assert (4411, 12) == bisearch(150000)
    assert (2206, 9) == bisearch(300000)

if __name__ == "__main__":
    # constants
    EPSILON = 100
    ANNUAL_RETURN = 0.04
    SEMI_ANNUAL_RAISE = 0.07
    PORTION_DOWN_PAYMENT = 0.25
    TOTAL_COST = 10**6
    DOWN_PAYMENT = TOTAL_COST * PORTION_DOWN_PAYMENT
    
    # input
    salary = float(input("Enter your annual salary: "))

    # testing
    tests()

    #calculations
    optimal_saving_rate(salary)