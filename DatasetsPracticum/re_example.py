# Information on how to use regular expressions with Python:
#   https://www.debuggex.com/cheatsheet/regex/python

# Visual aids provided here:
#   http://regexr.com/


# ---------- New Document Starts -----------------------------------------------
# Step 1:
# Recognise that each document starts with a structured line such as:
#   54 of 200 DOCUMENTS
# Create a matching expression:
newDocumentExpression = r"54 of 200 DOCUMENTS"

# Step 2:
# Generalise the changing patterns:
#   [2-digit number] of [3-digit number] DOCUMENTS
newDocumentExpression = r"\d\d of \d\d\d DOCUMENTS"

# Step 3:
# Generalise underlying structure of the patterns:
#   [number] of [maximum_number] DOCUMENTS
# Where number and maximum_number are both sequences of at least 1 digit.
newDocumentExpression = r"\d+ of \d+ DOCUMENTS"

# Step 3:
# Remove any remaining faults:
# The above expression will match:
#   54 of 200 DOCUMENTS
# But also:
#   4 of 200 DOCUMENTS
# Word boundaries are needed to disallow parts of numbers.
# Only digit sequences preceded and followed by a word boundary
# (comma, dot, space, etc) #are included.
newDocumentExpression = r"\b\d+\b of \b\d+\b DOCUMENTS"


# ---------- Find Date ---------------------------------------------------------
# Step 1:
# Recognise that each date has a pattern:
#   [day] [month] [year]
# where day is a 1-digit or 2-digit number,
# month is a written out version of the month,
# year is a 4-digit number.
dateExpression = r"\d\d* MONTH \d\d\d\d""

# Step 2:
# Add in months using the OR-operator.
# Create a regular expression for each month, and combine this into:
#   (reJanuary|reFebruary|...|reDecember)
MONTHS = ["januari", "februari", "maart", "april", "mei", "juni", "juli", "augustus", "september", "oktober", "november", "december"]
for month in MONTHS:
    reMonth.append(r"\d\d* {} \d\d\d\d".format(month))
dateExpression = "(" + '|'.join(reMonth) + ")"
