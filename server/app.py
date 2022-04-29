from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/new", methods=["GET"])
def new_graph():
    """Initial graph/map setup."""
    if request.method == "GET":
        return jsonify({
            "graph": "cba"
        })
    else:
        return "error"

@app.route("/create", methods=["POST"])
def create_graph():
    """Receive delivery points and return calculated path."""
    if request.method == "POST":
        return jsonify({
            "path": "abc"
        })
    else:
        return "error"