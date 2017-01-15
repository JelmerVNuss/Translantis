import os
import sys
import re


DOCUMENTS_FOLDER = "./documents"


class Date:
    def __init__(self, day, month, year):
        self.day = day
        self.month = month
        self.year = year

    def __repr__(self):
        return "{} {} {}".format(self.day, self.month, self.year)

    def isValid(self):
        return self.day != -1 and self.month != -1 and self.year != -1

class Document:
    def __init__(self, title, date, body):
        self.title = title
        self.date = date
        self.body = body

    def __repr__(self):
        MAX_LENGTH = 100
        body = self.body if len(self.body) < MAX_LENGTH else self.body[:MAX_LENGTH]
        return "{}, {}: {}".format(self.title, self.date, body)


lines = []
with open('dataset.txt', 'r') as f:
    lines = f.read()

# newDocumentExpression matches text of the form: "123 of 200 DOCUMENTS".
# \d matches digits [0-9].
newDocumentExpression = r"\b\d+\b of \d\d\d DOCUMENTS"

# Split the document in several documents based on the newDocumentExpression.
# Skip the first element (index 0) as it contains all text BEFORE the first document.
# Example:
#     Text before Article
#     1 of 200 DOCUMENTS
#     Title of Article
#     Body of Article
documents = re.split(newDocumentExpression, lines)[1:]
# Check if all documents are found.
# The length (amount) of list of documents should equal the amount of documents.
print("The amount of documents found is: {}".format(len(documents)))


documents = [document.strip() for document in documents]


if not os.path.exists(DOCUMENTS_FOLDER):
    os.makedirs(DOCUMENTS_FOLDER)

for document in documents:
    index = documents.index(document) + 1
    with open('{}/{}.txt'.format(DOCUMENTS_FOLDER, index), 'w+') as writeFile:
        writeFile.write(document)


documentSplit = documents[0].split('\n')
documentSplit = list(filter(None, documentSplit))

lengthItem = next((s for s in documentSplit if 'LENGTH:' in s), None)
lengthIndex = documentSplit.index(lengthItem)
# The text is stored in the strings one after the one that says LENGTH: xxx woorden
text = ' '.join(documentSplit[lengthIndex+1:])


MONTHS_DUTCH = ["januari", "februari", "maart", "april", "mei", "juni", "juli", "augustus", "september", "oktober", "november", "december"]
MONTHS_ENGLISH = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
MONTHS_DUTCH_CAPITAL = [month.capitalize() for month in MONTHS_DUTCH]
MONTHS_ENGLISH_CAPITAL = [month.capitalize() for month in MONTHS_ENGLISH]


MONTHS = list(set(MONTHS_DUTCH + MONTHS_DUTCH_CAPITAL + MONTHS_ENGLISH + MONTHS_ENGLISH_CAPITAL))

reMonth = []
for month in MONTHS:
    reMonth.append(r"\d\d* {} \d\d\d\d".format(month))
dateExpression = "(" + '|'.join(reMonth) + ")"

#print(dateExpression)

distributionDates = []
for document in documents:
    allDates = re.findall(dateExpression, document)
    # Select the first date in the article and assume it is the distribution date.
    try:
        distributionDate = allDates[0]
    except IndexError:
        distributionDate = ""
    distributionDates.append(distributionDate)

#print(distributionDates)


def createDate(dateString):
    """A dateString is of the following format:
        dd month yyyy
    Return a Date that has a selectable day, month and year.
    """
    try:
        dateStringSplit = dateString.split(" ")
        return Date(dateStringSplit[0], dateStringSplit[1], dateStringSplit[2])
    except IndexError:
        return Date(-1, -1, -1)

#TODO insert title
documents = [Document("", createDate(distributionDates[documents.index(document)]), document) for document in documents]
documents = [document for document in documents if document.date.isValid()]


perYearRoot = 'per_year'
if not os.path.exists(perYearRoot):
    os.makedirs(perYearRoot)

for document in documents:
    with open("{}/{}.txt".format(perYearRoot, document.date.year), "a+") as outputFile:
        outputFile.write(document.title + "\n\n")
        outputFile.write(document.body + "\n\n\n")
