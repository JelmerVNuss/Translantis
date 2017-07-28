import os
from util import listWithoutItem

ROOT_FOLDER = "AntConc analyse ESB"


def extractWordsOfInterest(rootFolder):
    words = []

    for directory, _, filenames in os.walk(rootFolder):
        directoryWord = extractDirectoryWord(directory)
        words.append(directoryWord)

    # Skip the word of the first folder (probably "ESB").
    words = words[1:]

    return words


def extractDirectoryWord(directory):
    directory = os.path.basename(directory)
    try:
        directoryWord = directory.split(" ")[2].lower()
    except KeyError:
        directoryWord = ""
    return directoryWord


def getFilepaths(rootFolder):
    filepaths = {}

    for directory, _, filenames in os.walk(rootFolder):
        paths = []
        for filename in filenames:
            filepath = os.path.join(directory, filename)
            paths.append(filepath)

        directoryWord = extractDirectoryWord(directory)
        filepaths[directoryWord] = paths

    return filepaths


def getCollocationRelations():
    collocationRelations = {}
    for word in words:
        collocationScores = {}
        for neighbour in listWithoutItem(words, word):
            collocationScore = getCollocationScore()
            collocationScores[neighbour] = collocationScore
        collocationRelations[word] = collocationScores
    return collocationRelations


def getCollocationScore():
    collocationScore = 0.0
    return collocationScore


words = extractWordsOfInterest(ROOT_FOLDER)
filepaths = getFilepaths(ROOT_FOLDER)
print(words)
print(filepaths)
collocationRelations = getCollocationRelations()
print(collocationRelations)

