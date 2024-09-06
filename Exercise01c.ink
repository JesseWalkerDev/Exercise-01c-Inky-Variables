VAR die = 6
VAR p_roll = 1
VAR c_roll = 1
VAR money = 50

-> rules

== rules ==
You can make a bet. You roll a die and I roll a die. If the number you roll is higher than my number, I pay you the number on my die. If I roll a number higher than yours, you pay me the number on your die.
+ [{Begin|Continue}]
-> bet

== bet ==
{ money <= 0: -> broke}

Your balance is: {money}.
-
    + [Roll a d6]
        ~die = 6
    + [Roll a d10]
        ~die = 10
    + [Roll a d20]
        ~die = 20
    + [Roll a d30]
        ~die = 30
    + [Rules] -> rules
-
-> roll_die

== roll_die
You roll a d{die}...
~ p_roll = RANDOM(1, die)
You get: {p_roll}
{ RANDOM(1,4):
    - 1: ~ die = 6
    - 2: ~ die = 10
    - 3: ~ die = 20
    - 4: ~ die = 30
}
I roll a d{die}...
~ c_roll = RANDOM(1, die)
I get: {c_roll}.
{
- p_roll > c_roll:
    You win! the number on my die is {c_roll}, so I pay you that much.
    ~ money += c_roll
    + [+ {c_roll}] -> bet
- p_roll < c_roll:
    I win! the number on your die is {p_roll}, so you pay me that much.
    ~ money -= p_roll
    + [- {p_roll}] -> bet
- else:
    It's a tie! Neither of us pay anything.
    + [Continue] -> bet
}
-> DONE

== broke ==
You have no more money to play with!
Your final balance is: {money}.
Better luck next time!
-> END
