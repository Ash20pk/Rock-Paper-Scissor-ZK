pragma solidity ^0.8.0;

contract RockPaperScissors {
    enum Move { None, Rock, Paper, Scissors }
    enum Result { None, Player1Wins, Player2Wins, Tie }
    
    mapping(address => Move) public playerMoves;
    mapping(address => bool) public hasPlayed;
    
    address public player1;
    address public player2;
    
    event GameResult(address player1, address player2, Result result);
    
    constructor() {
        player1 = msg.sender;
    }
    
    function joinGame() public {
        require(player2 == address(0), "Game is already full");
        player2 = msg.sender;
    }
    
    function playMove(uint8 move) public {
        require(move >= uint8(Move.Rock) && move <= uint8(Move.Scissors), "Invalid move");
        require(msg.sender == player1 || msg.sender == player2, "Not a participant");
        require(!hasPlayed[msg.sender], "Already played");
        
        playerMoves[msg.sender] = Move(move);
        hasPlayed[msg.sender] = true;
        
        if (hasPlayed[player1] && hasPlayed[player2]) {
            determineWinner();
        }
    }
    
    function determineWinner() private {
        require(hasPlayed[player1] && hasPlayed[player2], "Both players haven't played yet");
        
        if (playerMoves[player1] == playerMoves[player2]) {
            emit GameResult(player1, player2, Result.Tie);
        } else if (
            (playerMoves[player1] == Move.Rock && playerMoves[player2] == Move.Scissors) ||
            (playerMoves[player1] == Move.Paper && playerMoves[player2] == Move.Rock) ||
            (playerMoves[player1] == Move.Scissors && playerMoves[player2] == Move.Paper)
        ) {
            emit GameResult(player1, player2, Result.Player1Wins);
        } else {
            emit GameResult(player1, player2, Result.Player2Wins);
        }
        
        // Reset the game
        playerMoves[player1] = Move.None;
        playerMoves[player2] = Move.None;
        hasPlayed[player1] = false;
        hasPlayed[player2] = false;
    }
}
