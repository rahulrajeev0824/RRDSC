# DSC 510-T303
# Week 9
# 9.1 Programming Assignment
# Author Rahul Rajeev
# 10/28/2022

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
    line = line.rstrip().lower(). \
        translate(line.maketrans("", "", string.punctuation))
    words_split = line.split()
    add_word(words_split, dic)


# function to prettify the printed dictionary
def process_file(dic, file):
    with open(file, 'w') as rf:
        rf.write('Text: gettysburg.txt\n'
                 f'The length of the dictionary '
                 f'is: {len(dic)} words\n'
                 f"{'Word':13}{'Frequency'}\n"
                 f"{'':=<22}\n")
        for key, value in sorted(dic.items(),
                                 key=lambda item: item[1],
                                 reverse=True):
            rf.write(f'{key:13}{value}\n')


# main function
def main():
    for line in gba_file:
        process_line(line, word_count_dict)
    result_file = str(input('Name your file here: ')).rstrip() \
                  + '.txt'
    process_file(word_count_dict, result_file)
    print("Please check your directory to check the file!")


# call to main
if __name__ == "__main__":
    main()

# Change#:1
# Change(s) Made: converted print statements
# into saving a txt file instead
# Date of Change: 10/28/2022
# Author: Rahul Rajeev
# Change Approved by: Professor Michael Eller
# Date Moved to Production: 10/28/2022
