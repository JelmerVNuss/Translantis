#!/usr/bin/env python
#
#
# Keyword Generator
#
# Copyright (C) 2015 Juliette Lonij, Koninklijke Bibliotheek -
# National Library of the Netherlands
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


import argparse
import codecs
import copy
import gensim
import math
import operator
import os
import pprint
import sys
import time

from plot_topics import plot_stacked_bar
import classes.Corpus as cp
from classes.Topic import Topic
from classes.Distribution import Distribution


YESNO = ("yes", "y", "no", "n")
AFFIRMATION = ("yes", "y")

# Set the default data storage locations.
DOC_FOLDER = "data" + os.sep + "documents"
STOP_FOLDER = "data" + os.sep + "stop_words"
KEYWORDS_FOLDER = "data" + os.sep + "keywords"
TOPIC_DISTRIBUTIONS_FOLDER = "data" + os.sep + "topic_distributions"
DOCUMENT_DISTRIBUTIONS_FOLDER = "data" + os.sep + "document_distributions"


def excludeTopics(topics):
    """Exclude certain topics from a list of topics and return this list.
    Topics are excluded interactively via the console during runtime.
    """
    print("Topics generated:")
    printTopics(topics)
    response = input("Enter topics to exclude, separated by commas: ")
    response = response.replace(" ", "")
    if response == "":
        return topics
    excl_topics = response.split(",")
    for i in range(len(excl_topics)):
        excl_topics[i] = int(excl_topics[i])
    excl_topics.sort(reverse=True)
    for i in excl_topics:
        try:
            excluded = [topic for topic in topics if topic.id == i]
            index = topics.index(excluded[0])
            del topics[index]
        except IndexError:
            print("IndexError: Topic {} is out of range and is not deleted.".format(i))
    return topics


def printTopics(topics):
    """Show the list of topics and their content.
    """
    for topic in topics:
        print("({}): {}".format(topic.id, ' '.join(topic.words)))


def generateKeywords(corpus, dictionary, topics, num_keywords):
    """Generate the keywords given some topics.
    """
    print("Generating keywords...")
    keywords = {}

    # Sum of probabilities for token in all topics
    for topic in topics:
        for token, percentage in topic.content:
            if token in keywords:
                keywords[token] += percentage
            else:
                keywords[token] = percentage

    # Probability for each token multiplied by token frequency
    matrix = gensim.matutils.corpus2csc(corpus)
    for token, percentage in keywords.items():
        for dict_tuple in dictionary.items():
            if dict_tuple[1] == token:
                token_index = dict_tuple[0]
                break
        token_row = matrix.getrow(token_index)
        token_freq = token_row.sum(1).item()
        keywords[token] = percentage * math.log(token_freq)

    # Sort keywords by highest score
    sorted_keywords = sorted(keywords.items(), key=operator.itemgetter(1), reverse=True)

    # Return only requested number of keywords
    sorted_keywords = sorted_keywords[:num_keywords]
    return sorted_keywords


def print_keywords(keywords):
    i = 1
    for k in keywords:
        print("(%i) %s [%s]" % (i, k[0], k[1]))
        i += 1


def export_keywords(keywords):
    filename = int(time.time())
    f = open(KEYWORDS_FOLDER + os.sep + str(filename) + ".txt", "w+")
    keywords = [k[0] for k in keywords]
    f.write("\n".join(keywords) + "\n\n")
    f.write(" ".join(keywords) + "\n\n")
    f.write(" OR ".join(keywords) + "\n")
    f.close()


def exportDistributions(topics, distributions):
    """Create a file in data/topic_distributions containing the percentage
    of topic occurrence per document.
    """
    filename = int(time.time())
    f = open(TOPIC_DISTRIBUTIONS_FOLDER + os.sep + str(filename) + ".csv", "w+")
    f.write("Document")
    for topic in distributions[0].topics:
        f.write(",{}".format(topic))
    f.write("\n")
    for distribution in distributions:
        f.write(str(distributions.index(distribution)))
        for percentage in distribution.percentages:
            f.write(",{0:.5f}".format(percentage))
        f.write("\n")
    f.close()

