import collections
import csv
import pprint
import sys
import re
import os

from datetime import datetime

#csv.field_size_limit(sys.maxsize)

src_path = os.path.dirname(os.path.dirname(__file__))

field_id = 'ddd:11'
filtered_newspapers = ["De Graafschap-bode : nieuws- en advertentieblad voor stad- en ambt-Doetinchem, Hummelo en Keppel, Wehl, Zeddam, 's Heerenberg, Ulft, Gendringen, Sillevolde, Terborg, Varsseveld, Dinxperlo, Aalten, Breedevoorde, Lichtenvoorde, Groenlo, Neede, Eibergen, Bor",
                       "De tĳd : dagblad voor Nederland",
                       "De Tijd De Maasbode",
                       ]

dateranges = [("1916-04-01", "1916-06-30"),
              ("1917-01-01", "1917-03-31"),
              ("1919-10-01", "1919-12-31"),
              ("1921-04-01", "1921-06-30"),
              ("1922-11-29", "1922-12-31"),
              ("1923-03-01", "1923-03-31"),
              ("1924-07-01", "1924-08-31"),
              ("1926-09-30", "1926-12-31"),
              ("1930-06-01", "1930-08-31"),
              ("1961-07-01", "1961-12-31"),
              ("1962-01-01", "1962-12-31"),
              ("1963-01-01", "1963-09-30"),
              ("1965-07-01", "1965-07-31"),
              ("1965-10-01", "1965-10-31"),
              ("1966-04-01", "1966-09-30"),
              ("1966-11-01", "1966-11-30"),
              ("1969-02-01", "1969-02-28"),
              ("1969-07-01", "1969-08-31"),
              ("1969-10-01", "1969-12-31"),
              ("1970-01-01", "1987-12-31"),
              ("1989-01-01", "1989-12-31")
              ]

a = 1
dateranges = list(map(lambda dr:
                      tuple(map(lambda x:
                            datetime.strptime(x, "%Y-%m-%d"), dr)),
                      dateranges))


def datefilter(x):
    x = datetime.strptime(x, "%Y-%m-%d")
    for r in dateranges:
        if r[0] <= x and r[1] >= x:
            return True
    return False


def filterrows():
    try:
        new_row = [row [4], row[25], row[28]]
        output.append(new_row)
    except IndexError as e:
        pass

output = []

for filename in os.listdir('.'):
    if os.path.isfile(filename) and filename[-4:] == ".csv":
        with open(filename, 'r', encoding='utf-8') as f:
            reader = csv.reader(f, delimiter='\t', quotechar='"')
            header = next(reader)
            output.append(header)
            next(reader)
            for row in reader:
                if row and datefilter(row[4]) and row[8] == "De Telegraaf":
                    var = re.search('\\b'+field_id, row[3])
                    if bool(var) == False:
                        filterrows()
                elif row and row[8] in filtered_newspapers:
                    var = re.search('\\b'+field_id, row[3])
                    if bool(var) == False:
                        filterrows()
                else:
                    filterrows()


with open('output_filtered.csv', 'w', encoding='utf-8') as outputfile:
    writer = csv.writer(outputfile, delimiter='\t')
    writer.writerows(output)

row_count = sum(1 for row in output) - a

print("Numbers of rows in file: {}".format(row_count))

result = collections.defaultdict(list)

for row in output:
    year = row[0].split("-")[0]
    result[year].append(row)

for i, j in result.items():
    row_count = sum(1 for row in j)
    file_path = "%s%s-%s.csv" % (src_path, i, row_count)
    print(file_path)
    # Source: https://stackoverflow.com/questions/7406102/create-sane-safe-filename-from-any-unsafe-string
    keepcharacters = (' ','.','_')
    file_path = "".join(c for c in file_path if c.isalnum() or c in keepcharacters).rstrip()
    print(file_path)
    with open(file_path, 'w', encoding='utf-8') as fp:
        writer = csv.writer(fp, delimiter=',', quotechar='"')
        writer.writerows(j)
