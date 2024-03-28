pragma circom 2

include "circomlib.sol";

// Define the input signals
template Move() {
    signal moveNone, moveRock, movePaper, moveScissors;
}

component Main = RockPaperScissors();

// Define RockPaperScissors component
component RockPaperScissors() {
    // Define input signals
    signal playerMoveNone, playerMoveRock, playerMovePaper, playerMoveScissors;
    signal proof[2];
    
    // Define constant signals for ZK proof
    signal provingKey[2];
    
    // Define output signal
    signal isValidProof;
    
    // Constraints for player's move
    // Player's move can only be one of the valid moves
    // Constraints for the ZK proof verification
    // Logic for verifying the ZK proof
    signal validMove = playerMoveNone | playerMoveRock | playerMovePaper | playerMoveScissors;
    signal validProof = and(validMove, provingKey[0] === proof[0] && provingKey[1] === proof[1]);
    
    // Gate for AND operation to check validity of player's move and proof
    isValidProof <== validProof;
}

// Template to map Solidity enums to signals
template SolidityEnumToSignal() {
    signal signalNone, signalRock, signalPaper, signalScissors;
}

// Template for Solidity enum mappings
SolidityEnumToSignal() -> Main.playerMoveNone;
SolidityEnumToSignal() -> Main.playerMoveRock;
SolidityEnumToSignal() -> Main.playerMovePaper;
SolidityEnumToSignal() -> Main.playerMoveScissors;
