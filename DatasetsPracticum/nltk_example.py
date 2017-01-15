import nltk


# From http://www.nltk.org/book/ch02.html 1.9 Loading your own Corpus
from nltk.corpus import PlaintextCorpusReader
corpus_root = './per_year'
wordlists = PlaintextCorpusReader(corpus_root, '.*')
# Print all file names in the corpus.
print(wordlists.fileids())
# Print all the words in this file.
print(wordlists.words('2016.txt'))


words = wordlists.words('2016.txt')
fdist = nltk.FreqDist(words)

for word, frequency in fdist.most_common(50):
    print(u'{}\t{}'.format(word, frequency))
