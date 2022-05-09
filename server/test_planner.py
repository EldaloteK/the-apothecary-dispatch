#!/usr/bin/env python3
"""Tests for planner.py"""

import os

file_to_test = './planner.py'

def test_exists():
    """Test for file existance"""
    assert os.path.isfile(file_to_test)
