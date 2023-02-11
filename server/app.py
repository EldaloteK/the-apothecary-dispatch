#!/usr/bin/env python3

from flask import Flask, request, jsonify
from flask_cors import CORS

from planner import Planner

app = Flask(__name__)
CORS(app)

delivery_planner = Planner()

# TODO
@app.route("/new", methods=["GET"])
def new_graph():
    """Initial setup for hospital graph"""
    if request.method == "GET":
        return jsonify({
            "graph": "cba"
        })
    else:
        return "error"

@app.route("/create", methods=["POST"])
def create_graph():
    """Receive delivery points and return calculated path"""
    new_delivery_data = request.get_json()

    if request.method == "POST":
        delivery_planner.planner_actions(new_delivery_data['deliveries'])
        final_delivery_list = []

        # Take every list that is not first and chop off first then merge
        for delivery_index, delivery_subset in enumerate(delivery_planner.min_delivery['path']):
            if delivery_index != 0:
                delivery_subset = delivery_subset[1:]
            final_delivery_list += delivery_subset
        print(final_delivery_list)

        # Return best path delivery list 
        return jsonify({
            "path": final_delivery_list
        })
    else:
        return "error"