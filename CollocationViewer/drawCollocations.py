import networkx as nx
from scipy.interpolate import interp1d
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

    edgeLabels = nx.get_edge_attributes(graph, 'weight')
    nodeSizes = list(wordCounts.values())
    # Scale up the node size
    scale = interp1d([min(nodeSizes), max(nodeSizes)], [100, 1000])
    nodeSizes = [scale(nodeSize) for nodeSize in nodeSizes]
    print(nodeSizes)

    nx.draw_networkx_nodes(graph, positions, nodelist=graph.nodes(), node_size=nodeSizes)
    nx.draw_networkx_edges(graph, positions, edgelist=graph.edges())
    nx.draw_networkx_labels(graph, positions)
    nx.draw_networkx_edge_labels(graph, positions, edge_labels=edgeLabels)

    plt.axis('off')
    plt.show()
