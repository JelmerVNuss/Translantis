class Topic:
    def __init__(self, id, topics=[]):
        self.id = id
        self.topics = topics

    @property
    def words(self):
        return [topic[1] for topic in self.topics]

    @property
    def percentages(self):
        return [topic[0] for topic in self.topics]

    def addWord(self, word, percentage):
        self.topics.append((percentage, word))
