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
import gensim
import math
import operator
import os
import pprint
import sys
import time

import classes.Corpus as cp


YESNO = ("yes", "y", "no", "n")
AFFIRMATION = ("yes", "y")

# Set the default data storage locations.
DOC_FOLDER = "data" + os.sep + "documents"
STOP_FOLDER = "data" + os.sep + "stop_words"
KEYWORDS_FOLDER = "data" + os.sep + "keywords"


# Generate keywords
def generate_keywords(tfidf_scores, num_keywords):
    print("Generating keywords...")
    keywords = {}

    # Sum of scores for token in all documents
    for doc in tfidf_scores:
        for tuple in doc:
            key = tuple[0]
            score = tuple[1]
            if key in keywords:
                keywords[key] += score
            else:
                keywords[key] = score

    # Sort keywords by highest score
    sorted_keywords = sorted(keywords.items(), key=operator.itemgetter(1), reverse=True)

    # Return only requested number of keywords
    sorted_keywords = sorted_keywords[:num_keywords]
    return sorted_keywords


def print_keywords(keywords, dictionary):
    i = 1
    for k in keywords:
        print("(%i) %s [%s]" % (i, dictionary.get(k[0]), k[1]))
        i += 1


def export_keywords(keywords, dictionary):
    filename = int(time.time())
    f = open(KEYWORDS_FOLDER + os.sep + str(filename) + ".txt", "w+")
    keywords = [dictionary.get(k[0]) for k in keywords]
    f.write("\n".join(keywords) + "\n\n")
    f.write(" ".join(keywords) + "\n\n")
    f.write(" OR ".join(keywords) + "\n")
    f.close()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-k", required=False, help="the number of keywords")
    parser.add_argument("-d", required=False, help="document length")
    parser.add_argument("-a", required=False, help="remove non-alphabetic words")
    parser.add_argument("-u", required=False, help="remove unique words")
    parser.add_argument("-b", required=False, help="minimum amount of occurrences")
    parser.add_argument("-n", required=False, help="maximum amount of occurrences")
    args = parser.parse_args()

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


    c = cp.Corpus(DOC_FOLDER, STOP_FOLDER, doc_length,
                  removeNonAlphabetic=removeNonAlphabetic, removeUnique=removeUnique,
                  exceptFiles=[],
                  no_below=no_below, no_above=no_above)
    corpus, dictionary = c.load()

    tfidf = gensim.models.TfidfModel(corpus)
    tfidf_scores = tfidf[corpus]

    keywords = generate_keywords(tfidf_scores, num_keywords)
    print("Keywords generated:")
    print_keywords(keywords, dictionary)

    saveKeywords = None
    while saveKeywords not in YESNO:
        saveKeywords = input("Do you want to save the keywords? (Type [Y]es or [N]o)\n").strip().lower()
    if saveKeywords in AFFIRMATION:
        export_keywords(keywords, dictionary)
        print("Keywords saved.")


if __name__ == "__main__":
    main()
