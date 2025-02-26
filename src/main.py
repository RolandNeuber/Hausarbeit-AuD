type Node = Node;

class Node:
    def __init__(self: Node, x: float, y: float):
        self.x = x
        self.y = y

    def dist_to(self: Node, other: Node):
        return math.sqrt((self.x - other.x) ** 2 + (self.y - other.y) ** 2)

# Einlesen der FNWNodePos.txt
# u x_u y_u
with open("FNWNodePos.txt", "r") as data_file:
    data_file.readlines()

# Einlesen der dataFNW4.txt
# u_i u_j c(u_i, u_j)
with open("dataFNW4.txt", "r") as data_file:
    data_file.readlines()

if __name__ == "main":
    pass