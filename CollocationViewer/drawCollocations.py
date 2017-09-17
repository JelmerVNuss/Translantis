import networkx as nx
from scipy.interpolate import interp1d
import matplotlib.pyplot as plt


def drawCollocations(collocationRelations, wordCounts):
    plt.clf()
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

    # Source: https://stackoverflow.com/questions/11946005/label-nodes-outside-with-minimum-overlap-with-other-nodes-edges-in-networkx
    # Please note, the code below uses the original idea of re-calculating a dictionary of adjusted label positions per node.
    label_ratio = 1.0 / 8.0
    labelPositions = {}
    # For each node in the Graph
    for node in graph.nodes():
        # Get the node's position from the layout
        x, y = positions[node]
        # Get the node's neighbourhood
        N = graph[node]
        # Find the centroid of the neighbourhood. The centroid is the average of the Neighbourhood's node's x and y coordinates respectively.
        # Please note: This could be optimised further
        cx = sum(map(lambda x: positions[x][0], N)) / len(positions)
        cy = sum(map(lambda x: positions[x][1], N)) / len(positions)
        # Get the centroid's 'direction' or 'slope'. That is, the direction TOWARDS the centroid FROM node.
        slopeY = (y - cy)
        slopeX = (x - cx)
        # Position the label at some distance along this line. Here, the label is positioned at about 1/8th of the distance.
        labelPositions[node] = (x + slopeX * label_ratio, y + slopeY * label_ratio)

    nx.draw_networkx_nodes(graph, positions, nodelist=graph.nodes(), node_size=nodeSizes, with_labels=False)
    nx.draw_networkx_edges(graph, positions, edgelist=graph.edges())
    nx.draw_networkx_labels(graph, labelPositions)
    nx.draw_networkx_edge_labels(graph, positions, edge_labels=edgeLabels)

    plt.axis('off')
    plot_margin = 0.10
    x0, x1, y0, y1 = plt.axis()
    plt.axis((x0 - (x1 * plot_margin),
              x1 + (x1 * plot_margin),
              y0 - (y1 * plot_margin),
              y1 + (y1 * plot_margin)))
    plt.show()
