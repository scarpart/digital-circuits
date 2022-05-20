This is a folder for my mastermind game. The purpose of the game is to guess a number, with configurable difficulty, using only the switches of an FPGA board.
The game shows after each guess the number of correct guesses in place and the number of correct guesses that are out of place in order to aid the user.

The user has 15 attempts at guessing the number - if they run out, they lose.
There is a time window of 10 seconds for each guess - if time runs out, they also lose.
Finally, if the user guesses the number, they win the game and their score is shown.

Further information can be found in the state diagram of the FSM, which is also in this repo.
