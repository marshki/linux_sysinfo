# Bash System Info  

Bash script to extract useful information from a `*NIX` host using a menu-driven interface.
Ideally, this script should run in: Centos 7, Debian 8, Mac OS X (11), & Ubuntu 16.04. 

** UPDATE (11.01.2016): ** 

Will need to fork program and have two distinct branches--one for Linux-based OSs and one for OS X / FreeBSD

Still a work in progress.  

# TODO

- [ ] Get to work on: 
    - [x] Centos 7
    - [x] Debian 8
    - [x] Ubuntu 16.04
    - [ ] Mac OSX 11
- [ ] Overly verbose output for: `ps auxf |sort -nr -k 4`|head -5 
- [ ] `ip` command not found in OS X 
- [ ] `free` command not found in OS X
- [ ] `vmstat` command not found in OS X 
- [ ] `ps auxf` chokes on pipe in OS X  
- [ ] go with verbose command line options when possible 
- [ ] Defeat more badness as it comes up

# History 

First commit 2016.10.07

# License 

[MIT license](https://opensource.org/licenses/MIT). 'Nuff said. 
