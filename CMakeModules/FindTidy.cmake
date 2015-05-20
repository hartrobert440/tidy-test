# Find Tidy
# Find the native TIDY includes and library.
# Once done this will define
#
#  TIDY_FOUND          - True if tidy found.
#  TIDY_INCLUDE_DIRS   - where to find tidy.h, etc.
#  TIDY_LIBRARIES      - List of libraries when using tidy.
#
# An includer may set TIDY_ROOT to a Tidy installation root to tell
# this module where to look.

set(_TIDY_SEARCHES ${CMAKE_INSTALL_PREFIX})

# Search TIDY_ROOT first if it is set.
if (TIDY_ROOT)
  set(_TIDY_SEARCH_ROOT PATHS ${TIDY_ROOT})
  list(APPEND _TIDY_SEARCHES ${_TIDY_SEARCH_ROOT})
endif()
set( _TIDY_ROOT $ENV{TIDY_ROOT} )
if (_TIDY_ROOT)
  list(APPEND _TIDY_SEARCHES ${_TIDY_ROOT})
endif ()

set(TIDY_NAMES tidy tidy5)

if (_TIDY_SEARCHES)
    # Try each search configuration.
    message(STATUS "+++ Search using paths ${_TIDY_SEARCHES}")
    foreach(search ${_TIDY_SEARCHES})
      find_path(TIDY_INCLUDE_DIR
        NAMES tidy.h
        PATHS ${search}
        PATH_SUFFIXES include
        )
      find_library(TIDY_LIBRARY
        NAMES ${TIDY_NAMES}
        PATHS ${search} 
        PATH_SUFFIXES lib
        )
    endforeach()
else ()
    message(STATUS "+++ Default search with no search paths")
    find_path(TIDY_INCLUDE_DIR
        NAMES tidy.h
        PATH_SUFFIXES include
    )
    find_library(TIDY_LIBRARY
        NAMES ${TIDY_NAMES}
        PATH_SUFFIXES lib
    )
endif ()
###mark_as_advanced(TIDY_LIBRARY TIDY_INCLUDE_DIR)

# handle the QUIETLY and REQUIRED arguments and set TIDY_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(TIDY REQUIRED_VARS TIDY_LIBRARY TIDY_INCLUDE_DIR
                                       VERSION_VAR TIDY_VERSION_STRING)

if(TIDY_FOUND)
    set(TIDY_INCLUDE_DIRS ${TIDY_INCLUDE_DIR})
    set(TIDY_LIBRARIES ${TIDY_LIBRARY})
endif()

# eof
