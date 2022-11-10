# Problem Set 4A
# Name: Farzad Hayatbakhsh
# Start date: 1/11/2022

def get_permutations(sequence):
    '''
    Enumerate all permutations of a given string

    sequence (string): an arbitrary string to permute. Assume that it is a
    non-empty string.  

    You MUST use recursion for this part. Non-recursive solutions will not be
    accepted.

    Returns: a list of all permutations of sequence

    Example:
    >>> get_permutations('abc')
    ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']

    Note: depending on your implementation, you may return the permutations in
    a different order than what is listed here.
    '''
    # if length of sequence is 0 (base case):
    if len(sequence) == 0:
        # return an empty list
        return []
    # if length of sequence is 1 (base case):
    elif len(sequence) == 1:
        # return a singleton list containing the sequence
        return [sequence]
    # else (recursive step):
    else:
        # create an empty list of sequences
        alist = []
        # store the first character in a variable
        first = sequence[0]
        # store the rest of the sequence in a variable
        rest = sequence[1:]
        # loop through the strings returned from permutations of the sequence without the first characters:
        for perm in get_permutations(rest):
            # for each string, loop through the indices
            for i in range(len(perm)+1):
                # add a sequence for inserting the missing character into each position:
                alist.append(perm[:i] + first + perm[i:])
        # return the list of sequences
        return alist
        
        # # alternative solution:
        # alist = []
        # for i in range(len(sequence)):
        #     x = sequence[i]
        #     xs = sequence[:i] + sequence[i+1:]
        #     for p in get_permutations(xs):
        #         alist.append(x + p)
        # return alist

if __name__ == '__main__':
#    #EXAMPLE
    example_input = 'abc'
    print('Input:', example_input)
    print('Expected Output:', ['abc', 'acb', 'bac', 'bca', 'cab', 'cba'])
    print('Actual Output:', get_permutations(example_input))
    
#    # Put three example test cases here (for your sanity, limit your inputs
#    to be three characters or fewer as you will have n! permutations for a 
#    sequence of length n)

    input_1 = 'xxy'
    print('Input:', input_1)
    print('Expected Output:', ['xxy', 'xyx', 'xxy', 'xyx', 'yxx', 'yxx'])
    print('Actual Output:', get_permutations(input_1))

    input_2 = 'ab'
    print('Input:', input_2)
    print('Expected Output:', ['ab', 'ba'])
    print('Actual Output:', get_permutations(input_2))
    
    input_3 = 'x'
    print('Input:', input_3)
    print('Expected Output:', ['x'])
    print('Actual Output:', get_permutations(input_3))

    input_4 = ''
    print('Input:', input_4)
    print('Expected Output:', [])
    print('Actual Output:', get_permutations(input_4))

    pass #delete this line and replace with your code here

