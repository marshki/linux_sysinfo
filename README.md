# Bash System Info  

Bash script to extract useful information from a `Linux` host using a menu-driven interface.
This script will be tested to run in: Centos 7, Debian 8 & Ubuntu 16.04. 

** UPDATE (2016.11.01): ** 

Forked program in to two distinct branches--one for Linux-based OSs and anothe for OS X / FreeBSD. 

Still a work in progress.  

# TODO

- [ ] Get to work on: 
    - [x] Centos 7
    - [x] Debian 8
    - [x] Ubuntu 16.04
    
- [x] Overly verbose output for: `ps auxf |sort -nr -k 4`|head -5 
- [ ] `ip` command not found in OS X 
- [ ] `free` command not found in OS X
- [ ] `vmstat` command not found in OS X 
- [ ] `ps auxf` chokes on pipe in OS X  
- [x] go with verbose command line options when possible 
- [ ] Defeat more badness as it comes up

# History 

First commit 2016.10.07

# License 

[MIT license](https://opensource.org/licenses/MIT). 'Nuff said. 
