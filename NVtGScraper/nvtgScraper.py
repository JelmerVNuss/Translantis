#!/usr/bin/env python

"""nvtgScraper.py:
Scrape all the pdf files from www.ntvg.nl
"""


import os
import string
import unicodedata

import requests
import bs4


validFilenameChars = "-_.() {}{}".format(string.ascii_letters, string.digits)


# Where to find the article files.
SEARCH_BOX_URL = ("https://www.ntvg.nl/search/advanced?search=&page=", "&in=full&author_options=0")
ARTICLE_INFO_URL = ("https://www.ntvg.nl/artikelen/", "/artikelinfo")
ARTICLE_INFO_SELECTOR = "#block-system-main > div > div > div > div.field.field-name-field-year.field-type-number-integer.field-label-hidden > div > div"
DOWNLOAD_SELECTOR = "#block-ntvgmod-print > div > div > ul > li.last > a"

# Scrape only these pages.
BEGIN_PAGE = 593
END_PAGE = 31046
ARTICLES_PER_PAGE = 10
START_ARTICLE = "een-meisje-met-rugklachten"

https://www.ntvg.nl/search/advanced?search=&page=593&in=full&author_options=0
https://www.ntvg.nl/artikelen/een-meisje-met-rugklachten/artikelinfo

def removeDisallowedFilenameChars(filename):
    cleanedFilename = str(unicodedata.normalize('NFKD', filename).encode('ASCII', 'ignore'))
    return ''.join(c for c in cleanedFilename[1:] if c in validFilenameChars)


class Song():
    """A Song consists of a title, artist, ranking and score."""
    def __init__(self, title, artist, ranking, score):
        self.title = title
        self.artist = artist
        self.ranking = ranking
        self.score = score

    def __repr__(self):
        return "Song(title: \"{0}\", artist: \"{1}\", ranking: {2}, score: {3})".format(self.title, self.artist, self.ranking, self.score)

    @property
    def label(self):
        """Return the label for this song."""
        label_string = "_".join([str(self.ranking), str(self.title), str(self.artist), str(self.score)])
        return removeDisallowedFilenameChars(label_string.replace(" ", "-"))


def scrapeSongLabels(song_ranking_url, verbose=False):
    """Retrieve the songs and their labels.
    Return the labels as a list of tuples in the format:
        (song title, artist, ranking)

    Succeeds only if the website is online, otherwise returns an error.
    """
    res = checkWebsiteAvailability(song_ranking_url)

    if verbose:
        print("Website successfully requested: {}".format(song_ranking_url))

    labels = []

    if verbose:
        print("Parsing HTML for {} songs...".format(TOP_N))

    soup = bs4.BeautifulSoup(res.text, 'html.parser')

    for i in range(1, TOP_N + 1):
        elemsTitle = soup.select("#chart-list > ol > li:nth-of-type({}) > div.clearfix > div.titlecredit-wrapper.pull-left > a > span.title".format(i))
        title = elemsTitle[0].text

        elemsArtist = soup.select("#chart-list > ol > li:nth-of-type({}) > div.clearfix > div.titlecredit-wrapper.pull-left > a > span.credit".format(i))
        artist = elemsArtist[0].text

        elemsScore = soup.select("#chart-list > ol > li:nth-of-type({}) > div.clearfix > div.titlecredit-wrapper.pull-left > div.title-detail-view-container > div > div.title-stats.row-fluid > div:nth-of-type(3) > strong".format(i))
        score = elemsScore[0].text

        ranking = i

        song = Song(title, artist, ranking, score)
        labels.append(song)

    if verbose:
        print("Done labelling {} songs...".format(TOP_N))

    return labels


def checkWebsiteAvailability(url):
    """Check whether the given website is online.
    Return the request if it succeeds.
    """
    res = requests.get(url)
    res.raise_for_status()

    return res


def getArticleInfo(article_url):
    return articleName, articleId

def getDownloadUrl(article_url):
    pass



def downloadFromUrl(url, file_name):
    # Open in binary mode.
    with open(file_name, "wb") as file:
        response = requests.get(url)
        file.write(response.content)


def downloadFile(article_url, year, path=".", verbose=False):
    """Download the file to the downloads folder."""
    article = getArticleInfo(article_url)
    file_path = path + "/" + year + "/" + article + ".pdf"

    if os.path.isfile(file_path):
        if verbose:
            print("File already exists: {}".format(file_path))
        return
    try:
        os.makedirs(file_path)
    except OSError:
        if not os.path.isdir(file_path):
            raise

    download_url = getDownloadUrl(article_url)
    print("Downloading to: {}".format(file_path))
    downloadFromUrl(download_url, file_path)


if __name__ == "__main__":
    file_path = year
    downloadFromUrl("https://www.ntvg.nl/system/files/publications/1919106010001a.pdf", file_path)
    # for i in range(BEGIN_PAGE, END_PAGE + 1):
    #     for j in range(1, ARTICLES_PER_PAGE + 1):
    #         print("\nWeek {} ({})".format(i, CURRENT_YEAR))
    #         print("------------------")
    #         DATE_PATH = "{}/week-{}".format(CURRENT_YEAR, i)
    #         song_ranking_url = SONG_RANKING_URL + DATE_PATH
    #
    #         print("\nWeek {} ({})".format(i, CURRENT_YEAR))
    #         print("------------------")
    #         for song in week_label:
    #             print(song)
    #             downloadSong(song, date_path="{}-{}/".format(CURRENT_YEAR, i), verbose=True)
    #
    # best_song = labels[0][1][0]
    # query = " ".join([best_song.title, best_song.artist])
    # search_result = youtube_search.find_first(query)
    # print(search_result)
