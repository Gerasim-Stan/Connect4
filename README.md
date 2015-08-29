Connect 4
====================

The AI uses the minimax algorithm with cut-off and alpha-beta pruning.

The project was designed for a Ruby course in the Faculty Of Mathematics And Informatics
in Sofia University.

### The minimax algorithm

  From wikipedia:
  "Minimax (sometimes MinMax or MM) is a decision rule used in decision
  theory, game theory, statistics and philosophy for minimising the possible
  loss for a worst case (maximum loss) scenario. Alternatively, it can be
  thought of as maximising the minimum gain (maximin or MaxMin). Originally
  formulated for two-player zero-sum game theory, covering both the cases
  where players take alternate moves and those where they make simultaneous
  moves, it has also been extended to more complex games and to general
  decision making in the presence of uncertainty."

### Alpha-beta pruning
  From wikipedia:
  Alpha-beta pruning is a search algorithm that seeks to decrease the number of nodes that are evaluated by the minimax algorithm in its search tree. It is an adversarial search algorithm used commonly for machine playing of two-player games (Tic-tac-toe, Chess, Go, etc.). It stops completely evaluating a move when at least one possibility has been found that proves the move to be worse than a previously examined move. Such moves need not be evaluated further. When applied to a standard minimax tree, it returns the same move as minimax would, but prunes away branches that cannot possibly influence the final decision.

### Cut-off
  Since it is too computationally expensive to search the entire game tree,
  my algorithm stops traversing the tree at a given depth. This can be
  thought of as a number of moves the AI 'thinks' forward. A search depth
  of 5 or below have turned out to give a reasonable response time. With the
  optimisations mentioned below, it should be possible to go deeper. The function also cuts off if the board is full, or if one of the players has won.

### Heuristic

  The heuristic checks every single possible combination of 4 cells in
  which it is possible to win the game. To do so, it first determines
  those combinations.