def exportDocuments(topics, distributions):
    filename = int(time.time())
    f = open(DOCUMENT_DISTRIBUTIONS_FOLDER + os.sep + str(filename) + ".csv", "w+")
    f.write("Topic")
    for distribution in distributions:
        f.write(",{}".format(distribution.filename))
    f.write("\n")
    for topic in distributions[0].topics:
        f.write(str(topic.id))
        for percentage in topic.percentages:
            f.write(",{0:.5f}".format(percentage))
        f.write("\n")
    f.close()


def findDocumentName(corpus, documentID):
    """Retrieve the document name from the corpus document list.
    """
    return corpus.doclist[documentID].filename

def findTopics(mallet_path, c, corpus, dictionary, num_topics, num_words, excludedTopics=[]):
    """Return the topics found in the non-excluded documents.
    Default to using the Gensim LDA, unless a Mallet LDA application is installed
    and the execution path is given.
    """
    if mallet_path:
        print("Generating model with Mallet LDA ...")
        lda = gensim.models.wrappers.LdaMallet(mallet_path, corpus=corpus, id2word=dictionary, num_topics=num_topics)
        topics = lda.show_topics(num_topics=num_topics, num_words=num_words, formatted=False)
        while any(i in topics for i in excludedTopics):
            num_topics += 1
            topics = lda.show_topics(num_topics=num_topics, num_words=num_words, formatted=False)
            topics = [x for x in topics if x not in excludedTopics]
        distributions = [dist for dist in lda.load_document_topics()]
        distributions = [Distribution(findDocumentName(c, i), distributions[i][1]) for i in range(len(distributions))]
    else:
        print("Generating model with Gensim LDA ...")
        lda = gensim.models.LdaModel(corpus, id2word=dictionary, num_topics=num_topics, alpha='auto', chunksize=1, eval_every=1)
        gensim_topics = [t[1] for t in lda.show_topics(num_topics=num_topics, num_words=num_words, formatted=False)]
        topics = [Topic(id=gensim_topics.index(gTopic), content=[(word, percentage) for word, percentage in gTopic]) for gTopic in gensim_topics]
        while any(i in topics for i in excludedTopics):
            num_topics += 1
            lda = gensim.models.LdaModel(corpus, id2word=dictionary, num_topics=num_topics, alpha='auto', chunksize=1, eval_every=1)
            gensim_topics = [t[1] for t in lda.show_topics(num_topics=num_topics, num_words=num_words, formatted=False)]
            topics = [Topic(id=gensim_topics.index(gTopic), content=[(word, percentage) for word, percentage in gTopic]) for gTopic in gensim_topics]
            topics = [x for x in topics if x not in excludedTopics]
        distributions = []
        matrix = gensim.matutils.corpus2csc(corpus)
        for i in range(matrix.get_shape()[1]):
            bow = gensim.matutils.scipy2sparse(matrix.getcol(i).transpose())
            distributions.append(lda.get_document_topics(bow, 0))
        newDistributions = []
        for distribution in distributions:
            content = [([topic for topic in topics if topic.id == topicID][0], percentage) for topicID, percentage in distribution]
            newDistribution = Distribution(filename=findDocumentName(c, distributions.index(distribution)), content=content)
            newDistributions.append(newDistribution)
        distributions = newDistributions

    allTopics = list(topics)
    topics = excludeTopics(topics)
    excludedTopics.append([topic for topic in allTopics if topic not in topics])

    return topics, distributions, excludedTopics


