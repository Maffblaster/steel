# Steel - Command line password manager

Password management belongs to the command line. Deep into the Unix heartland,
the shell. With Steel your passwords are safe. Steel uses RIJNDAEL encryption in CFB
mode with 256 bit keys. Steel is simple, Steel is advanced, Steel is adaptable.
Steel is the new prophet of password management.

Steel is Free Software under the GPLv3+ license.

Steel is developed and tested on GNU/Linux but it probably runs on other Unix
like operating systems too.

For more information see http://www.steelpasswordmanager.org.

## Installation

Copy this repository and compile with make

```
Make install
```

## Dependencies

### Ubuntu

```
apt-get install libmcrypt-dev libsqlite3-dev libmhash-dev
```

### OS X

For OS X, you need to first install libsqlite3 libmcrypt, and have XCode installed

With Homebrew:

```
brew install mcrypt sqlite
```

