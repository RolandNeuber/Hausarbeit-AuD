import math
import random
import matplotlib.pyplot as plt
import networkx as nx

type Node = Node

class Node:
    """Knotenklasse, die den Index und die Position eines Knotens speichert."""
    def __init__(self: Node, index: int, x: float, y: float) -> Node:
        self.index: int = index
        self.x: float = x
        self.y: float = y
    
    def __repr__(self):
        return str(self.__class__.__name__) + "(" + str(vars(self)).strip("{}") + ")"

type Connection = Connection

class Connection:
    """Kantenklasse, die den Start, das Ende und die Kapazität der Verbindung im Netzwerk speichert."""
    def __init__(self: Connection, start_node: int, end_node: int, capacity: int):
        self.start_node: int = start_node
        self.end_node: int = end_node
        self.capacity: int = capacity
    
    def __repr__(self):
        return str(self.__class__.__name__) + "(" + str(vars(self)).strip("{}") + ")"

def read_position_file() -> list[Node]:
    """Liest die Positionen und Indices der Knoten aus der \"FNWNodePos.txt\" aus.
    Aus den Daten wird eine Liste von Knoten erzeugt."""
    # Einlesen der FNWNodePos.txt
    # u x_u y_u
    with open("src/FNWNodePos.txt", "r") as data_file:
        nodes: list[Node] = []
        for line in data_file.readlines():
            args = line.split()
            nodes.append(Node(int(args[0]), float(args[1]), float(args[2])))
    return nodes

def read_capacity_file() -> tuple[int, list[Connection], int]:
    """Liest die Kapazitäten von einem zu einem anderen Knoten aus der \"FNWNodePos.txt\" aus.
    Aus den Daten werden die Indices für Quelle und Senke und eine Liste der Kapazitäten erzeugt."""
    # Einlesen der dataFNW4.txt
    # u_i u_j c(u_i, u_j)
    with open("src/dataFNW4.txt", "r") as data_file:
        length = int(data_file.readline()) # Anzahl der Knoten
        
        connections: list[Connection] = []
        for line in data_file.readlines():
            args = line.split()
            connections.append(Connection(int(args[0]), int(args[1]), int(args[2])))
        source_index = 0 # Quelle
        drain_index = length - 1 # Senke

        return (source_index, connections, drain_index)

def calculate_capacity(
        source_partition: set[int], 
        drain_partition: set[int], 
        connections: list[Connection]
    ):
    """Berechnet die Kapazität zwischen zwei Partitionen anhand der gegebenen Verbindungen."""
    total_capacity = 0
    for connection in connections:
        if connection.start_node in source_partition \
        and connection.end_node in drain_partition:
            total_capacity += connection.capacity

    return total_capacity

def show_network(nodes: list[Node], connections: list[Connection], final_source_set: set[int]):
    """Zeigt das Netzwerk mit Hilfe von NetworkX an. 
    Grüne Knoten sind teil der Partition, die die Quelle beinhaltet, rote gehören zur anderen Partition."""
    graph = nx.DiGraph()
    graph.add_edges_from([(connection.start_node, connection.end_node) for connection in connections])
    plt.figure(figsize=(5, 5))
    pos = { node.index: (node.x, node.y) for node in nodes }
    node_colors = ["green" if node.index in final_source_set else "red" for node in nodes]
    edge_labels = { (connection.start_node, connection.end_node): connection.capacity for connection in connections }
    nx.draw(graph, pos, with_labels=True, node_color=node_colors, edge_color='gray', node_size=200, arrows=True)
    nx.draw_networkx_edge_labels(graph, pos, edge_labels=edge_labels, font_color='black', font_size=12, rotate=False, )
    plt.show()

if __name__ == "__main__":
    nodes = read_position_file()
    source_index, connections, drain_index = read_capacity_file()
    source = [node for node in nodes if node.index == source_index][0]
    drain = [node for node in nodes if node.index == drain_index][0]
    nodes.remove(source)
    nodes.remove(drain)
    iterations = 1000
    min_capacity = math.inf

    for i in range(iterations):
        source_set = { source_index }
        drain_set = { drain_index }

        for node in nodes:
            if random.randint(0, 1) == 0:
                source_set.add(node.index)
            else:
                drain_set.add(node.index)
    
        capacity = calculate_capacity(source_set, drain_set, connections)

        if capacity < min_capacity:
            min_capacity = capacity

    final_source_set = source_set
    final_drain_set = drain_set

    print(min_capacity)
    print(final_source_set)
    print(final_drain_set)

    nodes.append(source)
    nodes.append(drain)

    show_network(nodes, connections, final_source_set)