def createExceptionFilesList(distributions, excludedTopics, removeDocumentsPercentage):
    """Create a new list of documents that contain only excluded topics, or
    excluded topics above the acceptable percentage.
    """
    exceptFiles = set()
    for distribution in distributions:
        if not distribution.filename in exceptFiles:
            for topic in distribution.topics:
                print(topic)
                if topic.words in excludedTopics and topic.percentage >= removeDocumentsPercentage:
                    exceptFiles.add(distribution.filename)
    exceptFiles = list(exceptFiles)
    return exceptFiles


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", required=False, help="the number of topics")
    parser.add_argument("-w", required=False, help="the number of words per topic")
    parser.add_argument("-k", required=False, help="the number of keywords")
    parser.add_argument("-d", required=False, help="document length")
    parser.add_argument("-m", required=False, help="Mallet path")
    parser.add_argument("-a", required=False, action='store_true', help="remove non-alphabetic words")
    parser.add_argument("-u", required=False, action='store_true', help="remove unique words")
    parser.add_argument("-b", required=False, help="minimum amount of occurrences")
    parser.add_argument("-n", required=False, help="maximum amount of occurrences")
    args = parser.parse_args()

    num_topics = vars(args)["t"]
    if not num_topics:
        num_topics = 10
    else:
        num_topics = int(num_topics)

    num_words = vars(args)["w"]
    if not num_words:
        num_words = 10
    else:
        num_words = int(num_words)

    num_keywords = vars(args)["k"]
    if not num_keywords:
        num_keywords = 10
    else:
        num_keywords = int(num_keywords)

    doc_length = vars(args)["d"]
    if not doc_length:
        doc_length = 0
    else:
        doc_length = int(doc_length)

    mallet_path = vars(args)["m"]

    removeNonAlphabetic = vars(args)["a"]
    if not removeNonAlphabetic:
        removeNonAlphabetic = False
    else:
        removeNonAlphabetic = True

    removeUnique = vars(args)["u"]
    if not removeUnique:
        removeUnique = False
    else:
        removeUnique = True

    no_below = vars(args)["b"]
    if not no_below:
        no_below = 2
    else:
        no_below = int(no_below)
    no_above = vars(args)["n"]
    if not no_above:
        no_above = 0.95
    else:
        no_above = float(no_above)

    global c
    global corpus, dictionary

    topics = []
    distributions = []
    excludedTopics = []

    # None of the documents get removed unless the document contains only the topic.
    removeDocumentsPercentage = 1.0

    # Find topics and distributions until no more topics/documents are excluded.
    isFinishedInput = None
    while not isFinishedInput in AFFIRMATION:
        exceptFiles = createExceptionFilesList(distributions, excludedTopics, removeDocumentsPercentage)
        c = cp.Corpus(DOC_FOLDER, STOP_FOLDER, doc_length,
                      removeNonAlphabetic=removeNonAlphabetic, removeUnique=removeUnique,
                      exceptFiles=exceptFiles,
                      no_below=no_below, no_above=no_above)
        corpus, dictionary = c.load()

        topics, distributions, excludedTopics = findTopics(mallet_path, c, corpus, dictionary,
                                                           num_topics, num_words,
                                                           excludedTopics=[])

        if len(excludedTopics) > 0:
            removeDocuments = input("Do you want to exclude the documents containing these topics? (Type [Y]es or [N]o)\n").strip().lower()
            if removeDocuments in AFFIRMATION:
                removeDocumentsPercentage = float(input("Above which percentage of topic should the document be removed? (Enter the percentage in decimals)\n").strip().lower())
            else:
                isFinishedInput = AFFIRMATION[0]
        else:
            isFinishedInput = AFFIRMATION[0]

    # Generate and output the keywords found.
    keywords = generateKeywords(corpus, dictionary, topics, num_keywords)
    print("Keywords generated:")
    print_keywords(keywords)

    # Interactively save the keywords found.
    saveKeywords = None
    while saveKeywords not in YESNO:
        saveKeywords = input("Do you want to save the keywords? (Type [Y]es or [N]o)\n").strip().lower()
    if saveKeywords in AFFIRMATION:
        export_keywords(keywords)
        print("Keywords saved.")

    # Interactively save the topic distributions.
    saveDistributions = None
    while saveDistributions not in YESNO:
        saveDistributions = input("Do you want to save the topic distributions? (Type [Y]es or [N]o)\n").strip().lower()
    if saveDistributions in AFFIRMATION:
        exportDistributions(topics, distributions)
        exportDocuments(topics, distributions)
        print("Topic distributions saved.")

    # Interactively plot the topic distributions.
    plotDistributions = None
    while plotDistributions not in YESNO:
        plotDistributions = input("Do you want to plot the topic distributions? (Type [Y]es or [N]o)\n").strip().lower()
    if plotDistributions in AFFIRMATION:
        print("Plotting distributions...")
        plot_stacked_bar(distributions)


if __name__ == "__main__":
    main()
