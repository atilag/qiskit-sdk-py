import sys
import os

sys.path.append(os.path.join(os.path.dirname(__file__), '../../../..'))
from qiskit.transpiler import StageBase, StageInputOutput, StageError

class ReturnJsonStage(StageBase):
    def __init__(self):
        pass

    def get_name(self, name):
        return 'TransformStage'

    def handle_request(self, input):
        json_circuit = input.extract('json_circuit')
        layout = input.extract('layout')
        input.remove('json_circuit')
        input.result = (layout, json_circuit)
        return input

    def check_precondition(self, input):
        if not isinstance(input, StageInputOutput):
            raise StageError('Input instance not supported!')

        if not input.exists(['dag_circuit', 'json_circuit']):
            return False

        self.format = input.extract('format')
        if self.format != 'json':
            return False

        return True