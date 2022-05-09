import heapq
import math
from itertools import permutations

class Planner():
    def __init__(self):
        # Temporary hard coded graph TODO
        self.currentMap = {
            'K': {'D': 3, 'E': 9},
            'D': {'K': 3, 'A': 7, 'E': 3},
            'E': {'D': 3, 'K': 9, 'C': 4},
            'A': {'D': 7, 'B': 2},
            'B': {'A': 2, 'C': 4},
            'C': {'E': 4, 'B': 4}
        }
        self.distances = {}
        self.items = {}
        self.routes = {}
        self.delivery_library = {}
        self.delivery_combinations = []
        self.starting_ending_node = ['K']
        self.min_delivery = {
            'distance': math.inf,
            'path': []
        }

    def pairwise(self, iterable):
        """Take in iterable and return successive overlapping pairs in form of generators."""
        a = next(iterable)
        yield from ((a, a := b) for b in iterable)

    def calculate_route(self, starting_node, ending_node):
        """Take in starting and ending nodes and return Dijkstra's shortest path between."""
        # For each node in graph set distance to be inf.
        for node in self.currentMap:
            self.distances[node] = math.inf
            self.items[node] = []
        # Set starting node to a distance of 0.
        self.distances[starting_node] = 0

        # Initialize priority queue with (starting node, distance).
        pr_q = [(starting_node, 0)]

        # Whiel length of priority queue is greater than 0.
        while len(pr_q) > 0:
            # Pop the minimum current node and distance from the priority queue.
            curr_node, curr_distance = heapq.heappop(pr_q)

            # If current distance is greater than distance set, then continue to next iteration.
            if curr_distance > self.distances[curr_node]:
                continue
            # Otherwise if current distance is <= distance set.
            else:
                for connecting_node, weight in self.currentMap[curr_node].items():
                    temp_min_distance = curr_distance + weight

                    if temp_min_distance < self.distances[connecting_node]:
                        self.items[connecting_node].append(curr_node)
                        self.distances[connecting_node] = temp_min_distance
                        self.routes[connecting_node] = curr_node
                        heapq.heappush(pr_q, (connecting_node, temp_min_distance))

        path = []
        final = ending_node

        while final != starting_node:
            try:
                path.insert(0, final)
                final = self.routes[final]
            except Exception:
                print('Path not reachable')
                break
        path.insert(0, starting_node)

        return {
            'distances': self.distances,
            'path': path
        }

    def planner_actions(self, new_deliveries):
        """Begin best delivery path actions and set path after calculations"""
        self.delivery_combinations = (list(permutations(new_deliveries)))

        for delivery_list in self.delivery_combinations:
            complete_delivery_list = self.starting_ending_node + list(delivery_list) + self.starting_ending_node
            delivery_sum = 0
            delivery_path = []
            delivery_list_iter = iter(complete_delivery_list)

            # Delivery list generators returned from pairwise function
            delivery_list_gens = self.pairwise(delivery_list_iter)

            for delivery_point_a, delivery_point_b in delivery_list_gens:
                if (delivery_point_a, delivery_point_b) not in self.delivery_library:
                    dijkstra_result = self.calculate_route(delivery_point_a, delivery_point_b)
                    self.delivery_library[(delivery_point_a, delivery_point_b)] = {'distance': dijkstra_result['distances'][delivery_point_b], 'path': dijkstra_result['path']}
                delivery_sum += self.delivery_library[(delivery_point_a, delivery_point_b)]['distance']
                delivery_path.append(self.delivery_library[(delivery_point_a, delivery_point_b)]['path'])

            if delivery_sum < self.min_delivery['distance']:
                self.min_delivery['distance'] = delivery_sum
                self.min_delivery['path'] = delivery_path
            else:
                delivery_path = []
