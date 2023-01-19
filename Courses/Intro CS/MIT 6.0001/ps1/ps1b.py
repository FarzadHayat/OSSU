# part B: Saving, with a raise
def main():
    # user inputs
    annual_salary = float(input("Enter your annual salary: "))
    portion_saved = float(input("Enter the percent of your salary to save, as a decimal: "))
    total_cost = float(input("Enter the cost of your dream home: "))
    semi_annual_raise = float(input("Enter the semi-annual raise, as a decimal: "))

    # constants
    ANNUAL_RETURN = 0.04
    PORTION_DOWN_PAYMENT = 0.25

    # other variables
    monthly_salary = annual_salary / 12
    montly_return = ANNUAL_RETURN / 12
    down_payment = total_cost * PORTION_DOWN_PAYMENT
    current_savings = 0
    number_of_months = 0

    # calculations
    while (current_savings < down_payment):
        number_of_months += 1
        current_savings += current_savings * montly_return
        current_savings += monthly_salary * portion_saved
        if (number_of_months % 6 == 0):
            monthly_salary += monthly_salary * semi_annual_raise
    print("Number of months: " + str(number_of_months))

if __name__ == "__main__":
    main()