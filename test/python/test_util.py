# -*- coding: utf-8 -*-

# Copyright 2017 IBM RESEARCH. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# =============================================================================
"""Tests for qiskit/_util.py"""

import unittest
from qiskit._util import _check_ibmqx_version
from .common import QiskitTestCase


class TestUtil(QiskitTestCase):
    """Tests for qiskit/_util.py"""
    
    @unittest.skip("Temporary skipping")
    def test_check_ibmqx_version(self):
        """Requiered IBMQE version."""
        with self.assertNoLogs('qiskit._util', level='WARNING'):
            _check_ibmqx_version()
