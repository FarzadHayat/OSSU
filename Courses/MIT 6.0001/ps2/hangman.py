# Problem Set 2, hangman.py
# Name: Farzad Hayatbakhsh
# Start date: 28/10/2022
# Time spent: 

# Hangman Game
# -----------------------------------
# Helper code
# You don't need to understand this helper code,
# but you will have to know how to use the functions
# (so be sure to read the docstrings!)
from logging import warning
import random
import string

WORDLIST_FILENAME = "words.txt"


def load_words():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split()
    print("  ", len(wordlist), "words loaded.")
    return wordlist



def choose_word(wordlist):
    """
    wordlist (list): list of words (strings)
    
    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code

# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = load_words()


def is_word_guessed(secret_word, letters_guessed):
    '''
    secret_word: string, the word the user is guessing; assumes all letters are
      lowercase
    letters_guessed: list (of letters), which letters have been guessed so far;
      assumes that all letters are lowercase
    returns: boolean, True if all the letters of secret_word are in letters_guessed;
      False otherwise
    '''
    guessed = True
    for char in secret_word:
      if char not in letters_guessed:
        guessed = False
    return guessed



def get_guessed_word(secret_word, letters_guessed):
    '''
    secret_word: string, the word the user is guessing
    letters_guessed: list (of letters), which letters have been guessed so far
    returns: string, comprised of letters, underscores (_), and spaces that represents
      which letters in secret_word have been guessed so far.
    '''
    guessed_word = ""
    for char in secret_word:
      if char in letters_guessed:
        guessed_word += char
      else:
        guessed_word += "_ "
    return guessed_word



def get_available_letters(letters_guessed):
    '''
    letters_guessed: list (of letters), which letters have been guessed so far
    returns: string (of letters), comprised of letters that represents which letters have not
      yet been guessed.
    '''
    alphabet = list(string.ascii_lowercase)
    for letter in letters_guessed:
      alphabet.remove(letter)
    return ''.join(alphabet)



def hangman(secret_word, hint=False):
    '''
    secret_word: string, the secret word to guess.
    
    Starts up an interactive game of Hangman.
    
    * At the start of the game, let the user know how many 
      letters the secret_word contains and how many guesses s/he starts with.
      
    * The user should start with 6 guesses

    * Before each round, you should display to the user how many guesses
      s/he has left and the letters that the user has not yet guessed.
    
    * Ask the user to supply one guess per round. Remember to make
      sure that the user puts in a letter!
    
    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computer's word.

    * After each guess, you should display to the user the 
      partially guessed word so far.
    
    Follows the other limitations detailed in the problem write-up.
    '''
    letters_guessed = []
    guesses_left = 6
    warnings_left = 3
    print("Welcome to the game Hangman!")
    print("I am thinking of a word that is {} letters long.".format(len(secret_word)))
    print("You have {} warnings left.".format(warnings_left))
    print_dashed_line()
    while (is_gameover(secret_word, letters_guessed, guesses_left) is False):
      letters_guessed, warnings_left, guesses_left = hangman_one_turn(
        secret_word, letters_guessed, guesses_left, warnings_left, hint)



def hangman_one_turn(secret_word, letters_guessed, guesses_left, warnings_left, hint):
    print("You have {} guesses left.".format(guesses_left))
    print("Available letters: " + get_available_letters(letters_guessed))
    letters_guessed, warnings_left, guesses_left = check_next_guess(
      secret_word, letters_guessed, warnings_left, guesses_left, hint)
    print_dashed_line()
    return letters_guessed, warnings_left, guesses_left



def is_gameover(secret_word, letters_guessed, guesses_left):
    # win
    if (is_word_guessed(secret_word, letters_guessed)):
      print("Congratulations, you won!")
      num_uniques_letters = len(set(secret_word))
      score = guesses_left * num_uniques_letters
      print("Your total score for this game is: " + str(score) + "\n")
      return True
    # lose
    elif (guesses_left <= 0):
      print("Sorry, you ran out of guesses. The word was {}.".format(secret_word) + "\n")
      return True
    # game not over
    else:
      return False
    


def check_next_guess(secret_word, letters_guessed, warnings_left, guesses_left, hint):
    guess = str.lower(input("Please guess a letter: ")).strip()
    message = ""
    # check whether the guess is valid
    if (is_guess_valid(letters_guessed, guess)):
      # check whether the guess was in the secret word or not
      letters_guessed.append(guess)
      if (guess in secret_word):
        message += "Good guess: "
      else:
        if (guess in "aeiou"):
          guesses_left -= 2
        else:
          guesses_left -= 1
        message += "Oops! That letter is not in my word: "
    elif (hint and guess == '*'):
      # show hints
      print("Possible word matches are: ")
      show_possible_matches(get_guessed_word(secret_word, letters_guessed))
    else:
      # error message based on whether the guess was already guessed or invalid for some other reason
      if (guess in letters_guessed):
        message += "Oops! You've already guessed that letter. "
      else:
        message += "Oops! That is not a valid letter. "
      # remove one warning or one guess if no warnings left
      if (warnings_left > 0):
        warnings_left -= 1
        message += "You have {} warnings left: ".format(warnings_left)
      else:
        guesses_left -= 1
        message += "You have no warnings left so you lose one guess: "
    if (message != ""):
      print(message + get_guessed_word(secret_word, letters_guessed))
    return letters_guessed, warnings_left, guesses_left



def is_guess_valid(letters_guessed, guess):
    return str.isalpha(guess) and len(guess) == 1 and guess not in letters_guessed



def print_dashed_line():
    print("------------")



# When you've completed your hangman function, scroll down to the bottom
# of the file and uncomment the first two lines to test
#(hint: you might want to pick your own
# secret_word while you're doing your own testing)


# -----------------------------------



def match_with_gaps(my_word, other_word):
    '''
    my_word: string with _ characters, current guess of secret word
    other_word: string, regular English word
    returns: boolean, True if all the actual letters of my_word match the 
        corresponding letters of other_word, or the letter is the special symbol
        _ , and my_word and other_word are of the same length;
        False otherwise: 
    '''
    # conditions:
    # same characters
    # same word length
    # no hidden characters that have already been guessed
    matching = True
    my_letters = [letter for letter in list(my_word) if letter != ' ']
    other_letters = list(other_word)
    if (len(my_letters) != len(other_letters)):
      matching = False # my_word and other_word are not the same length
    else:
      for i, letter in enumerate(my_letters):
        if letter == '_':
          if other_letters[i] in my_letters:
            matching = False # missing character at index i has already been guessed
        elif letter != other_letters[i]:
          matching = False # mismatching characters at index i
    return matching



def show_possible_matches(my_word):
    '''
    my_word: string with _ characters, current guess of secret word
    returns: nothing, but should print out every word in wordlist that matches my_word
             Keep in mind that in hangman when a letter is guessed, all the positions
             at which that letter occurs in the secret word are revealed.
             Therefore, the hidden letter(_ ) cannot be one of the letters in the word
             that has already been revealed.

    '''
    possible_matches = []
    for word in wordlist:
      if (match_with_gaps(my_word, word)):
        possible_matches.append(word)
    if (len(possible_matches) == 0):
      print("No matches found")
    else:
      print(' '.join(possible_matches))



def hangman_with_hints(secret_word):
    '''
    secret_word: string, the secret word to guess.
    
    Starts up an interactive game of Hangman.
    
    * At the start of the game, let the user know how many 
      letters the secret_word contains and how many guesses s/he starts with.
      
    * The user should start with 6 guesses
    
    * Before each round, you should display to the user how many guesses
      s/he has left and the letters that the user has not yet guessed.
    
    * Ask the user to supply one guess per round. Make sure to check that the user guesses a letter
      
    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computer's word.

    * After each guess, you should display to the user the 
      partially guessed word so far.
      
    * If the guess is the symbol *, print out all words in wordlist that
      matches the current guessed word. 
    
    Follows the other limitations detailed in the problem write-up.
    '''
    hangman(secret_word, True)



# When you've completed your hangman_with_hint function, comment the two similar
# lines above that were used to run the hangman function, and then uncomment
# these two lines and run this file to test!
# Hint: You might want to pick your own secret_word while you're testing.


if __name__ == "__main__":
    # pass
    # hangman('apple')

    # To test part 2, comment out the pass line above and
    # uncomment the following two lines.

    # secret_word = choose_word(wordlist)
    # hangman(secret_word)

###############
    # hangman_with_hints('apple')
    
    # To test part 3 re-comment out the above lines and 
    # uncomment the following two lines. 
    
    secret_word = choose_word(wordlist)
    hangman_with_hints(secret_word)
