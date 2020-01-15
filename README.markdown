friendly-find
=============

`friendly-find` is the friendly file finder.

It's meant to be a more usable replacement for find(1).  If you've used [ack][],
then ffind is to find as ack is to grep.

Currently it's still in a prototype stage.  Most things work, with the following
notable exceptions:

* Time filtering is unimplemented.
* SVN ignores aren't parsed.
* It's pretty slow (though pruning VCS data directories saves lots of time).

Feedback is welcome, though remember that it's still a prototype, and is
opinionated software.

[ack]: http://betterthangrep.com/

* Mercurial: <http://hg.stevelosh.com/friendly-find/>
* Git: <http://github.com/sjl/friendly-find/>
* Documentation: <http://github.com/sjl/friendly-find/#usage>
* Issues: <http://github.com/sjl/friendly-find/issues/>
* License: GPLv3 (see [notes](http://github.com/sjl/friendly-find/#license))

Installation
------------

If you're on OS X you can use Homebrew:

    brew install ffind

Or you can install manually:

1. Copy the `ffind` to your computer somehow.
2. Make it executable.
3. Get it into your path somehow.

Usage
-----

There's a half-assed man page generated from `help2man`, but `ffind --help` is
probably easier to read.

### Command Line Program

    Usage: ffind [options] PATTERN

    Options:
      -h, --help            show this help message and exit
      --version             print the version and exit
      -d DIR, --dir=DIR     root the search in DIR (default .)
      -D N, --depth=N       search at most N directories deep (default 25)
      -f, --follow          follow symlinked directories and search their contents
      -F, --no-follow       don't follow symlinked directories (default)
      -0, --print0          separate matches with a null byte in output
      -l, --literal         force literal search, even if it looks like a regex
      -v, --invert          invert match
      -e, --entire          match PATTERN against the entire path string
      -E, --non-entire      match PATTERN against only the filenames (default)
      -p, --full-path       print the file's full path
      -P, --relative-path   print the file's relative path (default)

      Configuring Case Sensitivity:
        -s, --case-sensitive
                            case sensitive matching (default)
        -i, --case-insensitive
                            case insensitive matching
        -S, --case-smart    smart case matching (sensitive if any uppercase chars
                            are in the pattern, insensitive otherwise)

      Configuring Ignoring:
        -b, --binary        allow binary files (default)
        -B, --no-binary     ignore binary files
        -r, --restricted    restricted search (skip VCS directories, parse all
                            ignore files) (default)
        -q, --semi-restricted
                            semi-restricted search (don't parse VCS ignore files,
                            but still skip VCS directories and parse .ffignore)
        -u, --unrestricted  unrestricted search (don't parse ignore files, but
                            still skip VCS directories)
        -a, --all           don't ignore anything (ALL files can match)
        -I PATTERN, --ignore=PATTERN
                            add a pattern to be ignored (can be given multiple
                            times)

      Size Filtering:
        Sizes can be given as a number followed by a prefix.  Some examples:
        1k, 5kb, 1.5gb, 2g, 1024b

        --larger-than=SIZE  match files larger than SIZE (inclusive)
        --smaller-than=SIZE
                            match files smaller than SIZE (inclusive)

      Type Filtering:
        Possible types are a (all), f (files), d (dirs), r (real), s
        (symlinked), e (real files), c (real dirs), x (symlinked files), y
        (symlinked dirs). If multiple types are given they will be unioned
        together:  --type 'es' would match real files and all symlinks.

        -t TYPE(S), --type=TYPE(S)
                            match only specific types of things (files, dirs, non-
                            symlinks, symlinks)

### .ffignore file format

The `.ffignore` file is a file containing lines with patterns to ignore, with
a few exceptions:

* Blank lines and whitespace-only are skipped.  If you want to ignore files
  whose names consist of only whitespace use a regex.  Or reconsider what got
  you there in the first place.
* Lines beginning with a `#` are comments and are skipped.  There can be
  whitespace before the `#` as well.
* Lines of the form `syntax: (literal|regex)` change the mode of the lines
  following them, much like Mercurial's ignore file format.  The default is
  regex mode.
* All other lines are treated as patterns to ignore.

All patterns are unrooted, and search the full path from the directory you're
searching in.  Use a regex with `^` if you want to root them.

For example:

    foo.*bar

Will ignore:

    ./foobar.txt
    ./foohello/world/bar.txt

License
-------

Copyright 2016 Steve Losh and contributors.

Licensed under [version 3 of the GPL][gpl].

Remember that you can use GPL'ed software through their command line interfaces
without any license-related restrictions.  `ffind`'s command line interface is
the only stable one, so it's the only one you should ever be using anyway.  The
license doesn't affect you unless you're:

* Trying to copy the code and release a non-GPL'ed version of `ffind`.
* Trying to use it as a Python module from other Python code (for your own
  sanity I urge you to not do this) and release the result under a non-GPL
  license.

[gpl]: http://www.gnu.org/copyleft/gpl.html
