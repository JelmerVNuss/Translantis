# Make the NLTK functions available.
import nltk
# Some features are not installed by default and need to be installed manually
# by invoking the following commands via the command line:

# To open a Python session:
#   > python
# Make nltk available:
#   > import nltk
# Start the NLTK downloader:
#   > nltk.download()
# Now a program starts, make sure that under
#   'Corpora', treebank - Penn Treebank Sample
#   'Models', averaged_perceptron_tagger - Averaged Perceptron Tagger
#   'Models', maxent_treebank_pos_tagger - Treebank Part of Speech Tagger (Maximum entropy)
#   'Models', tagset - Help on Tagsets
# is installed, or do so manually.


# ------ Loading corpus --------------------------------------------------------
# From http://www.nltk.org/book/ch02.html 1.9 Loading your own Corpus

from nltk.corpus import PlaintextCorpusReader
corpusRoot = './per_year'
# Put all files in the root folder in a corpus.
wordlists = PlaintextCorpusReader(corpusRoot, '.*')
# Print all file names in the corpus.
print("These filenames are in folder {}".format(corpusRoot))
print(wordlists.fileids())
# Print all the words in this file.
print("\nThese words are in file 2016.txt")
print(wordlists.words('2016.txt'))


# ------ Word frequencies ------------------------------------------------------
# Load the words from this file.
words = wordlists.words('2016.txt')
# Count the word frequencies.
fdist = nltk.FreqDist(words)

# Print the 10 most common words with their frequencies.
print("\nThese are the 10 most common words")
for word, frequency in fdist.most_common(10):
    print(u'{}\t{}'.format(word, frequency))


# ------ Part of speech --------------------------------------------------------
# From http://www.nltk.org/book/ch05.html

# Use the default Penn Treebank tagset.
# A complete overview is available here http://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
# Request help on a tag (definition & examples) with:
print("\nThe tag 'NN' means:")
nltk.help.upenn_tagset('NN')
# Tag the words with parts of speech.
taggedWords = nltk.pos_tag(words)
print("\nThe first 10 words are tagged as:")
print(taggedWords[:10])


# ------ Collocations ----------------------------------------------------------
# From http://www.nltk.org/howto/collocations.html
import nltk.collocations
import collections

bgm = nltk.collocations.BigramAssocMeasures()
finder = nltk.collocations.BigramCollocationFinder.from_words(taggedWords)
scored = finder.score_ngrams(bgm.likelihood_ratio)

# Filter to contain only NN.
scored = [x for x in scored if x[0][0][1] == 'NN']
# Show the first 5 bigrams.
print("\nThe first bigrams found:")
print(scored[:5])

# Group bigrams by first word in bigram.
prefixKeys = collections.defaultdict(list)
for key, scores in scored:
    prefixKeys[key[0]].append((key[1], scores))

# Sort keyed bigrams by strongest association.
for key in prefixKeys:
    prefixKeys[key].sort(key = lambda x: -x[1])

print("\nThe best bigrams ordered by score:")
print(scored[:5])

# Search the collocations for these words where they appear as NN.
print("\nThe collocations found:")
print('zaterdag', prefixKeys[('zaterdag', 'NN')][:5])
print('president', prefixKeys[('president', 'NN')][:5])
