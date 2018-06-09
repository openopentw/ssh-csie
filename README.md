# ssh-csie

The script helps students in NTU CSIE `ssh` or `sftp` to workstations.

It will detect which machine on workstation is better, and then `ssh` or `sftp` to that machine.

> ssh-csie now support macOS !!
> (Since macOS does not support `readarray` method, I use `IFS` instead)

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

## Installation & Configuration

- Download this repository.

- Add execution permission to `ssh-csie.sh` and `sftp-csie.sh`.

  ```shell
  chmod u+x ssh-csie.sh
  chmod u+x sftp-csie.sh
  ```

- Specify your account name (usually student ID) at file `~/.ssh-csie-config` .

  ```shell
  echo bxx902xxx > ~/.ssh-csie-config
  ```
  (both `ssh-csie` and `sftp-csie` read configurations from this file.)

- Now you have done installation and configuration!

## How does this script determine which workstation is better?

- The script get statuses of the machines by this url: [https://monitor.csie.ntu.edu.tw/status.html](https://monitor.csie.ntu.edu.tw/status.html) .

- The script will give each machine a `score` based on the colors on the cells inside the table in the webpage.
  The table below describes how scores correspond to colors.

  | color  | meaning | score |
  | :----- | ------- | :---- |
  | white  | normal  | 0     |
  | yellow | low     | 1     |
  | orange | medium  | 3     |
  | red    | high    | 5     |

- Finally, the script chooses the machine that has the lowest `score` to connect to.

> This is just a simple algorithm to determine which machine is better.
> Therefore if you have any better ideas, you can tell me or just fork this repository.
