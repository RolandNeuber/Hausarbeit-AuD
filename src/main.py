import math
import random
from pprint import pprint

type Node = Node

class Node:
    def __init__(self: Node, index: int, x: float, y: float) -> Node:
        self.index: int = index
        self.x: float = x
        self.y: float = y

    def dist_to(self: Node, other: Node) -> float:
        return math.sqrt((self.x - other.x) ** 2 + (self.y - other.y) ** 2)
    
    def __repr__(self):
        return str(self.__class__.__name__) + "(" + str(vars(self)).strip("{}") + ")"

type Connection = Connection

class Connection:
    def __init__(self: Connection, start_node: int, end_node: int, capacity: int):
        self.start_node: int = start_node
        self.end_node: int = end_node
        self.capacity: int = capacity
    
    def __repr__(self):
        return str(self.__class__.__name__) + "(" + str(vars(self)).strip("{}") + ")"

def read_position_file() -> list[Node]:
    # Einlesen der FNWNodePos.txt
    # u x_u y_u
    with open("src/FNWNodePos.txt", "r") as data_file:
        nodes: list[Node] = []
        for line in data_file.readlines():
            args = line.split()
            nodes.append(Node(int(args[0]), float(args[1]), float(args[2])))
    return nodes

def read_capacity_file() -> tuple[int, list[Connection], int]:
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
    total_capacity = 0
    for connection in connections:
        if connection.start_node in source_partition \
        and connection.end_node in drain_partition:
            total_capacity += connection.capacity

    return total_capacity


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