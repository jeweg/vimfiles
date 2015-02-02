#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vi: et:ts=4:sw=4

import os.path
import re
try:
    import ycm_core
except ImportError:
    pass

###################################################################

DEBUG = True

if DEBUG:
    import sys
    if sys.platform.startswith('win'):
        logfile = r'C:\Users\wegge01\AppData\Local\Temp\ycmlog.txt'
    else:
        logfile = '/home/jw/temmp.txt'
    f = open(logfile, 'wb+')
    
def log(msg):
    if DEBUG:
        f.write(msg)
        if not msg.endswith('\n'):
            f.write('\n')
        f.flush()

log('log started.')

###################################################################

# These are merely some of the options from the default file that comes
# with YouCompleteMe. They are probably not ideal for our purposes.
DEFAULT_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-Wc++98-compat',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-DNDEBUG',
    # You 100% do NOT need -DUSE_CLANG_COMPLETER in your flags; only the YCM
    # source code needs it.
    '-DUSE_CLANG_COMPLETER',
    # THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
    # language to use when compiling headers. So it will guess. Badly. So C++
    # headers will be compiled as C headers. You don't want that so ALWAYS specify
    # a "-std=<something>".
    # For a C project, you would set this to something like 'c99' instead of
    # 'c++11'.
    '-std=c++11',
    # ...and the same thing goes for the magic -x option which specifies the
    # language that the files to be compiled are written in. This is mostly
    # relevant for c++ headers.
    # For a C project, you would set this to 'c' instead of 'c++'.
    '-x',
    'c++',
    '-I', '.' # We might have to make this absolute once we know the file to complete. Not sure if needed.
]

SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']
DIRECTORY_BLACKLIST = frozenset(['cbuild', '.svn', '.git', 'CVS'])

###################################################################

def find_compile_commands(file_path):
    """The places this looks for the db file at.
    This starts with the current directory being the file's directory.
    1. in the current directory
    2. in a build subdir of the current directory
    3. in a direct subdir of the subdir of step 2.
    3. in a build neighbouring dir of the current directory's
    4. in a direct subdir of the subdir of step 3. 
    This search is repeated upwards in the tree.
    """

    log('  find_compile_commands invoked with "%s"' % file_path)
    
    DB_NAME = 'compile_commands.json'
   
    candidates = []
    
    def look_in_dir(dir_path):
        trypath = os.path.join(dir_path, DB_NAME)
        #log('        Trying "%s"' % trypath)
        if os.path.isfile(trypath):
            candidates.append(trypath)
   
    def look_in_subdirs(dir_path, also_recurse_without_regexp, name_regexp=None):
        for child_name in os.listdir(dir_path):
            if child_name in DIRECTORY_BLACKLIST:
                continue
            child_path = os.path.join(dir_path, child_name)
            if not os.path.isdir(child_path):
                continue
            if name_regexp is None or name_regexp.match(child_name):
                look_in_dir(child_path)
                if also_recurse_without_regexp:
                    look_in_subdirs(child_path, False)


            
    curr_dir = os.path.realpath(file_path)
    if not os.path.isdir(curr_dir):
        curr_dir = os.path.dirname(curr_dir)
    while True:
        log('    curr_dir = "%s"' % curr_dir)

        candidates = []
        curr_dir_parent, curr_dir_basename = os.path.split(curr_dir)
        if not curr_dir_parent or curr_dir_parent == curr_dir:
            break

        # 1
        look_in_dir(curr_dir)
        # 2
        re_build_dir = re.compile(r'_?builds?|builds?[_-]?{0}|{0}[_-]?builds?'.format(curr_dir_basename), re.I) 
        look_in_subdirs(curr_dir, re_build_dir)
        # 3
        look_in_subdirs(curr_dir_parent, re_build_dir)

        if candidates:
            break

        # Iterate up the tree.
        curr_dir = curr_dir_parent

    if not candidates:
        return None
    elif len(candidates) == 1:
        return candidates[0]
    else:
        # We have multiple candidates, which in practice means multiple build
        # dirs in the tree. How do we decide which one to use?
        # Let's use the most recently used one. Using in this meaning should
        # probably mean used for compilation. How to find this time?
        # Well, it seems CMake will update the last-modification-time of
        # The CMakeFiles directory of a build. This happens regardless of whether
        # the build succeeded or not.
        # If that directory doesn't exist we use the mod time of the db file itself.

        # Sort by last-modification time and return the newest.
        newest_cand, newest_mtime = None, 0
        for cand in candidates:
            path = os.path.join(os.path.dirname(cand), 'CMakeFiles')
            if not os.path.isdir(path):
                path = cand
            mtime = os.path.getmtime(path)
            if not newest_cand or mtime > newest_mtime:
                newest_mtime = mtime
                newest_cand = cand
        return newest_cand

