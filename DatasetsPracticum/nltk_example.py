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


# From http://www.nltk.org/book/ch05.html
taggedWords = nltk.pos_tag(words)
print(taggedWords)


import nltk.collocations
import collections

bgm = nltk.collocations.BigramAssocMeasures()
finder = nltk.collocations.BigramCollocationFinder.from_words(taggedWords)
scored = finder.score_ngrams(bgm.likelihood_ratio)

# Filter to contain only NN
scored = [x for x in scored if x[0][0][1] == 'NN']
print(scored)

# Group bigrams by first word in bigram.
prefix_keys = collections.defaultdict(list)
for key, scores in scored:
    prefix_keys[key[0]].append((key[1], scores))

# Sort keyed bigrams by strongest association.
for key in prefix_keys:
    prefix_keys[key].sort(key = lambda x: -x[1])

print(scored)

print('zaterdag', prefix_keys[('zaterdag', 'NN')][:5])
print('president', prefix_keys[('president', 'NN')][:5])
