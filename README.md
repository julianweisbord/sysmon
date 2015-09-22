sysmon:
---

1. CPU/Cache:
  brand, frequency and overclock or turbo boost, number of cores,
  number of threads, cache levels and size, free cache space.
2. GPU/Integrated Graphics:
  brand, name, frequency and overclock, number of cores.
3. RAM:
  brand, name,size, frequency.
4. Motherboard:
  brand, name, socket.
5. Hard Drive:
  brand, name, type of drive, size, read and write speed, space left.
6. Temperatures:
  CPU, GPU, RAM.
7. Operating System:
  version, developer, kernel, compiler, shell.
8. Time:
  Month/Day/Hour/Minute/Second, EPOCH time
9. Network Info:
    IP Adress

Setup:
  1. Execute in terminal: cd ~ && git clone https://github.com/julianweisbord/sysmon.git
  2. Execute in terminal: vim ~/.bashrc
  3. go down to the bottom and Execute in terminal: export PATH="$PATH:~/sysmon/sys_info/sysmon.sh"
  4. To quit vim, execute: :wq
  5. Execute in terminal: source ~/.bashrc


Uses:
(Assuming you have added this to your path)
  1. sudo sysmon
  2. sudo sysmon -a //for disk and gpu information (will take a few seconds)

Notes:

Linux doesn't seem to have any information about a cpu's microarchitecture codename.
There are installable programs that have a database of modern cpu codenames such as likwid
 but those would have to be updated with each processor release.

 Doesn't appear to be a way to print amount of cache space currently used.
