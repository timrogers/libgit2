# Optional external dependency: http-parser
if(USE_HTTP_PARSER STREQUAL "system")
	find_package(HTTP_Parser)

	if(HTTP_PARSER_FOUND AND HTTP_PARSER_VERSION_MAJOR EQUAL 2)
		list(APPEND LIBGIT2_SYSTEM_INCLUDES ${HTTP_PARSER_INCLUDE_DIRS})
		list(APPEND LIBGIT2_SYSTEM_LIBS ${HTTP_PARSER_LIBRARIES})
		list(APPEND LIBGIT2_PC_LIBS "-lhttp_parser")
		add_feature_info(http-parser ON "http-parser support (system)")
	else()
		message(FATAL_ERROR "http-parser support was requested but not found")
	endif()
else()
	message(STATUS "http-parser version 2 was not found or disabled; using bundled 3rd-party sources.")
	add_subdirectory("${CMAKE_SOURCE_DIR}/deps/http-parser" "${CMAKE_BINARY_DIR}/deps/http-parser")
	list(APPEND LIBGIT2_DEPENDENCY_INCLUDES "${CMAKE_SOURCE_DIR}/deps/http-parser")
	list(APPEND LIBGIT2_DEPENDENCY_OBJECTS "$<TARGET_OBJECTS:http-parser>")
	add_feature_info(http-parser ON "http-parser support (bundled)")
endif()
