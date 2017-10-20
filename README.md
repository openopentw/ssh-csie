# ssh-csie

The script helps students in NTU CSIE connect to workstations.

It will detect which machine on workstation is better, and then `ssh` to that machine.

## Installation

- Download this repository.

- Specify your account name (usually student ID) in the `config` file.

  ```shell
  echo bxx902xxx > config
  ```

## Usage

- Just simply run the script.

  ```shell
  bash ./ssh-csie.sh
  ```


## TODOs

- [ ] Let people can manually specify which workstation they want to connect to.
- [ ] Add a `sftp` version.

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

- Finally, the script chooses the machine that has the smallest `score` to connect to.

> This is just a simple algorithm to determine which machine is better.
> Therefore if you have any better ideas, you can tell me or just fork this repository.