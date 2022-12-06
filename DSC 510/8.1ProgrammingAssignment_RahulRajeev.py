# DSC 510-T303
# Week 8
# 8.1 Programming Assignment
# Author Rahul Rajeev
# 10/17/2022

# importing string library
import string

# initializing file and dictionary
gba_file = open('gettysburg.txt', 'r')
word_count_dict = {}


# function that checks whether the word in words is in the
# count dictionary, if not, adds it
def add_word(words, dic):
    for word in words:
        if word in dic:
            dic[word] += 1
        else:
            dic[word] = 1


# function that processes line stripping, lowercase,
# and removing punctuation
def process_line(line, dic):
    line = line.rstrip().lower().\
        translate(line.maketrans("", "", string.punctuation))
    words_split = line.split()
    add_word(words_split, dic)


# function to prettify the printed dictionary
def pretty_print(dic):
    print("The length of the dictionary is:", len(dic), 'words.')
    print(f"{'Word':13}{'Frequency'}")
    print(f"{'':=<22}")
    for key, value in sorted(dic.items(),
                             key=lambda item: item[1], reverse=True):
        print('{:16}{}'.format(key, value))


# main function
def main():
    for line in gba_file:
        process_line(line, word_count_dict)
    pretty_print(word_count_dict)


# call to main
if __name__ == "__main__":
    main()

# Change#:1
# Change(s) Made: used lambda key to sort the dictionary
# with keys and frequencies
# Date of Change: 10/17/2022
# Author: Rahul Rajeev
# Change Approved by: Professor Michael Eller
# Date Moved to Production: 10/18/2022
