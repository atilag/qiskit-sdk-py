

function(add_pypi_package_target TARGET_NAME)
	message("Buscamos Python")
	# Create Python distrubution package
	find_program(PYTHON "python")
	if (NOT PYTHON)
		message(FATAL_ERROR "We can't find Python in your system. Install it and try again...")
	endif()
	message("Hemos encontrado Python..")
	set(SETUP_PY_IN "${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in")
	set(SETUP_PY    "${CMAKE_CURRENT_BINARY_DIR}/setup.py")
	set(EXECUTABLE_FILE_EXTENSION "")

	message("QISKIT_VERSION = ${QISKIT_VERSION}")
	configure_file(${SETUP_PY_IN} ${SETUP_PY})

	if(UNIX)
		set(PIP_CURRENT_PLATFORM, "bdist_wheel -p manylinux1_x86_64")
	elseif(MINGW)
		set(EXECUTABLE_FILE_EXTENSION ".exe")
		set(PIP_CURRENT_PLATFORM, "bdist_wheel") # TODO: Find the correct Tag
	elseif(APPLE)
		set(PIP_CURRENT_PLATFORM, "bdist_wheel") # TODO: Find the correct Tag
	endif()

	message("Comando para copiar el simulator a backends")
	message("PROJECT_SOURCE_DIR = ${PROJECT_SOURCE_DIR}")
	message("QISKIT_SIMULATOR_OUTPUT_DIR = ${QISKIT_SIMULATOR_OUTPUT_DIR}")
	message("CMAKE_CURRENT_SOURCE_DIR = ${CMAKE_CURRENT_SOURCE_DIR}")

	set(COPY_QISKIT_SIM_TARGET ${TARGET_NAME}_copy_qiskit_simulator)
	add_custom_target(${COPY_QISKIT_SIM_TARGET})
    add_custom_command(TARGET ${COPY_QISKIT_SIM_TARGET}
		COMMAND ${CMAKE_COMMAND} -E copy
			${QISKIT_SIMULATOR_OUTPUT_DIR}/qiskit_simulator${EXECUTABLE_FILE_EXTENSION}
			${CMAKE_CURRENT_SOURCE_DIR}/qiskit/backends)
	if(MINGW)
		foreach(dll_file ${QISKIT_SIMULATOR_THIRD_PARTY_DLLS})
			add_custom_command(TARGET ${COPY_QISKIT_SIM_TARGET}	
				COMMAND ${CMAKE_COMMAND} -E copy
					${dll_file}
					${CMAKE_CURRENT_SOURCE_DIR}/qiskit/backends)
		endforeach()
	endif()
	
	add_custom_target(${TARGET_NAME})
	add_custom_command(TARGET ${TARGET_NAME}
		COMMAND ${PYTHON} ${SETUP_PY} sdist ${PIP_CURRENT_PLATFORM})
	
	add_dependencies(${TARGET_NAME} ${COPY_QISKIT_SIM_TARGET})
	add_dependencies(${COPY_QISKIT_SIM_TARGET} qiskit_simulator)
endfunction()

