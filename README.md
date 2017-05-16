# Qiskit SDK Python

[![Build Status](https://travis.ibm.com/IBMQuantum/qiskit-sdk-py-dev.svg?token=GMH4xFrA9iezVJKqw2zH&branch=master)](https://travis.ibm.com/IBMQuantum/qiskit-sdk-py-dev)

Python software development kit (SDK) and Jupyter notebooks for working with
OPENQASM and the IBM Quantum Experience (QE).


## Organization

The *tutorial* directory contains Jupyter notebooks showing how to use the
[Python API](https://github.com/IBM/qiskit-api-py) with
[OPENQASM](https://github.com/IBM/qiskit-openqasm).

There are Jupyter notebooks demonstrating components of
the SDK in the *tutorial* directory, and more python and qasm examples in the *examples* directory. There are also command line test scripts
in the *test* directory.

Users can construct a *QuantumProgram* to create, modify, compile, and execute a collection of quantum circuits.

Each *QuantumCircuit* has some set of registers, *QuantumRegister* and *ClassicalRegister*, and methods of these objects are used to apply instructions within the circuit. The *extensions* directory extends
the quantum circuit as needed to support new gate sets and algorithms. For example, the "cswap" gate in the standard extension shows how to build gates that are sequences of
other unitary gates. The Python file "header.py" shows how we append OPENQASM
gate definitions as we import extensions. The *QuantumCircuit* can generate
OPENQASM code that can flow through other components in the *qiskit* directory.

The *qiskit* directory is the main Python module and contains the programming
interface objects *QuantumProgram*, *QuantumRegister*, *ClassicalRegister*, and *QuantumCircuit*.
The directory also contains internal modules: a *qasm* module for parsing OPENQASM circuits,
an *unroll* module to "flatten" QASM for a target gate basis by expanding
gate subroutines as needed, a *circuit* module for working with circuits as
graphs, and a *mapper* module for mapping all-to-all circuits to run on
devices with fixed couplings.

Quantum circuits flow through the components as follows. The programming
interface is used to generate **OPENQASM** circuits. **OPENQASM** source,
as a file or string, is passed into a *Qasm* object, whose *parse* method
produces an abstract syntax tree (**AST**). The **AST** is
passed to an *Unroller* that is attached to an *UnrollerBackend*. There is
a *PrinterBackend* for outputting text and a *CircuitBackend* for constructing *Circuit* objects. The *Circuit* object represents an unrolled **OPENQASM**
circuit as a directed acyclic graph (**DAG**). The *Circuit* provides methods
for representing, transforming, and computing properties of a circuit as a
**DAG** and outputting the results again as **OPENQASM**. The whole flow is
used by the *mapper* module to rewrite a circuit to execute on a device
with fixed couplings given by a *CouplingGraph*.

The circuit representations and how they are currently transformed into each other are summarized here:

<img src="images/circuit_representations.png" alt="circuits" width="500"/>

The unroller backends and their outputs are summarized here:

<img src="images/unroller_backends.png" alt="backends" width="500"/>


## Install

- Install Anaconda: https://www.continuum.io/downloads
- Clone the repo:

```sh
git clone https://github.ibm.com/IBMQuantum/qiskit-sdk-py-dev
cd qiskit-sdk-py-dev
```

- Create the environment with the dependencies:

```sh
make env
```

## Use

- Setup the Jupyter notebook. Add your API token to the file "Qconfig.py" (get it from [IBM Quantum Experience](https://quantumexperience.ng.bluemix.net) > Account):

```sh
cp tutorial/Qconfig.py.default Qconfig.py
```

- Run it:

```sh
make run
```

## FAQ

If you upgrade the dependencies and next error happens try this fix:

```sh
pip install --upgrade IBMQuantumExperience
* Cannot remove entries from nonexistent file [PATH]/easy-install.pth

# Fix
curl https://bootstrap.pypa.io/ez_setup.py -o - | python
```

## Do you want to help?

:sunglasses: If you'd like to contribute please take a look to our [contribution guidelines](CONTRIBUTING.md).
