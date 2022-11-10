# Problem Set 4C
# Name: Farzad Hayatbakhsh
# Start date: 1/11/2022

import string
from turtle import circle
from ps4a import get_permutations

### HELPER CODE ###
def load_words(file_name):
    '''
    file_name (string): the name of the file containing 
    the list of words to load    
    
    Returns: a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    '''
    
    print("Loading word list from file...")
    # inFile: file
    inFile = open(file_name, 'r')
    # wordlist: list of strings
    wordlist = []
    for line in inFile:
        wordlist.extend([word.lower() for word in line.split(' ')])
    print("  ", len(wordlist), "words loaded.")
    return wordlist

def is_word(word_list, word):
    '''
    Determines if word is a valid word, ignoring
    capitalization and punctuation

    word_list (list): list of words in the dictionary.
    word (string): a possible word.
    
    Returns: True if word is in word_list, False otherwise

    Example:
    >>> is_word(word_list, 'bat') returns
    True
    >>> is_word(word_list, 'asdf') returns
    False
    '''
    word = word.lower()
    word = word.strip(" !@#$%^&*()-_+={}[]|\:;'<>?,./\"")
    return word in word_list


### END HELPER CODE ###

WORDLIST_FILENAME = 'words.txt'

# you may find these constants helpful
VOWELS_LOWER = 'aeiou'
VOWELS_UPPER = 'AEIOU'
CONSONANTS_LOWER = 'bcdfghjklmnpqrstvwxyz'
CONSONANTS_UPPER = 'BCDFGHJKLMNPQRSTVWXYZ'

class SubMessage(object):
    def __init__(self, text):
        '''
        Initializes a SubMessage object
                
        text (string): the message's text

        A SubMessage object has two attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
        '''
        self.message_text = text
        self.valid_words = load_words(WORDLIST_FILENAME)
    
    def get_message_text(self):
        '''
        Used to safely access self.message_text outside of the class
        
        Returns: self.message_text
        '''
        return self.message_text

    def get_valid_words(self):
        '''
        Used to safely access a copy of self.valid_words outside of the class.
        This helps you avoid accidentally mutating class attributes.
        
        Returns: a COPY of self.valid_words
        '''
        return self.valid_words.copy()
                
    def build_transpose_dict(self, vowels_permutation):
        '''
        vowels_permutation (string): a string containing a permutation of vowels (a, e, i, o, u)
        
        Creates a dictionary that can be used to apply a cipher to a letter.
        The dictionary maps every uppercase and lowercase letter to an
        uppercase and lowercase letter, respectively. Vowels are shuffled 
        according to vowels_permutation. The first letter in vowels_permutation 
        corresponds to a, the second to e, and so on in the order a, e, i, o, u.
        The consonants remain the same. The dictionary should have 52 
        keys of all the uppercase letters and all the lowercase letters.

        Example: When input "eaiuo":
        Mapping is a->e, e->a, i->i, o->u, u->o
        and "Hello World!" maps to "Hallu Wurld!"

        Returns: a dictionary mapping a letter (string) to 
                 another letter (string). 
        '''
        # create empty transpose dictionary
        t_dict = dict()
        # concatenate the vowel permutations along with the uppercase versions
        perms = vowels_permutation + vowels_permutation.upper()
        # loop the concatenation of the lowercase and uppercase vowels
        for i,vowel in enumerate(VOWELS_LOWER + VOWELS_UPPER):
            # add the permutation mapping to the dictionary
            t_dict[vowel] = perms[i]
        # loop the lowercase and uppercase consonants
        for letter in (CONSONANTS_LOWER + CONSONANTS_UPPER):
            # add the mapping to the dictionary (no permutation)
            t_dict[letter] = letter
        # return the dictionary
        return t_dict
    
    def apply_transpose(self, transpose_dict):
        '''
        transpose_dict (dict): a transpose dictionary
        
        Returns: an encrypted version of the message text, based 
        on the dictionary
        '''
        new_message = ''
        for char in self.message_text:
            if char in transpose_dict:
                new_message += transpose_dict[char]
            else:
                new_message += char
        return new_message
        
