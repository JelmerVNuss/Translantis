import networkx as nx
import matplotlib.pyplot as plt


def drawCollocations(collocationRelations, wordCounts):
    # TODO use wordCounts to set size of nodes
    graph = nx.DiGraph()
    for word1 in collocationRelations.keys():
        for word2 in collocationRelations[word1].keys():
            weight = collocationRelations[word1][word2]
            if weight > 0.0:
                graph.add_edge(word1, word2, weight=weight)

    #positions = nx.circular_layout(graph)
    positions = nx.spring_layout(graph)
    nx.draw(graph, positions, with_labels=True)
    plt.show()
