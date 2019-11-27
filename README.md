# ssh-csie

The script detect which workstation of NTU CSIE is better, and then `ssh` or `sftp` to that machine.

## Installation & Configuration

- Download this repository.

- Add execution permission to `ssh-csie.sh` and `sftp-csie.sh`.

  ```shell
  chmod u+x ssh-csie.sh
  chmod u+x sftp-csie.sh
  ```

- Specify your account name (usually student ID) at file `~/.ssh-csie.conf` .

  ```shell
  echo bxx902xxx > ~/.ssh-csie.conf
  ```
  (both `ssh-csie` and `sftp-csie` read configurations from this file.)

- Now you have done installation and configuration!

## Usage

- Just simply run the script, and then it will detect the best workstations and then `ssh` or `sftp` to it.

  ```shell
  ssh-csie.sh
  ```

  or

  ```shell
  sftp-csie.sh
  ```

- Or, you can specify which machine you want to `ssh` or `sftp` to. For example,

  ```shell
  ssh-csie.sh 12		# this command is equivalent to the next command
  ssh-csie.sh linux12	# ssh bxx902xxx@linux12.csie.ntu.edu.tw
  sftp-csie.sh bsd1	# sftp bxx902xxx@bsd1.csie.ntu.edu.tw
  sftp-csie.sh oasis2	# sftp bxx902xxx@oasis2.csie.ntu.edu.tw
  ```

- Besides, you can add the script to the path, so that you can conveniently run it wherever you are.

## How does this script determine which workstation is better?

- The script get statuses of the machines by this url: [https://monitor.csie.ntu.edu.tw/](https://monitor.csie.ntu.edu.tw/) .

- The script will calculate the availability of each machine based on `cpu` and `mem` usage.
  If you are interested in this calculation, you can read `sort_server.py`.