class EncryptedSubMessage(SubMessage):
    def __init__(self, text):
        '''
        Initializes an EncryptedSubMessage object

        text (string): the encrypted message text

        An EncryptedSubMessage object inherits from SubMessage and has two attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
        '''
        SubMessage.__init__(self, text)

    def decrypt_message(self):
        '''
        Attempt to decrypt the encrypted message 
        
        Idea is to go through each permutation of the vowels and test it
        on the encrypted message. For each permutation, check how many
        words in the decrypted text are valid English words, and return
        the decrypted message with the most English words.
        
        If no good permutations are found (i.e. no permutations result in 
        at least 1 valid word), return the original string. If there are
        multiple permutations that yield the maximum number of words, return any
        one of them.

        Returns: the best decrypted message    
        
        Hint: use your function from Part 4A
        '''
        # create empty dictionary used to map the perm string to the number of real words in the decryption
        perm_dict = dict()
        # use the function in ps4a.py to create a list of the permutations for the vowels (aeiou)
        perm_list = get_permutations('aeiou')
        # loop through the permutations list:
        for perm in perm_list:
            # create variable real words and set it to 0
            num_words = 0
            # build the transpose dictionary
            t_dict = self.build_transpose_dict(perm)
            # get a decrypted message by encrypting the message text using the transpose dictionary
            decrypted_message = self.apply_transpose(t_dict)
            # loop through the words in the decrypted message
            for word in decrypted_message.split():
                # if the word is a real word
                if is_word(self.get_valid_words(), word):
                    # add one to real words
                    num_words += 1
            # add key to the dictionary mapping from the perm string to number of real words
            perm_dict[perm] = num_words
        # if the best permutation has one or more real words
        if max(perm_dict.values()) > 0:
            # find the perm in the dictionary with the largest number of real words
            best_perm = max(perm_dict, key=perm_dict.get)
            # build the transpose dictionary
            t_dict = self.build_transpose_dict(best_perm)
            # get the decrypted message by using the best permutation
            new_message = self.apply_transpose(t_dict)
            # return the shift value and the decrypted message in a tuple
            return new_message
        # else (the best permutation didn't have one or more real words)
        else:
            # return the original message
            return self.get_message_text()
    

if __name__ == '__main__':

    # Example test case
    message = SubMessage("Hello World!")
    permutation = "eaiuo"
    enc_dict = message.build_transpose_dict(permutation)
    print("Original message:", message.get_message_text(), "Permutation:", permutation)
    print("Expected encryption:", "Hallu Wurld!")
    print("Actual encryption:", message.apply_transpose(enc_dict))
    enc_message = EncryptedSubMessage(message.apply_transpose(enc_dict))
    print("Decrypted message:", enc_message.decrypt_message())
    
    print('-'*20)

    # My test cases
    my_message = SubMessage('The brown fox jumped over the lazy dog.')
    my_perm = 'eioua'
    my_dict = my_message.build_transpose_dict(my_perm)
    print("Original message:", my_message.get_message_text(), "Permutation:", my_perm)
    print("Expected encryption:", "Thi bruwn fux jampid uvir thi lezy dug.")
    print("Actual encryption:", my_message.apply_transpose(my_dict))
    encrypted_message = EncryptedSubMessage(my_message.apply_transpose(my_dict))
    print("Decrypted message:", encrypted_message.decrypt_message())
    
    print('-'*20)

    other_message = EncryptedSubMessage('Holle thoro, Gonoril Koneba!')
    print("Decrypted message:", other_message.decrypt_message())

    print('-'*20)

    original_message = EncryptedSubMessage("aeiou")
    print("Decrypted message:", original_message.decrypt_message())