###################################################################

# Known compilation dbs. Directory => ycm_core.CompilationDatabase
compilation_dbs = {}

# Cache of compilation dbs for file. Full path => ycm_core.CompilationDatabase
compilation_db_for_file = {}
        
###################################################################

def is_header_file(filename):
    extension = os.path.splitext(filename)[1]
    return extension.lower() in ['.h', '.hxx', '.hpp', '.hh']

###################################################################

def get_compilation_info(cdb, file_path):
    # The compilation_commands.json file generated by CMake does not have entries
    # for header files. So we do our best by asking the db for flags for a
    # corresponding source file, if any. If one exists, the flags for that file
    # should be good enough.
    if is_header_file(file_path):
        basename = os.path.splitext(file_path)[0] 
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                compilation_info = cdb.GetCompilationInfoForFile(replacement_file)
                if compilation_info.compiler_flags_:
                    return compilation_info
        return None
    return cdb.GetCompilationInfoForFile(file_path)

###################################################################

# This gets called from YouCompleteMe with the full path of a file
# to do completion on. It should return a list of compile options.
def FlagsForFile(file_path, **kwargs):
    log('FlagsForFile called for "%s"\n' % file_path)
    # Try to get an apt compilation database (cdb).
    cdb = compilation_db_for_file.get(file_path, None)
    if not cdb:
        log('   no cdb cached for this file!\n')
        path = find_compile_commands(file_path)
        log('   find_compile_commands returned "%s"' % path)
        if path:
            ppath = os.path.dirname(path)
            # Have we already loaded this cdb?
            if DEBUG:
                log('   found cdb as "%s"\n' % path)
            cdb = compilation_dbs.get(ppath, None)
            if not cdb: 
                log('   instantiating cdb.\n')
                cdb = ycm_core.CompilationDatabase(ppath)
                if cdb:
                    compilation_dbs[ppath] = cdb
            if cdb: 
                compilation_db_for_file[file_path] = cdb

    if cdb:
        log('   getting info from cdb.\n')
        # Bear in mind that compilation_info.compiler_flags_ does NOT return a
        # python list, but a "list-like" StringVec object
        compilation_info = get_compilation_info(cdb, file_path)
        if not compilation_info:
            log('    no info in cdb.')
            final_flags = DEFAULT_FLAGS
        else:
            final_flags = list(compilation_info.compiler_flags_)
            final_flags += ['-I', compilation_info.compiler_working_dir_]

    else:
        log('   using default flags')
        final_flags = DEFAULT_FLAGS 

    log('   final_flags = %s\n' % final_flags)

    return {
        'flags': final_flags,
        'do_cache': True
    }

###################################################################

if __name__ == '__main__':
    print find_compile_commands(r'/home/jw/Documents/work/sv/local/qt5test/qt5test/src/MainWindow.cpp')
    print find_compile_commands(r'/home/jw/Documents/work/sv/local/qt5test/qt5test/src')
    print find_compile_commands(r'/mnt/main2/former-j/_jw_dev4/motor/database/TestRingMap.cpp')

